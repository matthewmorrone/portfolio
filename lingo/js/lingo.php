<?php


function connect()
{
    //$success = mysql_connect("localhost", "MafricaC", "flair.tayer") or die(mysql_error());
    //$success = mysql_select_db("MafricaC") or die(mysql_error());
    
    
    $success = mysql_connect("localhost", "root", "root") or die(mysql_error());
    $success = mysql_select_db("admin") or die(mysql_error());   
    return $success;
}

function initialize()
{
	mysql_query("DROP TABLE IF EXISTS words") or die(mysql_error());
	mysql_query("CREATE TABLE words(word varchar(5) PRIMARY KEY)") or die(mysql_error());
	
	$words = file("words5.txt");
	foreach ($words as $word)
	{
		mysql_query("INSERT INTO words VALUES('$word');") or die(mysql_error());
	}
	//echo "<p>".count($words)." inserted into database.</p>";
}

connect();


if ($_POST["mode"] == 0)
{
	initialize();
}
if ($_POST["mode"] == 1)
{
	$query = "SELECT * FROM words ORDER BY rand() LIMIT 1";
	$result = array_values(mysql_fetch_array(mysql_query($query)));
	echo json_encode($result[0]);
}
if ($_POST["mode"] == 2)
{
	$user = $_POST["username"];
	echo json_encode($user);
}



?>
