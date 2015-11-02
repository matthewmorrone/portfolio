<html>
<head>
<title>Sudoku</title>
<link rel="stylesheet" type="text/css" href="styles.css" />  
</head>
<body>

<?php

error_reporting(0);
 
generate(2);

function generate($a)
{
	print('<table>');
	for($i = 0; $i < $a*$a; $i++) 
	{
		print('<tr>');
		for($j = 0; $j < $a*$a; $j++) 
		{
			$k = floor($j / $a) + floor($i / $a) * $a; 
			//$l = ($j % $a) + ($i % $a) * $a;
			$r = rand(1, $a*$a);
			if (!in_array($r, $su[$i]) and !in_array($r, $do[$j]) and !in_array($r, $ku[$k]))
			{
				$su[$i][] = $r; $do[$j][] = $r; $ku[$k][] = $r;
				print('<td id="'.$n.'">'.$r.'</td>'); $n++;
			}
			else {$j--;}
		}
		print('</tr>');
	}
	print('</table>');
}

function search($needle, $haystack) {if (!$haystack) {return true;} for($i = 0; $i < count($haystack); $i++) {if ($needle == $haystack[$i]) {return true;}}}
?>

<script type="text/javascript">
// 
// generate(2)
// 
// function generate(a)
// {
// 	var n = 0; var soo = mda(a*a); var doo = mda(a*a); var koo = mda(a*a);
// 	document.write('<table>')
// 	for(var i = 0; i < (a*a); i++) 
// 	{
// 		document.write('<tr>')
// 		for(var j = 0; j < (a*a); j++) 
// 		{
// 			//var k = Math.floor(j / a) + (Math.floor(i / a) * a) //var l = (j % a) + (i % a) * a;
// 			var m = Math.floor(Math.random() * (a*a)) + 1
// 			if (!search(m, soo[i])) //&& (!search(m, doo[j])) && (!search(m, koo[k])))
// 			{
// 				soo[i][j] = m; //doo[j][i] = m; //koo[k][l] = m;
// 				document.write('<td id='+n+'>'+m+'</td>')
// 				n++
// 			}
// 			else {j--}
// 		}
// 		document.write('</tr>')
// 	}
// 	document.write('</table>')
// }
// 
// function search(needle, haystack) {for(var i = 0; i < haystack.length; i++) {if (needle == haystack[i]) {return true}}}
// 
// function mda(d) {var i; var j; var a = new Array(d); for (i = 0; i < d; i++) {a[i] = new Array(d); for (j = 0; j < d; j++) {a[i][j] = "";}} return(a);} 
// 
</script>



<?php
// function r(a)
// {
//   $i = $a.find('0')
//   if $i == -1:
//     exit($a)
//   for $m in '%d' % 5**18:
//     $m in[($i-$j)%9*($i/9^$j/9)*($i/27^$j/27|$i%9/3^$j%9/3) or a[$j] for $j in range(81)] or r($a[:$i]+$m+$a[$i+1:])
// 	
// }
// function same_row($i, $j) {return ($i / 9 == $i / 9);}
// function same_col($i, $j) {return (($i - $j) % 9 == 0);}
// function same_sec($i, $j) {return (((($i / 27) == ($j / 27))) and ((($i % 9) / 3) == (($j % 9) / 3)));}
// 
// function r($a)
// {
// 	$i = in_array($a, '0');
// 	if ($i == -1) {return $a;}
// 
// 	$excluded_numbers = [];
// 	for (range(1, 9) as $j))
// 	{
// 		if same_row($i, $j) or same_col($i, $j) or same_sec($i, $j)
// 		{
// 			$excluded_numbers[] = $a[$j];
// 		}
// 	}
// 	
// 	for ("123456789" as $m))
// 	{
// 		if (!in_array($m, $excluded_numbers))
// 		{
// 			r($a[:$i].m.$a[$i+1:])
// 		}
// 	}
// }

