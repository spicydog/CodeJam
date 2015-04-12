<?php 

$filename = 'C-small-attempt0';
$input = file_get_contents( $filename . '.in' );
$lines = explode("\n", $input);


$line_i = 0;
$T = $lines[ $line_i++ ];

for( $i=0 ; $i<$T ; $i++ )
{
	$data = explode(' ', $lines[ $line_i++ ]);

	$output .= 'Case #' . ($i+1) . ': '. calculate( $data[0], $data[1] ) . "\n";
	echo "\n";
}


echo $output;

file_put_contents( $filename . '.out' , $output);




function calculate($from,$to)
{
	$n = 0;
	//fine first sqrtable

	$base = $from;
	while( sqrt($base++) != floor( sqrt($base) ) );
	$base = sqrt($base-1);

	while( pow($base,2) <= $to )
	{
		if( is_palindrome( pow($base,2) ) && is_palindrome( $base ) )
		{
			$n++;
			echo $base . ' ' . pow($base,2) . "\n";
		}
		$base++;
	}


	return $n;
}

function is_palindrome($no)
{
	$data = str_split($no);
	$reverse = array_reverse( $data );
	return $data === $reverse;
}	

?>