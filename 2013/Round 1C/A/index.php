<?php 

$filename = 'A-large';
$input = file_get_contents( $filename . '.in' );
$lines = explode("\n", $input);




$line_i = 0;
$T = $lines[ $line_i++ ];
$output  = '';
for( $i=0 ; $i<$T ; $i++ )
{

	$data = explode(' ',$lines[ $line_i++ ]);
	$result = compute($data[0],$data[1]);

	$output .= 'Case #' . ($i+1) .': ' .$result . "\n";

file_put_contents( $filename . '.out' , $output);
}

echo $output;
file_put_contents( $filename . '.out' , $output);




function compute($name,$n)
{	
	$vowels = array('a','e','i','o','u');
	$l = strlen($name);
	$count_n_value = 0;

	for($i=0;$i<$l-$n+1;$i++)
	{
		for($j=$l;$j>$i;$j--)
		{
			$str = '';
			$n_value = 0;
			for($k=$i;$k<$j;$k++)
			{
				$chr = $name[$k];
				if( !in_array($chr, $vowels) )
				{
					if( ++$n_value >= $n )
					{
						break;
					}
				}
				else
				{
					$n_value = 0;
				}

				$str .= $chr;
			}
			if($n_value>=$n)
			{
				$count_n_value++;
			}

			//echo "$n_value $str \n";
		}
	}

	return $count_n_value;
}




// 	123456
// 1	tsetse	0	6
// 2	tsets	0	5
// 3	tset	0	4
// 4	tse		0	3
// 5	ts		0	2
// 6	sets	2	5
// 7	setse	2	6
// 8	ets		3	5
// 9	etse	3	6
// 10	tse		4	6
// 11	ts		4	5
?>

