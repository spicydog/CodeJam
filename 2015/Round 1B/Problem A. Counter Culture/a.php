<?php
ini_set('memory_limit', '-1');
define('FILENAME','A-small-attempt0');


define('FILE_IN',FILENAME.'.in');
define('FILE_OUT',FILENAME.'.out');


$rawData = file_get_contents(FILE_IN);


$lines = explode("\n",$rawData);

$nLine = $lines[0];

$output = '';

for ($i=1; $i <= $nLine; $i++) {
  $x = $lines[$i];
  $y = a($x);

  echo $result = "Case #$i: $y\n";
  $output .= $result;
}

file_put_contents(FILE_OUT,$output);


$GLOBALS['mem'] = [];
function a($x) {

  if(isset($GLOBALS['mem'][$x])) {
    return $GLOBALS['mem'][$x];
  }

  if($x<20) {
    return $x;
  }

  $cr = -1;
  if($x%10!=0 && strrev($x)<$x) {
    $cr = a(strrev($x))+1;
  }

  $cn = a($x-1)+1;

  if($cr>0) {
    $GLOBALS['mem'][$x] = $cr<$cn ? $cr : $cn;
  } else {
    $GLOBALS['mem'][$x] = $cn;
  }

  return $GLOBALS['mem'][$x];
}

?>
