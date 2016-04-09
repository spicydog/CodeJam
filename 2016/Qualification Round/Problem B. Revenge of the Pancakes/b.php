<?php

$fileName = 'B-large';
$inputFile = "$fileName.in";
$outputFile = "$fileName.out";

$raw = file_get_contents($inputFile);

$cases = explode("\n", $raw);
unset($cases[0]); // No need to consider number of cases

$outputData = '';
foreach ($cases as $i => $case) {
	if (strlen($case) > 0) {
		$output = sprintf("Case #%d: %d\n", $i, countFlip($case));
		echo $output;
		$outputData .= $output;
	}
}
file_put_contents($outputFile, $outputData);

function countFlip($case) {
	$len = strlen($case);
	$lastChar = $case[0];
	$n = intval($case[$len-1] === '-');

	for ($i=1; $i < $len; $i++) { 
		if ($lastChar !== $case[$i]) {
			$n++;
		}
		$lastChar = $case[$i];
	}
	return $n;
}