<html>
<head>
<title>Kenek kenek</title>
<script src="prefixfree.js"></script>
<style>
table, td
{
	border: 1px solid black;
	border-collapse: collapse;
}
td div
{
	width: 100px;
	height: 100px;
	display:box;
	box-pack:center;
	box-align:center;
}

</style>
<script src="jquery.js"></script>
<script src="jquery.menu.js"></script>
<script>
Array.prototype.remove = function(from, to)
{
	var rest = this.slice((to || from) + 1 || this.length)
	this.length = from < 0 ? this.length + from : from
	return this.push.apply(this, rest)
}
Array.prototype.pluck = function(from, to)
{
	var pluck = this[from]
	var rest = this.slice((to || from) + 1 || this.length)
	this.length = from < 0 ? this.length + from : from
	return pluck
}
// Math.floor((Math.random()*this.length)+1)

$(function()
{
	var magic = 6
	var bag = []
	for(var i = 0; i < magic; i++)
	{
		bag[i] = []
		for(var j = 0; j < magic; j++)
		{
			var k = Math.floor((Math.random()*magic)+1)
			var found = false
			// for(m = 1; m <= i; m++)
			// {
			// 	// alert(bag[i][bag[i].length-1]+" "+bag[m][i])
			// 	if (bag[i][bag[i].length-1] == bag[(m-1)][(j)])
			// 	{}
			// 	// if (bag[m][j] == k)
			// 	// {
			// 	// 	found = true
			// 	// }
			// }

			if (bag[i].indexOf(k) != -1)
			{
				found = true
			}
			if (found == false) {bag[i].push(k) } else {j-- }

		}
	}
// debugger
	var sel = '<div class="outer_container"><a class="menu_button" href="#" title="Toggle"><span>Menu Toggle</span></a> <ul class="menu_option">'
	for(var i = 0; i < magic; i++)
	{
		sel += "<li><a href='#'><span>"+i+"</span></a></li>"
	}
	sel += "</ul> </div>"
	var result = ""
	result += "<table>"
	for(var i = 0; i < magic; i++)
	{
		result += "<tr>"
		for(var j = 0; j < magic; j++)
		{
			result += "<td>"
			result += "<div x='"+j+"' y ='"+i+"' id='"+j+""+i+"''>"
			result += bag[i][j]
			result += "</div>"
			result += sel
			result += "</div>"
		}
		result += "</tr>"
	}
	result += "</table>"
// debugger
	$("body").html(result)
	$('.outer_container').PieMenu({
	        'starting_angel':0,
	        'angel_difference' : 360,
	        'radius':100,
	    });

	// $("table")
})



</script>
<body>

</body>
</html>
