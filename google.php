<html lang='en'>
	<head>
		<meta charset='utf-8'>
		<title>Crawler</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.8.2.js"></script>
<script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
		<style>
		*
		{
		    margin: 0px;
		    padding: 0px;
		}
		body
		{
		    background: #232428;
		    color: white; 
		    font: 80%/18px "Helvetica Neue", Helvetica, Arial, sans-serif;
		}
		input, button
		{
		    width: 100%;
		    height: 100%; 
		}
		td
		{
		    width: 100px; 
		    height: 20px;  
		}
		ul
		{
		    list-style-type: none;
		}
		li ul {padding-left: 20px;}
		.orth
		{
		    color: lightyellow; 
		}
		.meta 
		{
		    color: lightgreen;
		}
		.para
		{
		    color: lightblue; 
		}
		</style>
	</head>
	<body>
	
	<table>
        <tr>
            <td><input type="submit" value="Refresh"></input></td>
            <td><button id="showall">Show All</button></td>
            <td><button id="hideall">Hide All</button></td>
        </tr>
        <tr>
            <td><button id="showorths">Show Links</button></td>
            <td><button id="showmetas">Show Meta Tags</button></td>
            <td><button id="showparas">Show Paragraphs</button></td>
        </tr>
	</table>
	
	<?php
    function metas($url)
    {
        $metas = get_meta_tags("http://".$url);
        echo "<ul>";
        foreach ($metas as $meta)
        {
            echo "<li class='meta'>".$meta."</li>";
        } 
        echo "</ul>";  
         
    }
    function paras($url)
    {
        $file = file_get_contents("http://".$url);
        $file = strip_tags($file, "<p><a>");
        $pattern = "/\<p\>.+?\<\/p\>/";   
        preg_match_all($pattern, $file, $matches);
        $paras = array();
        foreach ($matches[0] as $match)
        {
            $paras[] = $match;
        }
        echo "<ul>";
        foreach ($paras as $para)
        {
            echo "<li class='para'>".$para."</li>";
        } 
        echo "</ul>";
    }
    function links($url)
    {
        $file = file_get_contents($url);
        $pattern = "/href=\"\/url\?q=http:\/\/.+?&/";
        preg_match_all($pattern, $file, $matches);
        $links = array();
        foreach ($matches[0] as $match)
        {
            $match = str_replace("href=\"/url?q=http://", "", $match);
            $match = str_replace("/&", "", $match);
            $links[] = str_replace("&", "", $match);
        }
        foreach ($links as $link)
        {
            $c++;
            echo "<li><ul><li class='orth'>".$link."</li></ul>";
            metas($link);
            paras($link);
            echo "</li>";
            if ($c > 4) {break;}
        }
    }    
    $keyword = $_GET["keyword"];
    $keyword = str_replace(" ", "", $keyword);
    
	$urls[] = "https://www.google.com/search?q=".$keyword."&hl=en";
	if ($_GET)
	{
	    $pages = $_GET["pages"];
	    $count = 1;
	    while ($count < $pages)
	    {
	        $urls[] = "https://www.google.com/search?q=".$keyword."&hl=en&start=".($count*10);
	        $count++;
	    }
	}
    $urls = array_unique($urls);
    echo "<ul>";
    echo "<h1>".$_GET["keyword"]."</h1>";
    echo "<h2>displaying ".($count*10)." pages</h2>";
    foreach ($urls as $url)
    {
        links($url);
    }
    echo "</ul>";
    

	?>
	

	
	
	<script>
	$(function()
	{
        $(".orth").each(function()
        {
            $(this).parent().parent().children().children(".para, .meta").hide()
        })
        $(".orth").toggle
        (
            function()
            {
                $(this).parent().parent().children().children(".para, .meta").show()
            },
            function()
            {
                $(this).parent().parent().children().children(".para, .meta").hide()
            }
        )
        $("#showall").click(function()
        {
            $(".para, .meta").show()
        })
        $("#hideall").click(function()
        {
            $(".para, .meta").hide()
        })
        $("#showorths").click(function()
        {
            $(".orth, .para, .meta").hide()
            $(".orth").show()
        })
        $("#showmetas").click(function()
        {
            $(".orth, .para, .meta").hide()
            $(".para").show()
        })
        $("#showparas").click(function()
        {
            $(".orth, .para, .meta").hide()
            $(".meta").show()
        })
	})
	
	</script>
	</body>
</html>



