<?php
	session_start();
	error_reporting(0);

function check($a)
{$a=str_replace(":", "", $a);
	print $a."<br/>";
	for($i=0; $i=4; $i++) {for($j=0; $j=4; $j++) {if (!in_array($a[$n], $su[$i])) {$su[$i][]=$a[$n];} else {return false;} $n++;}}
	for($i=0; $i=4; $i++) {for($j=0; $j=16; $j+=4) {$k=($i+$j); if (!in_array($a[$k], $do[$i])) {$do[$i][]=$a[$n];}	else {return false;}}}
	for($j=0; $j=16; $j+=8) {for($i=$j; $i=$j+4; $i+=2) {
		if (!in_array($a[$i], $ku[$k])) {$ku[$k][]=$a[$i];} 				else {return false;}
		if (!in_array($a[($i+1)], $ku[$k])) {$ku[$k][]=$a[$a[($i+1)]];} 	else {return false;}
		if (!in_array($a[($i+4)], $ku[$k])) {$ku[$k][]=$a[$a[($i+1)]];} 	else {return false;}
		if (!in_array($a[($i+5)], $ku[$k])) {$ku[$k][]=$a[$a[($i+1)]];} 	else {return false;}
		$k++;}$k++;}}

function generated($a)
{
	$b=str_replace(":", "<br />", $a);
	print $b."<br />";
	$a=str_replace(":", "", $a);
	print "<br />";
	for($i=0; $i=4; $i++) {for($j=0; $j=4; $j++) {print $a[$n]." "; $n++;} print "<br />";} print "<br />";
	for($i=1; $i<=4; $i++) {for($j=0; $j=16; $j+=4) {$k=($i+$j-1); print $a[$k]." ";} print "<br />";} print "<br />";
	for($j=0; $j=16; $j+=8) {for($i=$j; $i=$j+4; $i+=2) {print $a[$i]." ".$a[($i+1)]." ".$a[($i+4)]." ".$a[($i+5)]." "; print "<br />";}} print "<br />";	
}
		
	$init_text_field;	
	$red = "#FF0000";
	$valid = 1;
	if(isSet($_SESSION['choices'])){
	
		$choices = $_SESSION['choices'];
	
		if(isSet($_POST['buttons'])){
			$which_button = $_POST['buttons'];
			array_push($choices, $which_button);
			$_SESSION['choices'] = $choices;
		}
	} else {
		$_SESSION['choices'] = array();
	}
	
	if(isSet($_POST['clear'])){
		$_SESSION['choices'] = array();
	}
	
	if(isSet($_POST['undo'])){
		$choices = $_SESSION['choices'];
		
		array_pop($choices);
		
		$_SESSION['choices'] = $choices;
	}
	
	if(isSet($_POST['board_init'])){
	
		$board = strtolower($_POST['board_init']);
		$_SESSION['board'] = $board;
		$pattern = "/[x1234]{4}:[x1234]{4}:[x1234]{4}:[x1234]{4}/";
		
		if(preg_match($pattern, $board) == 0){
			$init_text_field = "invalid board move";						
		}else{
			$board_array = explode(":",$board);
			$first_quad = $board_array[0];
			$second_quad = $board_array[1];
			$third_quad = $board_array[2];
			$fourth_quad = $board_array[3];
			
			/* initialize board by row */
			$array_row0 = array();
			$array_row1 = array();
			$array_row2 = array();
			$array_row3 = array();
			/***************************/
			
			/******* set up 2d array by rows *******/
			array_push($array_row0, $first_quad[0]);
			array_push($array_row0, $first_quad[1]);
			array_push($array_row0, $second_quad[0]);
			array_push($array_row0, $second_quad[1]);
			
			array_push($array_row1, $first_quad[2]);
			array_push($array_row1, $first_quad[3]);
			array_push($array_row1, $second_quad[2]);
			array_push($array_row1, $second_quad[3]);		
			
			array_push($array_row2, $third_quad[0]);
			array_push($array_row2, $third_quad[1]);
			array_push($array_row2, $fourth_quad[0]);
			array_push($array_row2, $fourth_quad[1]);
			
			array_push($array_row3, $third_quad[2]);
			array_push($array_row3, $third_quad[3]);
			array_push($array_row3, $fourth_quad[2]);
			array_push($array_row3, $fourth_quad[3]);
			/****************************************/
			
			/* following code initializes the board if it's a valid board setup	*/	
			$board_2d = array($array_row0,$array_row1,$array_row2,$array_row3);
			$choices = array();
			
			for($i = 0; $i<4; $i++){
			
				for($j = 0; $j<4; $j++){
					array_push($choices, "$i"."$j".$board_2d[$i][$j]);
					$_SESSION['choices'] = $choices;
				}
			}
			/*********************************************************************/
			}
		
		
	}
	
	