// function row($cell) {
// 	return floor($cell / 4);
// }
// function col($cell) {
// 	return $cell % 4;
// }
// function sec($cell) {
// 	return floor(row($cell) / 2) * 2 + floor(col($cell) / 2);
// }
// function may_row($n, $row, $sudoku) {
// 	for($i = 0; $i <= 3; $i++) 
// 	{
// 		if($sudoku[$row * 3 + $i] == $n) {return false;}
// 	}
// 	return true;
// }
// function may_col($n, $col, $sudoku) {
// 	for($i = 0; $i <= 3; $i++) 
// 	{
// 		if($sudoku[$col + 4 * $i] == $n) {return false;}
// 	} 
// 	return true;
// }
// function may_sec($n, $sec, $sudoku) {
// 	for($i = 0; $i <= 3; $i++) 
// 	{
// 		if($sudoku[floor($sec / 2) * 16 + $i % 2 + 4 * floor($i / 2) + 2 * ($sec % 2)] == $n) {return false;}
// 	}	
// 	return true;
// }
// function may_cell($n, $cell, $sudoku) {
// 	return may_row($n, row($cell), $sudoku) and may_col($n, col($cell), $sudoku) and may_sec($n, sec($cell), $sudoku);
// }	
// function draw($sudoku) {
// 	$html = "<table>"; 
// 	for($i = 0; $i <= 3; $i++) 
// 	{
// 		$html .= "<tr>"; 
// 		for($j = 0; $j <= 3; $j++) 
// 		{
// 			$html.= "<td>".$sudoku[$i * 4 + $j]."</td>";
// 		} 
// 		$html .= "</tr>";
// 	} 
// 	$html .= "</table>"; 
// 	return $html;
// }
// function check_row($row, $sudoku) {
// 	for($i = 0; $i <= 3; $i++) 
// 	{
// 		$temp[$i] = $sudoku[$row * 3 + $i];
// 	} 
// 	return count(array_diff(array(1, 2, 3, 4), $temp)) == 0;
// } 
// function check_col($col, $sudoku) {
// 	for($i = 0; $i <= 3; $i++) 
// 	{
// 		$temp[$i] = $sudoku[$col + $i * 9];
// 	} 
// 	return count(array_diff(array(1, 2, 3, 4), $temp)) == 0;
// } 
// function check_sec($sec, $sudoku) {
// 	for($i = 0; $i <= 3; $i++) 
// 	{
// 		$temp[$i] = $sudoku[floor($sec / 2) * 16 + $i % 2 + 4 * floor($i / 2) + 2 * ($sec % 2)];
// 	} 
// 	return count(array_diff(array(1, 2, 3, 4), $temp)) == 0;
// }
// function solved($sudoku) {
// 	for($i = 0; $i <= 3; $i++)
// 	{
// 		if(!check_sec($i, $sudoku) or !check_row($i, $sudoku) or !check_col($i, $sudoku))
// 		{
// 			return false;
// 		}
// 	} 
// 	return true;
// }
// function possible($cell, $sudoku) {
// 	$p = array(); 
// 	for($i = 1; $i <= 4; $i++) 
// 	{
// 		if(may_cell($i, $cell, $sudoku))
// 		{
// 			array_unshift($p, $i);
// 		}
// 	} 
// 	return $p;
// }
// function random($p, $cell){
// 	return $p[$cell][rand(0, count($p[$cell]) - 1)];
// }
// function unique($sudoku) {
// 	for($i = 0; $i <= 15; $i++) 
// 	{
// 		if($sudoku[$i] == 0) 
// 		{
// 			$p[$i] = possible($i, $sudoku); 
// 			if(count($p[$i]) == 0)
// 			{
// 				return false;
// 			}
// 		}
// 	} 
// 	return($p);
// }
// function attempt($attempt, $n) {
// 	$new = array(); 
// 	for($i = 0; $i < count($attempt); $i++)
// 	{
// 		if($attempt[$i] != $n)
// 		{
// 			array_unshift($new, $attempt[$i]);
// 		}
// 	}
// 	return $new;
// }
// function print_possible($p) {
// 	$html = "<table>";
// 	for($i = 0; $i <= 3; $i++)
// 	{
// 		$html .= "<tr>";
// 		for($j = 0; $j <= 3; $j++)
// 		{
// 			$values = "";
// 			for($k = 0; $k <= count($p[$i * 4 + $j]); $k++)
// 			{
// 				$values .= $p[$i * 4 + $j][$k];
// 			}
// 			$html.= "<td>$values</td>";
// 		}
// 		$html .= "</tr>";
// 	}
// 	$html .= "</table>";
// 	return $html;
// }
// function next_random($p) {
// 	$max = 4; 
// 	for($i = 0; $i <= 15; $i++) 
// 	{
// 		if ((count($p[$i]) <= $max) and (count($p[$i]) > 0)) 
// 		{
// 			$max = count($p[$i]); 
// 			$min = $i;
// 		}
// 	} 
// 	return $min;
// }
// function solve($sudoku) {
// 	$start = microtime();
// 	$saved = array();	
// 	$backup = array();
// 	while(!solved($sudoku))
// 	{
// 		$x += 1;
// 		$next = unique($sudoku);
// 		if($next == false)
// 		{
// 			$next = array_pop($saved);
// 			$sudoku = array_pop($backup);
// 		}
// 		$try = next_random($next);	
// 		$attempt = random($next, $try);
// 		if(count($next[$try])>1)
// 		{					
// 			$next[$try] = attempt($next[$try], $attempt);
// 			array_push($saved, $next);
// 			array_push($backup, $sudoku);
// 		}
// 		$sudoku[$try] = $attempt;	
// 	}
// 	$end = microtime();
// 	$ms_start = explode(" ", $start);
// 	$ms_end = explode(" ", $end);
// 	$total_time = round(($ms_end[1] - $ms_start[1] + $ms_end[0] - $ms_start[0]), 2);
// 	echo "completed in $x steps in $total_time seconds";
// 	echo draw($sudoku);
// }
// 
// solve($sudoku);
?>

</body>
</html>