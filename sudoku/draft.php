
<!--<!doctype html>-->
<?xml version = "1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	
<?php 

session_start(); 

if (isset($_POST['clear']))
{
	unset($_SESSION['history']); //reset last session data
	session_destroy(); 
	//clearBoard();
}
error_reporting(0);

if (isset($_POST["choice"]))
{    
	$id = substr($_POST["choice"], 0, 3);
	$value = substr($_POST["choice"], 3, 1);
	$_SESSION["history"][$id] = $value;  
}

print "<br />";

                ///////////// BUTTONS /////////////////				

if(isset($_POST['init'])){
	//check for proper input pattern
	if (!empty($_POST['init_text']) && (preg_match('/^[1234x]{4}:[1234x]{4}:[1234x]{4}:[1234x]{4}$/', chop($_POST[init_text])))){	
		//global $invalid_move;
		$invalid_move = false;
		for($i=0; $i<strlen($_POST['init_text']); $i++){
			//if not x, use id# as key for session array
			if ($_POST['init_text']{$i} != 'x')
			{
				if($i==0){$_SESSION["history"]['a00'] = $_POST['init_text']{$i};}
				if($i==1){$_SESSION["history"]['a01'] = $_POST['init_text']{$i};}
				if($i==2){$_SESSION["history"]['a10'] = $_POST['init_text']{$i};}
				if($i==3){$_SESSION["history"]['a11'] = $_POST['init_text']{$i};}
				if($i==5){$_SESSION["history"]['a02'] = $_POST['init_text']{$i};}
				if($i==6){$_SESSION["history"]['a03'] = $_POST['init_text']{$i};}
				if($i==7){$_SESSION["history"]['a12'] = $_POST['init_text']{$i};}
				if($i==8){$_SESSION["history"]['a13'] = $_POST['init_text']{$i};}
				if($i==10){$_SESSION["history"]['a20'] = $_POST['init_text']{$i};}
				if($i==11){$_SESSION["history"]['a21'] = $_POST['init_text']{$i};}
				if($i==12){$_SESSION["history"]['a30'] = $_POST['init_text']{$i};}
				if($i==13){$_SESSION["history"]['a31'] = $_POST['init_text']{$i};}
				if($i==15){$_SESSION["history"]['a22'] = $_POST['init_text']{$i};}
				if($i==16){$_SESSION["history"]['a23'] = $_POST['init_text']{$i};}
				if($i==17){$_SESSION["history"]['a32'] = $_POST['init_text']{$i};}
				if($i==18){$_SESSION["history"]['a33'] = $_POST['init_text']{$i};}
			}
		}
		if(!check(history)){
			print "<br /><br /><error>Your input violates the sudoku rules!</error>";
			unset($_SESSION['history']); //reset last session data
			session_destroy(); 
			
		}
	}
	else{
		print "<br /><br /><error>Please enter the board data in the correct format</error>";	
	}
}

if(isset($_POST['undo']) or isset($_POST['back']))
{ 
	array_pop($_SESSION["history"]);
}


                /////////// FUNCTIONS /////////////////				

function victory(){
	$count = 0;
	for($f=0; $f<35; $f++)
	{
		if ($f<4 && isset($_SESSION['history']["a0".$f]))
		{    
			$count++; 
		}
		if($f>9 && isset($_SESSION['history']["a".$f]))
		{      
			$count++;
		}
	}
	if ($count == 16){return true;}
	else{return false;}
}

function check($moves){
	for ($a=0; $a<4; $a++)
	{
		$row[$a] = Array();
		for($b=0; $b<4; $b++)
		{
			if (isset($_SESSION[$moves]["a".$a.$b]))
			{
				$c = $_SESSION[$moves]["a".$a.$b];

				if (!in_array($c, $row[$a])) {$row[$a][$b] = $c;}
				else {return false;}			
			}
		}
	}
	$_SESSION["row"] = $row; 
	for ($a=0; $a<4; $a++)
	{
		$col[$a] = Array();
		for($b=0; $b<4; $b++)
		{
			if (isset($_SESSION[$moves]["a".$b.$a]))
			{
				$c = $_SESSION[$moves]["a".$b.$a];

				if (!in_array($c, $col[$a])) {$col[$a][$b] = $c;}
				else {return false;}			
			}
		}
	}
	$_SESSION["col"] = $col; 
	
	for ($i=0; $i<4; $i++)
	{
		$box[$i] = Array();
		for ($j=0; $j<4; $j++)
		{
			$k = floor($j / 2) + floor($i / 2) * 2;
			$l = ($j % 2) + ($i % 2) * 2;
			if (isset($_SESSION[$moves]["a".$k.$l]))
			{
				$c = $_SESSION[$moves]["a".$k.$l];

				if (!in_array($c, $box[$i])) {$box[$i][$j] = $c;}
				else {return false;}			
			}			
		}
	}
	$_SESSION["box"] = $box; 	
	
	return true;
}


                /////////// PRINT TABLE /////////////////	
?>	
 <html>
    <head>
        <title>Sudoku:4x4</title>
		<link rel="stylesheet" type="text/css" href="styles.css" />
    </head>
    <body>
	
	<header><h1>The Amazing, Highly Anticipated,<br />4x4 Sudoku...</h1></header>
<form action="" method="post">
  	
<?php 
print "<br />";
print '<table class="table_outer" >';
print '<but><input type="text" name="init_text" size="22">';
print '<input type="submit" name="init" value="Initialize Board"></but>';
print '<but><input type="submit" name="clear" value="Clear Board"></but><br />';
print '<br /> <br /> <br /> <br />';
if (check(history)){
	print '<but><input type="submit" name="submit" value="Submit"></but>';
}
else{print "<error>Invalid Move!</error>";}
if (victory()){print "<h4>The completion of this sudoku has triggered...<br>BOMB THREAT!!<br>Please evacuate the Cathedral immediately.</h4>";}
	for ($x = 0; $x < 4; $x++)
{
	print "<tr>";
	for ($y = 0; $y < 4; $y++)
	{
		print '<td class="td_outer">';
		
			print '<table class="table_inner">';
			print "<tr>";
			
			if (isset($_SESSION["history"]["a".$x.$y])){
				print $_SESSION["history"]["a".$x.$y];
			}
			else{
				for ($z = 0; $z < 4; $z++)
				{
					print '<td class="td_inner">';
					//insert function to remove unvalid moves
					print "<input type='radio' name='choice' value='a".$x.$y.($z+1)."'>".($z+1)."</input>";
					print "</td>";
					if ($z == 1) {print "</tr><tr>";}		
				}
			}
			print "</tr>";
			print "</table>";		
		print "</td>";
	}
	print "</tr>";
}
print "</table>";

if(!check(history))
{
	print '<but><input type="submit" name="back" value="Back"></but>';
}
else
{
	print '<but><input type="submit" name="undo" value="Undo Move"></but>';
}
print "<br><br><br><br><br><br><hr />";
?>

</form>

		<footer>Jake Lyons. cs1520. March 2012.<br /><a href ="http://db.cs.pitt.edu/courses/cs1520/spring2012/assign/a2.sudoku.pdf">click here to view the assignment</p></footer>
    </body>
</html>
