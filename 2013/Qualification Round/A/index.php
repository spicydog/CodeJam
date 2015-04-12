<?php 

$filename = 'A-large';
$input = file_get_contents( $filename . '.in' );
$lines = explode("\n", $input);


$print['X'] = 'X won';
$print['D'] = 'Draw';
$print['N'] = 'Game has not completed';
$print['O'] = 'O won';


$line_i = 0;
$T = $lines[ $line_i++ ];

for( $i=0 ; $i<$T ; $i++ )
{
	unset($data);
	for( $j=0 ; $j<=3 ; $j++ )
	{
		$data[$j] = str_split( $lines[ $line_i++ ] );
	}
	$line_i++;

	$output .= 'Case #' . ($i+1) . ': '. $print[calculate($data)] . "\n";

}


echo $output;

file_put_contents( $filename . '.out' , $output);





function calculate($data)
{
	$last = 0;
	$dot = FALSE;

	for($i=0;$i<4;$i++)
	{
		unset($col);
		unset($row);
		for($j=0;$j<4;$j++)
		{
			$row[$j] = $data[$i][$j];
			$col[$j] = $data[$j][$i];
			if( $data[$j][$i] == '.' )
				$dot = TRUE;
		}	

		$result[check($row)]++;
		$result[check($col)]++;

		$cross1[$i] = $data[$i][$i];
		$cross2[$i] = $data[3-$i][$i];
	}

	$result[check($cross1)]++;
	$result[check($cross2)]++;

	if( $result['O'] >= 1 )
		$output = 'O';
	else if( $result['X'] >= 1 )
		$output = 'X';
	else if( $result['D'] == 10 )
		if( $dot )
			$output = 'N';
		else
			$output = 'D';

	//print_r($result);
	return $output;

}

function check($arr)
{
	$O = 0;
	$X = 0;

	// Check for O
	for($i=0;$i<4;$i++) if( $arr[$i] == 'O' || $arr[$i] == 'T' ) $O++;
	if($O==4) return 'O';

	// Check for X
	for($i=0;$i<4;$i++) if( $arr[$i] == 'X' || $arr[$i] == 'T' ) $X++;
	if($X==4) return 'X';

	return "D";

}	

?>