<?
error_reporting(1);
if ($_POST)
{
	extract($_POST);
	$db = connect();

	switch($mode)
	{
		case "init":
			initialize($db);
		break;
		case "word":
			newword($db);
		break;
		case "verify":
			verifyuser($db, $email, $password);
		break;
		case "double":
			checkemail($db, $email);
		break;
		case "new":
			if (checkemail($db, $email, $password) == 23):
				newuser($db, $name, $password, $email);
			endif;
		break;
	}
}

function connect()
{
	$db = new mysqli('localhost', 'root', 'root', 'assig3');
	if ($db->connect_error):
		print "Error - Could not connect to MySQL";
		die("Could not connect to db: " . $db->connect_error);
	endif;
	return $db;
}
function initialize($db)
{
	$db->query("DROP TABLE IF EXISTS Players");

	$result = $db->query(
	"CREATE TABLE Players(
	player_id int(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	password VARCHAR(20) NOT NULL,
	email VARCHAR(100) NOT NULL,
	rounds_played int(4) NOT NULL,
	rounds_won int(4) NOT NULL
	)") or die("Invalid: " . $db->error);

	$playerFileHandle = fopen("players.txt","r");
	while($playerline = fgetss($playerFileHandle)):
		$playerInfo = explode("|", trim($playerline));
		$query = "INSERT INTO Players VALUES('NULL', '$playerInfo[0]', '$playerInfo[1]', '$playerInfo[2]', 0, 0)";
		$result = $db->query($query) or die("Invalid: " . $db->error);
	endwhile;

	print_query($db, "SELECT * FROM Players");

	$db->query("DROP TABLE IF EXISTS Words");
	$query = "CREATE TABLE Words(word_id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY, word VARCHAR(10) NOT NULL)";
	$result = $db->query($query) or die("Invalid: " . $db->error);

	$wordarr = file("words5.txt");
	$curr = current($wordarr);
	while ($curr):
		$result = $db->query("INSERT INTO Words VALUES (NULL,'$curr')") or die("Invalid: " . $db->error);
		$curr = next($wordarr);
	endwhile;

	print_query($db, "SELECT * FROM Words");

}
function newword($db)
{
	$query = "SELECT * FROM words ORDER BY RAND() LIMIT 1;";
	echo get_query($db, $query)[0][1];
}
function verifyuser($db, $email, $password)
{
	$query = "SELECT password FROM players WHERE email = '$email';";
	if (strcmp($password, get_query($db, $query)[0][0]) == 0) {echo 23;}
	else {echo 11;}
}
function checkemail($db, $email)
{
	$query = "SELECT email FROM players WHERE email = '$email';";
	$result = count(get_query($db, $query));
	if ($result == 0) {return 23;}
	else {return 11;}
}
function newuser($db, $name, $password, $email)
{
	$query = "INSERT INTO Players VALUES('NULL', '$name', '$password', '$email', 0, 0)";
	$db->query($query);
}
function get_query($link, $query)
{
	trim($query);
	$result = $link->query($query);
	$num_rows = $result->num_rows;
	for($i = 0; $i < $num_rows; $i++):
		$row = $result->fetch_row(); //try fetch_array and see what happens
		for($j = 0; $j < count($row); $j++):
			$res[$i][$j] = $row[$j];
		endfor;
	endfor;
	return $res;
}
function print_query($link, $query)
{
	trim($query);
	$result = $link->query($query);
	$num_rows = $result->num_rows;
	$fields = $result->fetch_fields();
	echo "<table>";
	for($i = 0; $i < $num_rows; $i++):
		$row = $result->fetch_assoc();
		if ($i == 0):
			echo "<tr>";
			foreach($row as $field=>$cell):
				echo "<th>".$field."</th>";
			endforeach;
			echo "</tr>";
		endif;
		echo "<tr>";
		foreach($row as $field=>$cell):
			echo "<td>".$cell."</td>";
		endforeach;
		echo "</tr>";
	endfor;
	echo "</table>";
}

?>
