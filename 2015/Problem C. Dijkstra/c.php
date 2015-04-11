<?php

define('FILENAME','C-small-attempt0');


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

  echo $print = $i  . 'Case #'.($i/2).': ' . (isDijkstra($str,$repeat)? 'YES' : 'NO') . "\n";
  $output .= $print;

}

file_put_contents(FILE_OUT,$output);


function isDijkstra($str,$repeat) {

  $init = 0;
  $diff = 0;

  for($i=1;$i<=$repeat;$i++) {
    $isFound = checkDijkstra($str,$i);
    if($isFound) {
      if($init==0) {
        $init = $i;
      } else {
        $diff = $i-$init;
        break;
      }
    }
  }

  if($init>0 && $diff==0 && $repeat==$init) {
    // Exact found
    echo "1\n";
    return true;
  } else if($init>0 && $diff>0) {
    // Found via calculation
    echo "2\n";
    return true;
  } else {
    // Not found
    echo "0\n";
    return false;
  }
}




function checkDijkstra($str,$repeat) {

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


  return $str == 'ijk';

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