<?php

define('FILENAME','sample');


define('FILE_IN',FILENAME.'.in');
define('FILE_OUT',FILENAME.'.out');


$rawData = file_get_contents(FILE_IN);


$lines = explode("\n",$rawData);

$nLine = $lines[0];

$output = '';

for ($i=1; $i <= $nLine; $i++) {
  $line = $lines[$i];
  $row = explode(' ', $line);
  $friendNeed = getMyFriends($row[1]);

  $output .= "Case #$i: $friendNeed\n";
}

file_put_contents(FILE_OUT,$output);


function getMyFriends($sRates) {
  $n = strlen($sRates);
  $accumPeople = 0;
  $friendNeed = 0;
  for($sRate=0 ; $sRate<$n ; $sRate++) {
    $nPeople = $sRates[$sRate];

    if($accumPeople < $sRate) {
      $peopleDiff  = $sRate - $accumPeople;
      $friendNeed += $peopleDiff;
      $accumPeople += $peopleDiff;
    }
    $accumPeople += $nPeople;
  }

  return $friendNeed;
}

?>
