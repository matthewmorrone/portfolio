<?
$words = file("words.txt");
shuffle($words);
echo $words[0];
