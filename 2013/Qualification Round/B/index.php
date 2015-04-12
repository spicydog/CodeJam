<?php 

$filename = 'B-large';
$input = file_get_contents( $filename . '.in' );
$lines = explode("\n", $input);

$line_i = 0;
$T = $lines[ $line_i++ ];

for( $i=0 ; $i<$T ; $i++ )
{
	unset($data);
	$hw = explode(' ', $lines[ $line_i++ ] );
	for( $j=0 ; $j<$hw[0] ; $j++ )
	{
		$data[$j] = explode(' ', $lines[ $line_i++ ] );
	}
	if ( calculate($data,$hw) )
		$output .= 'Case #' . ($i+1) . ': YES' . "\n";
	else
		$output .= 'Case #' . ($i+1) . ': NO' . "\n";
	

}

echo $output;

file_put_contents( $filename . '.out' , $output);




function calculate($data,$hw)
{
	for($i=0;$i<$hw[0];$i++)
	{
		
		for($j=0;$j<$hw[1];$j++)
		{
			unset($h);
			unset($v);

			for($k=0;$k<$hw[0];$k++)
				$v[] = $data[$k][$j];

			for($k=0;$k<$hw[1];$k++)
				$h[] = $data[$i][$k];

			if( $data[$i][$j]>=max($h) ||  $data[$i][$j]>=max($v) )
				continue;
			else
				return FALSE;
		}
		
	}
	return TRUE;
}


?>