?>

<?php


?>



<html>
<head> <title> Sudoku </title> </head>
<body>
<center><font size="12" face="Times">Sudoku</font></center>

<form name="table" action="sudoku.php" method="post">
	<table border="1" width = "600" height = "400" align = "center">
	<tr>
			<td>
			<table border="1" height = "170" width = "270" align = "center">
				<tr>
				<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("001", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("002", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("003", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("004", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>									
									<tr>
										<?php if((in_array("111", $_SESSION['choices'])) | (in_array("011", $_SESSION['choices'])) | (in_array("021", $_SESSION['choices'])) | (in_array("031", $_SESSION['choices'])) | (in_array("101", $_SESSION['choices'])) | (in_array("201", $_SESSION['choices'])) | (in_array("301", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>
											<td><input type="radio" name="buttons" value="001"/>1</td>
										<?php }	?>
										
										<?php if((in_array("112", $_SESSION['choices'])) |(in_array("102", $_SESSION['choices'])) | (in_array("202", $_SESSION['choices'])) | (in_array("302", $_SESSION['choices'])) | (in_array("012", $_SESSION['choices'])) | (in_array("022", $_SESSION['choices'])) | (in_array("032", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>										
											<td><input type="radio" name="buttons" value="002"/>2</td>
										<?php }	?>											
									</tr>
									
									<tr>
										<?php if((in_array("113", $_SESSION['choices'])) |(in_array("103", $_SESSION['choices'])) | (in_array("203", $_SESSION['choices'])) | (in_array("303", $_SESSION['choices'])) | (in_array("013", $_SESSION['choices'])) | (in_array("023", $_SESSION['choices'])) | (in_array("033", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="003"/>3</td>
										<?php }	?>											
											
										<?php if((in_array("114", $_SESSION['choices'])) |(in_array("014", $_SESSION['choices'])) | (in_array("024", $_SESSION['choices'])) | (in_array("034", $_SESSION['choices'])) | (in_array("104", $_SESSION['choices'])) | (in_array("204", $_SESSION['choices'])) | (in_array("304", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="004"/>4</td>
										<?php }	?>											
									</tr>
									
									<?php } ?>
									</table>
							</td>
			
							<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("011", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("012", $_SESSION['choices'])){
										?> <center><font  size="20" face="Times">2</font></center><?php
										}elseif(in_array("013", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("014", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>									
									<tr>
									
										<?php if((in_array("101", $_SESSION['choices'])) |(in_array("001", $_SESSION['choices'])) | (in_array("021", $_SESSION['choices'])) | (in_array("031", $_SESSION['choices'])) | (in_array("111", $_SESSION['choices'])) | (in_array("211", $_SESSION['choices'])) | (in_array("311", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="011"/>1</td>
										<?php }	?>					
										
										<?php if((in_array("102", $_SESSION['choices'])) |(in_array("002", $_SESSION['choices'])) | (in_array("022", $_SESSION['choices'])) | (in_array("032", $_SESSION['choices'])) | (in_array("112", $_SESSION['choices'])) | (in_array("212", $_SESSION['choices'])) | (in_array("312", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="012"/>2</td>
										<?php }	?>
										
									</tr>
									
									<tr>
									
										<?php if((in_array("103", $_SESSION['choices'])) |(in_array("003", $_SESSION['choices'])) | (in_array("023", $_SESSION['choices'])) | (in_array("033", $_SESSION['choices'])) | (in_array("113", $_SESSION['choices'])) | (in_array("213", $_SESSION['choices'])) | (in_array("313", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>										
											<td><input type="radio" name="buttons" value="013"/>3</td>
										<?php }	?>											
											
										<?php if((in_array("104", $_SESSION['choices'])) |(in_array("004", $_SESSION['choices'])) | (in_array("024", $_SESSION['choices'])) | (in_array("034", $_SESSION['choices'])) | (in_array("114", $_SESSION['choices'])) | (in_array("214", $_SESSION['choices'])) | (in_array("314", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>												
											<td><input type="radio" name="buttons" value="014"/>4</td>
										<?php }	?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							</tr>

				<tr>
				<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("101", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("102", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("103", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("104", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>									
									<tr>
									
										<?php if((in_array("011", $_SESSION['choices'])) |(in_array("111", $_SESSION['choices'])) | (in_array("121", $_SESSION['choices'])) | (in_array("131", $_SESSION['choices'])) | (in_array("001", $_SESSION['choices'])) | (in_array("201", $_SESSION['choices'])) | (in_array("301", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="101"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("012", $_SESSION['choices'])) |(in_array("112", $_SESSION['choices'])) | (in_array("122", $_SESSION['choices'])) | (in_array("132", $_SESSION['choices'])) | (in_array("002", $_SESSION['choices'])) | (in_array("202", $_SESSION['choices'])) | (in_array("302", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="102"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("013", $_SESSION['choices'])) |(in_array("113", $_SESSION['choices'])) | (in_array("123", $_SESSION['choices'])) | (in_array("133", $_SESSION['choices'])) | (in_array("003", $_SESSION['choices'])) | (in_array("203", $_SESSION['choices'])) | (in_array("303", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="103"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("014", $_SESSION['choices'])) |(in_array("114", $_SESSION['choices'])) | (in_array("124", $_SESSION['choices'])) | (in_array("134", $_SESSION['choices'])) | (in_array("004", $_SESSION['choices'])) | (in_array("204", $_SESSION['choices'])) | (in_array("304", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="104"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							
							<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("111", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("112", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("113", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("114", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("001", $_SESSION['choices'])) |(in_array("101", $_SESSION['choices'])) | (in_array("121", $_SESSION['choices'])) | (in_array("131", $_SESSION['choices'])) | (in_array("011", $_SESSION['choices'])) | (in_array("211", $_SESSION['choices'])) | (in_array("311", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="111"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("002", $_SESSION['choices'])) |(in_array("102", $_SESSION['choices'])) | (in_array("122", $_SESSION['choices'])) | (in_array("132", $_SESSION['choices'])) | (in_array("012", $_SESSION['choices'])) | (in_array("212", $_SESSION['choices'])) | (in_array("312", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="112"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("003", $_SESSION['choices'])) |(in_array("103", $_SESSION['choices'])) | (in_array("123", $_SESSION['choices'])) | (in_array("133", $_SESSION['choices'])) | (in_array("013", $_SESSION['choices'])) | (in_array("213", $_SESSION['choices'])) | (in_array("313", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="113"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("004", $_SESSION['choices'])) |(in_array("104", $_SESSION['choices'])) | (in_array("124", $_SESSION['choices'])) | (in_array("134", $_SESSION['choices'])) | (in_array("014", $_SESSION['choices'])) | (in_array("214", $_SESSION['choices'])) | (in_array("314", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="114"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							</tr>
					</table>
		</td>
					
	<td>
			<table border="1" height = "170" width = "270" align = "center">
				<tr>
				<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("021", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("022", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("023", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("024", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("131", $_SESSION['choices'])) |(in_array("001", $_SESSION['choices'])) | (in_array("011", $_SESSION['choices'])) | (in_array("031", $_SESSION['choices'])) | (in_array("121", $_SESSION['choices'])) | (in_array("221", $_SESSION['choices'])) | (in_array("321", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="021"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("132", $_SESSION['choices'])) |(in_array("002", $_SESSION['choices'])) | (in_array("012", $_SESSION['choices'])) | (in_array("032", $_SESSION['choices'])) | (in_array("122", $_SESSION['choices'])) | (in_array("222", $_SESSION['choices'])) | (in_array("322", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="022"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("133", $_SESSION['choices'])) |(in_array("003", $_SESSION['choices'])) | (in_array("013", $_SESSION['choices'])) | (in_array("033", $_SESSION['choices'])) | (in_array("123", $_SESSION['choices'])) | (in_array("223", $_SESSION['choices'])) | (in_array("323", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="023"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("134", $_SESSION['choices'])) |(in_array("004", $_SESSION['choices'])) | (in_array("014", $_SESSION['choices'])) | (in_array("034", $_SESSION['choices'])) | (in_array("124", $_SESSION['choices'])) | (in_array("224", $_SESSION['choices'])) | (in_array("324", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="024"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
			
							<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("031", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("032", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("033", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("034", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("121", $_SESSION['choices'])) |(in_array("001", $_SESSION['choices'])) | (in_array("011", $_SESSION['choices'])) | (in_array("021", $_SESSION['choices'])) | (in_array("131", $_SESSION['choices'])) | (in_array("231", $_SESSION['choices'])) | (in_array("331", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>										
											<td><input type="radio" name="buttons" value="031"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("122", $_SESSION['choices'])) |(in_array("002", $_SESSION['choices'])) | (in_array("012", $_SESSION['choices'])) | (in_array("022", $_SESSION['choices'])) | (in_array("132", $_SESSION['choices'])) | (in_array("232", $_SESSION['choices'])) | (in_array("332", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="032"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("123", $_SESSION['choices'])) |(in_array("003", $_SESSION['choices'])) | (in_array("013", $_SESSION['choices'])) | (in_array("023", $_SESSION['choices'])) | (in_array("133", $_SESSION['choices'])) | (in_array("233", $_SESSION['choices'])) | (in_array("333", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="033"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("124", $_SESSION['choices'])) |(in_array("004", $_SESSION['choices'])) | (in_array("014", $_SESSION['choices'])) | (in_array("024", $_SESSION['choices'])) | (in_array("134", $_SESSION['choices'])) | (in_array("234", $_SESSION['choices'])) | (in_array("334", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="034"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							</tr>

				<tr>
				<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("121", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("122", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("123", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("124", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("031", $_SESSION['choices'])) |(in_array("101", $_SESSION['choices'])) | (in_array("111", $_SESSION['choices'])) | (in_array("131", $_SESSION['choices'])) | (in_array("021", $_SESSION['choices'])) | (in_array("221", $_SESSION['choices'])) | (in_array("321", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="121"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("032", $_SESSION['choices'])) |(in_array("102", $_SESSION['choices'])) | (in_array("112", $_SESSION['choices'])) | (in_array("132", $_SESSION['choices'])) | (in_array("022", $_SESSION['choices'])) | (in_array("222", $_SESSION['choices'])) | (in_array("322", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="122"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("033", $_SESSION['choices'])) |(in_array("103", $_SESSION['choices'])) | (in_array("113", $_SESSION['choices'])) | (in_array("133", $_SESSION['choices'])) | (in_array("023", $_SESSION['choices'])) | (in_array("223", $_SESSION['choices'])) | (in_array("323", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="123"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("034", $_SESSION['choices'])) |(in_array("104", $_SESSION['choices'])) | (in_array("114", $_SESSION['choices'])) | (in_array("134", $_SESSION['choices'])) | (in_array("024", $_SESSION['choices'])) | (in_array("224", $_SESSION['choices'])) | (in_array("324", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="124"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							
							<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("131", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("132", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("133", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("134", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("021", $_SESSION['choices'])) |(in_array("101", $_SESSION['choices'])) | (in_array("111", $_SESSION['choices'])) | (in_array("121", $_SESSION['choices'])) | (in_array("031", $_SESSION['choices'])) | (in_array("231", $_SESSION['choices'])) | (in_array("331", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>										
											<td><input type="radio" name="buttons" value="131"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("022", $_SESSION['choices'])) |(in_array("102", $_SESSION['choices'])) | (in_array("112", $_SESSION['choices'])) | (in_array("122", $_SESSION['choices'])) | (in_array("032", $_SESSION['choices'])) | (in_array("232", $_SESSION['choices'])) | (in_array("332", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="132"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("023", $_SESSION['choices'])) |(in_array("103", $_SESSION['choices'])) | (in_array("113", $_SESSION['choices'])) | (in_array("123", $_SESSION['choices'])) | (in_array("033", $_SESSION['choices'])) | (in_array("233", $_SESSION['choices'])) | (in_array("333", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="133"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("024", $_SESSION['choices'])) |(in_array("104", $_SESSION['choices'])) | (in_array("114", $_SESSION['choices'])) | (in_array("124", $_SESSION['choices'])) | (in_array("034", $_SESSION['choices'])) | (in_array("234", $_SESSION['choices'])) | (in_array("334", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="134"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							</tr>
					</table>
		</td>
	</tr>

	<tr>
	<td>
			<table border="1" height = "170" width = "270" align = "center">
				<tr>
				<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("201", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("202", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("203", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("204", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("311", $_SESSION['choices'])) |(in_array("211", $_SESSION['choices'])) | (in_array("221", $_SESSION['choices'])) | (in_array("231", $_SESSION['choices'])) | (in_array("001", $_SESSION['choices'])) | (in_array("101", $_SESSION['choices'])) | (in_array("301", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="201"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("312", $_SESSION['choices'])) |(in_array("212", $_SESSION['choices'])) | (in_array("222", $_SESSION['choices'])) | (in_array("232", $_SESSION['choices'])) | (in_array("002", $_SESSION['choices'])) | (in_array("102", $_SESSION['choices'])) | (in_array("302", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="202"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("313", $_SESSION['choices'])) |(in_array("213", $_SESSION['choices'])) | (in_array("223", $_SESSION['choices'])) | (in_array("233", $_SESSION['choices'])) | (in_array("003", $_SESSION['choices'])) | (in_array("103", $_SESSION['choices'])) | (in_array("303", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="203"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("314", $_SESSION['choices'])) |(in_array("214", $_SESSION['choices'])) | (in_array("224", $_SESSION['choices'])) | (in_array("234", $_SESSION['choices'])) | (in_array("004", $_SESSION['choices'])) | (in_array("104", $_SESSION['choices'])) | (in_array("304", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>												
											<td><input type="radio" name="buttons" value="204"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
			
							<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("211", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("212", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("213", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("214", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("301", $_SESSION['choices'])) |(in_array("201", $_SESSION['choices'])) | (in_array("221", $_SESSION['choices'])) | (in_array("231", $_SESSION['choices'])) | (in_array("011", $_SESSION['choices'])) | (in_array("111", $_SESSION['choices'])) | (in_array("311", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="211"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("302", $_SESSION['choices'])) |(in_array("202", $_SESSION['choices'])) | (in_array("222", $_SESSION['choices'])) | (in_array("232", $_SESSION['choices'])) | (in_array("012", $_SESSION['choices'])) | (in_array("112", $_SESSION['choices'])) | (in_array("312", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="212"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("303", $_SESSION['choices'])) |(in_array("203", $_SESSION['choices'])) | (in_array("223", $_SESSION['choices'])) | (in_array("233", $_SESSION['choices'])) | (in_array("013", $_SESSION['choices'])) | (in_array("113", $_SESSION['choices'])) | (in_array("313", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="213"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("304", $_SESSION['choices'])) |(in_array("204", $_SESSION['choices'])) | (in_array("224", $_SESSION['choices'])) | (in_array("234", $_SESSION['choices'])) | (in_array("014", $_SESSION['choices'])) | (in_array("114", $_SESSION['choices'])) | (in_array("314", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="214"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							</tr>

				<tr>
				<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("301", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("302", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("303", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("304", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("211", $_SESSION['choices'])) |(in_array("001", $_SESSION['choices'])) | (in_array("101", $_SESSION['choices'])) | (in_array("201", $_SESSION['choices'])) | (in_array("311", $_SESSION['choices'])) | (in_array("321", $_SESSION['choices'])) | (in_array("331", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="301"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("212", $_SESSION['choices'])) |(in_array("002", $_SESSION['choices'])) | (in_array("102", $_SESSION['choices'])) | (in_array("202", $_SESSION['choices'])) | (in_array("312", $_SESSION['choices'])) | (in_array("322", $_SESSION['choices'])) | (in_array("332", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="302"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("213", $_SESSION['choices'])) |(in_array("003", $_SESSION['choices'])) | (in_array("103", $_SESSION['choices'])) | (in_array("203", $_SESSION['choices'])) | (in_array("313", $_SESSION['choices'])) | (in_array("323", $_SESSION['choices'])) | (in_array("333", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="303"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("214", $_SESSION['choices'])) |(in_array("004", $_SESSION['choices'])) | (in_array("104", $_SESSION['choices'])) | (in_array("204", $_SESSION['choices'])) | (in_array("314", $_SESSION['choices'])) | (in_array("324", $_SESSION['choices'])) | (in_array("334", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="304"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							
							<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("311", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("312", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("313", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("314", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("201", $_SESSION['choices'])) |(in_array("301", $_SESSION['choices'])) | (in_array("321", $_SESSION['choices'])) | (in_array("331", $_SESSION['choices'])) | (in_array("011", $_SESSION['choices'])) | (in_array("111", $_SESSION['choices'])) | (in_array("211", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="311"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("202", $_SESSION['choices'])) |(in_array("302", $_SESSION['choices'])) | (in_array("322", $_SESSION['choices'])) | (in_array("332", $_SESSION['choices'])) | (in_array("012", $_SESSION['choices'])) | (in_array("112", $_SESSION['choices'])) | (in_array("212", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="312"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("203", $_SESSION['choices'])) |(in_array("303", $_SESSION['choices'])) | (in_array("323", $_SESSION['choices'])) | (in_array("333", $_SESSION['choices'])) | (in_array("013", $_SESSION['choices'])) | (in_array("113", $_SESSION['choices'])) | (in_array("213", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="313"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("204", $_SESSION['choices'])) |(in_array("304", $_SESSION['choices'])) | (in_array("324", $_SESSION['choices'])) | (in_array("334", $_SESSION['choices'])) | (in_array("014", $_SESSION['choices'])) | (in_array("114", $_SESSION['choices'])) | (in_array("214", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="314"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							</tr>
					</table>
		</td>
					
			<td>
			<table border="1" height = "170" width = "270" align = "center">
				<tr>
				<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("221", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("222", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("223", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("224", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("331", $_SESSION['choices'])) |(in_array("201", $_SESSION['choices'])) | (in_array("211", $_SESSION['choices'])) | (in_array("231", $_SESSION['choices'])) | (in_array("021", $_SESSION['choices'])) | (in_array("121", $_SESSION['choices'])) | (in_array("321", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="221"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("332", $_SESSION['choices'])) |(in_array("202", $_SESSION['choices'])) | (in_array("212", $_SESSION['choices'])) | (in_array("232", $_SESSION['choices'])) | (in_array("022", $_SESSION['choices'])) | (in_array("122", $_SESSION['choices'])) | (in_array("322", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="222"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("333", $_SESSION['choices'])) |(in_array("203", $_SESSION['choices'])) | (in_array("213", $_SESSION['choices'])) | (in_array("233", $_SESSION['choices'])) | (in_array("023", $_SESSION['choices'])) | (in_array("123", $_SESSION['choices'])) | (in_array("323", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="223"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("334", $_SESSION['choices'])) |(in_array("204", $_SESSION['choices'])) | (in_array("214", $_SESSION['choices'])) | (in_array("234", $_SESSION['choices'])) | (in_array("024", $_SESSION['choices'])) | (in_array("124", $_SESSION['choices'])) | (in_array("324", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="224"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
			
							<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("231", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("232", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("233", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("234", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("321", $_SESSION['choices'])) |(in_array("201", $_SESSION['choices'])) | (in_array("211", $_SESSION['choices'])) | (in_array("221", $_SESSION['choices'])) | (in_array("031", $_SESSION['choices'])) | (in_array("131", $_SESSION['choices'])) | (in_array("331", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>										
											<td><input type="radio" name="buttons" value="231"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("322", $_SESSION['choices'])) |(in_array("202", $_SESSION['choices'])) | (in_array("212", $_SESSION['choices'])) | (in_array("222", $_SESSION['choices'])) | (in_array("032", $_SESSION['choices'])) | (in_array("132", $_SESSION['choices'])) | (in_array("332", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="232"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("323", $_SESSION['choices'])) |(in_array("203", $_SESSION['choices'])) | (in_array("213", $_SESSION['choices'])) | (in_array("223", $_SESSION['choices'])) | (in_array("033", $_SESSION['choices'])) | (in_array("133", $_SESSION['choices'])) | (in_array("333", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="233"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("324", $_SESSION['choices'])) |(in_array("204", $_SESSION['choices'])) | (in_array("214", $_SESSION['choices'])) | (in_array("224", $_SESSION['choices'])) | (in_array("034", $_SESSION['choices'])) | (in_array("134", $_SESSION['choices'])) | (in_array("334", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="234"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							</tr>

				<tr>
				<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("321", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("322", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("323", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("324", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("231", $_SESSION['choices'])) |(in_array("301", $_SESSION['choices'])) | (in_array("311", $_SESSION['choices'])) | (in_array("331", $_SESSION['choices'])) | (in_array("021", $_SESSION['choices'])) | (in_array("121", $_SESSION['choices'])) | (in_array("221", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="321"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("232", $_SESSION['choices'])) |(in_array("302", $_SESSION['choices'])) | (in_array("312", $_SESSION['choices'])) | (in_array("332", $_SESSION['choices'])) | (in_array("022", $_SESSION['choices'])) | (in_array("122", $_SESSION['choices'])) | (in_array("222", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="322"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("233", $_SESSION['choices'])) |(in_array("303", $_SESSION['choices'])) | (in_array("313", $_SESSION['choices'])) | (in_array("333", $_SESSION['choices'])) | (in_array("023", $_SESSION['choices'])) | (in_array("123", $_SESSION['choices'])) | (in_array("223", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="323"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("234", $_SESSION['choices'])) |(in_array("304", $_SESSION['choices'])) | (in_array("314", $_SESSION['choices'])) | (in_array("334", $_SESSION['choices'])) | (in_array("024", $_SESSION['choices'])) | (in_array("124", $_SESSION['choices'])) | (in_array("224", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="324"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							
							<td>
									<table border="0" height ="70" width = "100" align="center">
									<?php
										if(in_array("331", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">1</font></center><?php
										}elseif(in_array("332", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">2</font></center><?php
										}elseif(in_array("333", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">3</font></center><?php
										}elseif(in_array("334", $_SESSION['choices'])){
										?> <center><font size="20" face="Times">4</font></center><?php
										}else {
									?>										
									<tr>
									
										<?php if((in_array("221", $_SESSION['choices'])) |(in_array("301", $_SESSION['choices'])) | (in_array("311", $_SESSION['choices'])) | (in_array("321", $_SESSION['choices'])) | (in_array("031", $_SESSION['choices'])) | (in_array("131", $_SESSION['choices'])) | (in_array("231", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="331"/>1</td>
										<?php } ?>											
											
										<?php if((in_array("222", $_SESSION['choices'])) |(in_array("302", $_SESSION['choices'])) | (in_array("312", $_SESSION['choices'])) | (in_array("322", $_SESSION['choices'])) | (in_array("032", $_SESSION['choices'])) | (in_array("132", $_SESSION['choices'])) | (in_array("232", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="332"/>2</td>
										<?php } ?>											
											
									</tr>
									
									<tr>
									
										<?php if((in_array("223", $_SESSION['choices'])) |(in_array("303", $_SESSION['choices'])) | (in_array("313", $_SESSION['choices'])) | (in_array("323", $_SESSION['choices'])) | (in_array("033", $_SESSION['choices'])) | (in_array("133", $_SESSION['choices'])) | (in_array("233", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>									
											<td><input type="radio" name="buttons" value="333"/>3</td>
										<?php } ?>											
											
										<?php if((in_array("224", $_SESSION['choices'])) |(in_array("304", $_SESSION['choices'])) | (in_array("314", $_SESSION['choices'])) | (in_array("324", $_SESSION['choices'])) | (in_array("034", $_SESSION['choices'])) | (in_array("134", $_SESSION['choices'])) | (in_array("234", $_SESSION['choices']))){?>
											<td></td>
										<?php }else{ ?>											
											<td><input type="radio" name="buttons" value="334"/>4</td>
										<?php } ?>											
											
									</tr>
									<?php } ?>
									</table>
							</td>
							</tr>
					</table>
		</td>
	</tr>
	</table>
	<br/>
	<center><input type="submit" value="Submit Move" /></center>
</form>

<form name="init_board" action="sudoku.php" method="post">
<center><input type="text" value="<?php echo $init_text_field ?>" name="board_init"/><input type="submit" name="initialize_board" value="Initialize Board"/></center>
<center><font size="2">(Input Format: XXXX:XXXX:XXXX:XXXX)</font></center>
</form>

<form name="board_cleanup" action="sudoku.php" method="post">
	<center><input type="submit" value="Clear" name="clear" /><input type="submit" value="Undo" name="undo" /></center>
</form>



</body>
</html>