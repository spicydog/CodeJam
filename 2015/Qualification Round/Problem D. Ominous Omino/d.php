<?php

define('FILENAME','D-large');


define('FILE_IN',FILENAME.'.in');
define('FILE_OUT',FILENAME.'.out');


$rawData = file_get_contents(FILE_IN);

$lines = explode("\n",$rawData);

$nLine = $lines[0];

$output = '';

for ($i=1; $i <= $nLine; $i++) {
  $line = $lines[$i];
  $row = explode(' ', $line);
  $isRichardWin = checkRichardWin($row[0],$row[1],$row[2]);

  $output .= "Case #$i: " . ($isRichardWin ? 'RICHARD' : 'GABRIEL') . "\n";
}

echo $output;
file_put_contents(FILE_OUT,$output);


function checkRichardWin($x,$r,$c) {

  if($r>$c) {
    $s = $r;
    $r = $c;
    $c = $s;
  }

  if( ($r*$c)%$x > 0) {
    return true;
  } else {
    return $x>=3 && intval($x/2)>=$r;
  }

}

?>
