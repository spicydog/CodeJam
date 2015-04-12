<?php


define('FILENAME','C-large');


define('FILE_IN',FILENAME.'.in');
define('FILE_OUT',FILENAME.'.out');



global $table;
$table = [];
$table['i']['j'] = 'k';
$table['i']['k'] = '-j';

$table['j']['i'] = '-k';
$table['j']['k'] = 'i';

$table['k']['i'] = 'j';
$table['k']['j'] = '-i';




$rawData = file_get_contents(FILE_IN);

$lines = explode("\n",$rawData);

$nLine = $lines[0];

$output = '';

for ($i=1; $i <= $nLine*2; $i++) {
  $line = $lines[$i];
  $row = explode(' ', $line);
  $repeat = $row[1];
  $str = $lines[++$i];


  if(($i/2)<73) {
    // continue;
  }
  echo $print = 'Case #'.($i/2).': ' . (isDijkstra($str,$repeat)? 'YES' : 'NO') . "\n";
  $output .= $print;

}

file_put_contents(FILE_OUT,$output);


function isDijkstra($str,$repeat) {

  $init = 0;
  $diff = 0;


  $lastResult = '';
  $sameResultCount = 0;
  $results[0] = '';
  for($i=1;$i<=$repeat;$i++) {

    $result = getDijkstra($str,$i);

    $results[$i] = $result;

    $isFound = false;
    if($result=='ijk') {
      $isFound = true;
    }

    // Fing pattern
    if($isFound) {
      if($init==0) {
        $init = $i;
      } else {
        // Found a pattern
        $diff = $i-$init;
        break;
      }
    }

    // Find repeat result
    if(getLastRepeatingArray($results)>5) {
      break;
    }

    // Find repeat pattern
    // we will check lately because it consume so much CPU,
    // and it will return better result when the string if long enough
    if($i>250) {
      $largestRepeatCount = getLargestRepeatingStringCount($results);
      if($largestRepeatCount>5) {
        break;
      }
    }

  }

  if($init>0 && $diff==0 && $repeat==$init) {
    // Exact found
    return true;
  } else if($init>0 && $diff>0) {
    // Found via calculation
    return ($repeat - $init) % $diff == 0;
  } else {
    // Not found
    return false;
  }
}

function getLastRepeatingArray($results) {
  $lastIndex = count($results)-1;
  $lastestResult = $results[$lastIndex];
  $countRepeat = 0;
  for($i=$lastIndex;$i>=0;$i--) {
    if($lastestResult == $results[$i]) {
      $countRepeat++;
    } else {
      break;
    }
  }
  return $countRepeat;
}

function getLargestRepeatingStringCount($words) {

  $str = implode($words);
  $results = getRepeatStrings($str);
  $max = 0;
  if(isset(array_values($results)[0])) {
    $max = array_values($results)[0];
  }
  return $max;
}

// This function is super useful but consume high CPU power
function getRepeatStrings($str) {

  $results = [];
  for($i=strlen($str)-1;$i>0;$i--) {

    $substring = substr($str,$i);

    $pass = true;
    $left = $str;
    $count = 0;
    while($pass) {
      $checkSubstring = substr($left,strlen($left)-strlen($substring));
      if($checkSubstring==$substring) {
        $left = substr($left,0,-strlen($substring));
        $count++;
      } else {
        $pass = false;
      }
    }

    $results[$substring] = $count;
  }

  arsort($results);

  return $results;
}

function getDijkstra($str,$repeat) {

  $lastChar = $str[0];
  $passCheckChar = false;
  for($i=1;$i<strlen($str);$i++) {
    if($lastChar!=$str[$i]) {
      $passCheckChar = true;
    }
  }

  if(!$passCheckChar) {
    return false;
  }

  $str = str_repeat($str, $repeat);

  $offset = 0;
  while(strlen($str)>3) {

    if(!isset($str[$offset+1])) {
      break;
    }
    if($str[$offset+0]=='-' && $str[$offset+1]!='-') {
      if(!isset($str[$offset+2])) {
        break;
      }
      $str = substr($str,0,$offset) . '-' . mixChar($str[$offset+1],$str[$offset+2]) . substr($str,$offset+3);
    } else {
      $str = substr($str,0,$offset) . mixChar($str[$offset+0],$str[$offset+1]) . substr($str,$offset+2);
    }

    if($offset==0 && isset($str[$offset]) && $str[$offset]=='i') {
      $offset++;
    }
    if($offset==1 && isset($str[$offset]) && $str[$offset]=='j') {
      $offset++;
    }
    if($offset==2 && isset($str[$offset]) && $str[$offset]=='k') {
      $offset++;
    }
  }

  return $str;

}



function mixChar($x,$y) {

  if($x=='1') {
    return $y;
  }
  if($y=='1') {
    return $x;
  }

  if($x==$y) {
    return $x!='-' ? '-':'';
  }

  global $table;
  return $table[$x][$y];

}

?>
