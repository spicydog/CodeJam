<?php

$fileName = 'A-large';
$inputFile = "$fileName.in";
$outputFile = "$fileName.out";

$raw = file_get_contents($inputFile);

$ns = explode("\n", $raw);
unset($ns[0]); // No need to consider number of cases

$outputData = '';
foreach ($ns as $i => $n) {
	if (strlen($n) > 0) {
		$output = sprintf("Case #%d: %s\n", $i, strval(sleepNumber($n)));
		echo $output;
		$outputData .= $output;
	}
}
file_put_contents($outputFile, $outputData);

function sleepNumber($n) {
	$n = intval($n);
	$digits = [];
	if ($n > 0) {
		for ($i=1; $i < 1000000; $i++) {
			$counting = $n * $i;
			if (isAsleep($counting, $digits)) {
				return $counting;		
			}
		}
	}
	return 'INSOMNIA';
}

function isAsleep($n, &$digits) {
	$str = strval($n);
	$len = strlen($str);
	for ($i=0; $i < $len; $i++) {
		$digits[$str[$i]] = true;
	}
	return count($digits) === 10;
}