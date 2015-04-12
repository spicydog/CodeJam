<?php 

$filename = 'A-large';
$input = file_get_contents( $filename . '.in' );
$lines = explode("\n", $input);

$line_i = 0;
$T = $lines[ $line_i++ ];
$output  = '';
for( $i=0 ; $i<$T ; $i++ )
{
	echo $i+1 . "\n";
	unset($data);
	$data[0] = explode(' ', $lines[ $line_i++ ] );
	$data[1] = explode(' ', $lines[ $line_i++ ] );

	$result = compute($data[0][0],$data[0][1],$data[1]);

	$output .= 'Case #' . ($i+1) .': ' .$result . "\n";
}
echo "\n" . $output;

 file_put_contents( $filename . '.out' , $output);


function consume($armin,$n,$target)
{
	$k = 0;
	for($i=0;$i<sizeof($target);$i++)
	{
		if( $armin > $target[$i] )
		{
			$armin+=$target[$i];
		}
		else
		{
			while($armin<=$target[$i])
			{
				echo $armin.','.$target[$i].' ';
				$k++;
				$armin+=$armin-1;
			}
			$armin+=$target[$i];
		}
		echo $armin.'.'.$k.' ';
	}
	echo "\n";
	return $k;
}

function compute($armin,$n,$target)
{
	if( $armin<=1 )
		return sizeof($target);

	sort($target);
	$k=0;
	for($i=$n-1;$i>=0;$i--)
	{
		$extra_food = consume($armin,$n,$target);
		$result[] = $extra_food + $k;
		$k++;
		if($extra_food==0 )
			break;
		unset($target[$i]);
		//print_r($target);
	}
	$result[] = $k;

	print_r($result);
	return min($result);
}


?>