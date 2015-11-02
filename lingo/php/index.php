<?
session_start();

$_SESSION['previous'] = basename($_SERVER['PHP_SELF']);

if (isset($_SESSION['previous'])) {
   if (basename($_SERVER['PHP_SELF']) != $_SESSION['previous']) {
        session_destroy();
        ### or alternatively, you can use this for specific variables:
        ### unset($_SESSION['varname']);
   }
}


?>

<html>
<head>
<title>Welcome to Lingo</title>
<link rel = "stylesheet" type = "text/css" href = "styles.css" />
<link rel="shortcut icon" type="image/x-icon" href="/psi.ico"></link>
</head>

<body>

<?

error_reporting(0);


if (!isset($_SESSION["finished"]))
{
	$_SESSION["finished"] = "0";

	for ($i = 1; $i <= 5; $i++)
	{
		unset($_SESSION["attempt".$i]);
	}

	$try = 0;
	$_SESSION["tries"] = 0;
	$triesleft = 5;
	$_SESSION["triesleft"] = 5;

	$file = fopen("words5.txt", "r");
	$lines = file("words5.txt");
	$_SESSION["word"] = strtoupper($lines[rand(0, sizeOf($lines)-1)]);
	fclose($file);

	$word = $_SESSION["word"];
	$word_letters = array(substr("$word", 0, 1), substr("$word", 1, 1), substr("$word", 2, 1), substr("$word", 3, 1), substr("$word", 4, 1));
}

$word = $_SESSION["word"];
$word_letters = array(substr("$word", 0, 1), substr("$word", 1, 1), substr("$word", 2, 1), substr("$word", 3, 1), substr("$word", 4, 1));

$try = $_SESSION["tries"];
$_SESSION["tries"]++;
$triesleft = $_SESSION["triesleft"];
$_SESSION["triesleft"]--;

if (!isset($_SESSION["attempt".$try]))
{
	$_POST["guess"] = strtoupper($_POST["guess"]);
	$_SESSION["attempt".$try] = $_POST["guess"];
}

$won = $_SESSION["won"];

?>

<a href="/" class="image"><img src="/psi.ico" /></a>

<?

print("<table>");
print("<tr><th>Hint:</th>");
print("<td class = 'correct'>$word_letters[0]</td>");
print("<td class = 'correct'></td>");
print("<td class = 'correct'></td>");
print("<td class = 'correct'></td>");
print("<td class = 'correct'></td></tr>");

for ($i = 1; $i <= $try; $i++)
{
	$current = $_SESSION["attempt".$i];
	$current_letters = array(substr("$current", 0, 1), substr("$current", 1, 1), substr("$current", 2, 1), substr("$current", 3, 1), substr("$current", 4, 1));

	for($j = 0; $j < 5; $j++)
	{
		$frequency["$word_letters[$j]"]++;
	}

	$match = 0;

	print("<tr><th>Attempt #$i </th>");

	for($j = 0; $j < 5; $j++) {$result[$j] = "X";}

	for($j = 0; $j < 5; $j++)
	{
		if ($word_letters[$j] == $current_letters[$j])
		{
			$result[$j] = "C";
			$frequency["$current_letters[$j]"]--;
		}
	}

	for($j = 0; $j < 5; $j++)
	{
		if ((strpos($word, $current_letters[$j]) !== FALSE) && ($frequency["$current_letters[$j]"] > 0) && ($result[$j] != "C"))
		{
			$result[$j] = "P";
			$frequency["$current_letters[$j]"]--;
		}
	}

	for($j = 0; $j < 5; $j++)
	{
		if ($result[$j] == "X")
		{
			$result[$j] = "W";
		}
	}

	for($j = 0; $j < 5; $j++)
	{
		if ($result[$j] == "C")
		{
			print("<td class = 'correct'>$current_letters[$j]</td>");
			$match++;
		}
		if ($result[$j] == "P")
		{
			print("<td class = 'present'>$current_letters[$j]</td>");
		}
		if ($result[$j] == "W")
		{
			print("<td class = 'wrong'>$current_letters[$j]</td>");
		}
	}

	print("</tr>");

	for($j = 0; $j < 5; $j++)
	{
		$frequency["$word_letters[$j]"] = 0;
	}
}

print("<form method = 'post' action = ''>");

if ($match === 5)
{
	print("<tr><th>Input:</th><td colspan = 4><input type = 'text' name = 'guess' value = 'Great Job!' size = '5' disabled = 'disabled' /></td>");
	print("<td><label><input type = 'submit' value = 'Play again?' /></label></td></tr>");
	unset($_SESSION["finished"]);
}
else if ($triesleft === 0)
{
	print("<tr><th>Answer:</th>");
	print("<td class = 'correct'>$word_letters[0]</td>");
	print("<td class = 'correct'>$word_letters[1]</td>");
	print("<td class = 'correct'>$word_letters[2]</td>");
	print("<td class = 'correct'>$word_letters[3]</td>");
	print("<td class = 'correct'>$word_letters[4]</td></tr>");
	print("<tr><th>Input:</th><td colspan = 4><input type = 'text' name = 'guess' size = '5' value = 'You suck.' disabled = 'disabled' /></td>");
	print("<td><label><input type = 'submit' value = 'Play again?' /></label></td></tr>");
	unset($_SESSION["finished"]);
}
else
{
	print("<tr><th>Input: </th><td colspan = '4'><input type = 'text' name = 'guess' size = '5' /></td>");
	print("<td align = 'center'><label><input type = 'submit' value = '$triesleft Tries Left'/></label></td></tr>");
}

print("</form></table>");
?>
<!-- <h3>Lingo</h3> -->
<!-- <p>This is the first thing I ever programmed in PHP. It was a class assignment, which is why it has no Javascript and has issues with overcaching. I have a version that implements Javascript, but I like to leave it up online the way it is as a reminder that this stuff used to be way more difficult for me.</p> -->

</body>
</html>
