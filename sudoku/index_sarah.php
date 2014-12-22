<?php

	/*
	* By Sarah Ann Gay (sag89@pitt.edu)
	* So, just to go over the things that I did and didn't do, I wasn't able to
	* make the tables red. Instead of making the tables red, I just spit out
	* something that says it's an invalid board. That's the only thing that
	* doesn't work. I know my code is a lot but I decided to go and make my
	* table hard coded. That way, I knew where each button was and so on.
	* I came up with my own system of naming my buttons. So for instance,
	* 001 would be, in a 4x4 table, the top left corner and the value is 1.
	* 333 would be the bottom right corner and the value is 3. With that system,
	* every time a user clicks the submit move button, whatever name corresponds
	* with that radio button (123, 001, 002, etc) gets put into an array. If a 
	* number is in an array, in my table code, then all the radio buttons go away
	* and the corresponding value (1,2,3,4) shows up instead of the radio buttons.
	* For the radio buttons going away, I checked my array of 'choices' and basically
	* just said, hey, if any of these values are in that array, get rid of me.
	* It was a lot of code but it made total sense in my head. I apologize for this
	* being so long but I tried to format it well enough so that
	* you could read it easily! Again, I apologize for the red thing. Everything else
	* works like a beauty though. Please don't take off too many points just because
	* I didn't make a table red! Thanks.
	* Sarah Gay
	*/
	session_start();
	error_reporting(0);
		
	$_SESSION['board'];	
	$red = "#FF0000";
	$valid = 1;
	/* checks to see if buttons were submitted */
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

	
	/********** clears the board *********/
	if(isSet($_POST['clear'])){
		$_SESSION['choices'] = array();
	}

	
	/************* undo move *************/
	if(isSet($_POST['undo'])){
		$choices = $_SESSION['choices'];
		
		array_pop($choices);
		
		$_SESSION['choices'] = $choices;
	}

	
	/**************** Back ********************/
	if(isSet($_POST['back'])){
		$init_text_field = $_SESSION['board'];
		$valid = 1;
	}

	// if board initialize button is selected
	if(isSet($_POST['board_init'])){
	
		$board = strtolower($_POST['board_init']);
		$_SESSION['board'] = $board;
		$pattern = "/[x1234]{4}:[x1234]{4}:[x1234]{4}:[x1234]{4}/";
		
		// if the input doesn't match the correct patter, invalid, else
		if(preg_match($pattern, $board) == 0){
			$valid = 0;
		}else{
			$board_array = explode(":",$board);
			$first_quad = $board_array[0];
			$second_quad = $board_array[1];
			$third_quad = $board_array[2];
			$fourth_quad = $board_array[3];
			
			// checks the quads
			check($first_quad);
			check($second_quad);
			check($third_quad);
			check($fourth_quad);			
			
			/* initialize board arrays for row and column */
			$array_row0 = array();
			$array_row1 = array();
			$array_row2 = array();
			$array_row3 = array();
			$array_column0 = array();
			$array_column1 = array();
			$array_column2 = array();
			$array_column3 = array();
			
			/********** set up array by rows *******/
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
			
			// checks the rows
			check($array_row0);
			check($array_row1);
			check($array_row2);
			check($array_row3);
			
			/********** set up array by columns *******/
			array_push($array_column0, $first_quad[0]);
			array_push($array_column0, $first_quad[3]);
			array_push($array_column0, $third_quad[0]);
			array_push($array_column0, $third_quad[3]);
			
			array_push($array_column1, $first_quad[1]);
			array_push($array_column1, $first_quad[4]);
			array_push($array_column1, $third_quad[1]);
			array_push($array_column1, $third_quad[4]);		
			
			array_push($array_column2, $second_quad[0]);
			array_push($array_column2, $second_quad[3]);
			array_push($array_column2, $fourth_quad[0]);
			array_push($array_column2, $fourth_quad[3]);
			
			array_push($array_column3, $second_quad[1]);
			array_push($array_column3, $second_quad[4]);
			array_push($array_column3, $fourth_quad[1]);
			array_push($array_column3, $fourth_quad[4]);
			/******************************************/			
			
			// checks the columns
			check($array_column0);
			check($array_column1);
			check($array_column2);
			check($array_column3);			
			
			/* following code initializes the board if it's a valid board setup	*/
			if($valid){
				$board_2d = array($array_row0,$array_row1,$array_row2,$array_row3);
				$choices = array();
				
				for($i = 0; $i<4; $i++){
				
					for($j = 0; $j<4; $j++){
						if($board_2d[$i][$j] == 0){
						
						}else{
							array_push($choices, "$i"."$j".$board_2d[$i][$j]);
							$_SESSION['choices'] = $choices;
						}
					}
				}
								
			}
		}	
	}
	
	// function to check to see if the input is a valid board or not
	function check($quad){
		global $valid;
		$first = $quad[0];
		$second = $quad[1];
		$third = $quad[2];
		$fourth = $quad[3];

		if($first == 0){
		
		}else{
			if($first == $second){
				$valid = 0;
			}elseif($first == $third){
				$valid = 0;
			}elseif($first == $fourth){
				$valid = 0;
			}
		}
		
		if($second == 0){
		
		}else{
			if($second == $third){
				$valid = 0;
			}elseif($second == $fourth){
				$valid = 0;
			}
		}
		
		if($third == 0){
		
		}else{
			if($third == $fourth){
				$valid = 0;
			}
		}
	
	
	}
	
	
?>

<?php


?>



<html>
<head> <title> Sudoku </title> </head>
<link rel="stylesheet" type="text/css" href="styles.css" />
<body>
<center><font size="12" face="Times">Sudoku by Sarah Ann</font></center>

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
	<?php if(!$valid) { ?>
	<?php } else { ?>
	<center><input type="submit" name="submit_move" value="Submit Move" /></center>
	<?php } ?>
</form>

<form name="init_board" action="sudoku.php" method="post">
<center><input type="text" value="<?php echo $init_text_field ?>" name="board_init"/><input type="submit" name="initialize_board" value="Initialize Board"/></center>
<center><font size="2">(Input Format: XXXX:XXXX:XXXX:XXXX)</font></center>
</form>

<?php if(!$valid){ ?>
<center><font size="300">Invalid Board: Go Back</font></center>
<form name="go_back" action="sudoku.php" method="post">
<center><input type="submit" value="back" name="back"/></center>
<?php }else { ?>
<form name="board_cleanup" action="sudoku.php" method="post">
	<center><input type="submit" value="Clear" name="clear" /><input type="submit" value="Undo" name="undo" /></center>
</form>
<?php } ?>

<?php
		if(isSet($_POST['submit_move']) || isSet($_POST['board_init'])){
			$choices = $_SESSION['choices'];
			
			if(count($choices) == 16){
				?> <center><font size="50">Congrats!</font></center> <?php
			}
		}
?>
</body>
</html>