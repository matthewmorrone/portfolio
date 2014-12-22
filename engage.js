(function($)
{

	$.fn.blockSlider = function(options)
	{
		var result = "<table class='blockSlider'>"
		options.count = (options.max - options.min + .5)
		options.orient = "horizontal"
		// options.value = options.value * 10
		if (options.orient == "horizontal") {result += "<tr>"}
		for(var i = options.min; i <= (options.max)*10; i ++ )
		{
			if (options.orient == "vertical") {result += "<tr>"}
			result += "<td class = 'blockSliderChoice"
			// if (i ==  options.value) {result += " blockSliderSelected"}
			result += "' v='" + i + "'></td>"
			if (options.orient == "vertical") {result += "</tr>"}
		}
		if (options.orient == "horizontal") {result += "</tr>"}
		result += "</table>"
		$(this).html(result)

		$(this).parent().disableSelection()

		var mousedown = false
		var index = 0
		function neighbors(n, r)
		{
			var result = []
			for(var i = (n - r); i < (n + r); i++)
			{
				if (i < 0) 			{result.push(i+(r*2)); continue}
				if (i > (r*10)-1) 	{result.push(i-(r*2)); continue}
				result.push(i)
			}
			return result
		}
		$(".blockSliderChoice").mousedown(function()
		{
			mousedown = true
			$(".blockSliderChoice").removeClass("blockSliderSelected")
			index = parseInt($(this).index())
			var neigh = neighbors(index, 5)
			for(var n in neigh)
			{
				$(this).parent().children().eq(neigh[n]).addClass("blockSliderSelected")
			}
			$(this).parents(".slider").attr("v", index + 1)

			var cIndex = parseInt(index/50*255)
			var dIndex = 255-parseInt(index/50*255)

			$(this).parents(".slider").find(".neg").css("background-color", "rgb(255, "	+cIndex+", "+cIndex+")")
			$(this).parents(".slider").find(".neg").css("color", "rgb(255, "			+dIndex+", "+dIndex+")")
			$(this).parents(".slider").find(".pos").css("background-color", "rgb(255, "	+dIndex+", "+dIndex+")")
			$(this).parents(".slider").find(".pos").css("color", "rgb(255, "			+cIndex+", "+cIndex+")")


		})
		$(".blockSliderChoice").mousemove(function()
		{
			if (mousedown == true)
			{
				$(".blockSliderChoice").removeClass("blockSliderSelected")
				index = parseInt($(this).index())
				var neigh = neighbors(index, 5)
				for(var n in neigh)
				{
					$(this).parent().children().eq(neigh[n]).addClass("blockSliderSelected")
				}
				$(this).parents(".slider").attr("v", index + 1)

				var cIndex = parseInt(index/50*255)
				var dIndex = 255-parseInt(index/50*255)

				$(this).parents(".slider").find(".neg").css("background-color", "rgb(255, "	+cIndex+", "+cIndex+")")
				$(this).parents(".slider").find(".neg").css("color", "rgb(255, "			+dIndex+", "+dIndex+")")
				$(this).parents(".slider").find(".pos").css("background-color", "rgb(255, "	+dIndex+", "+dIndex+")")
				$(this).parents(".slider").find(".pos").css("color", "rgb(255, "			+cIndex+", "+cIndex+")")
			}
		})
		$(".blockSliderChoice").mouseup(function()
		{
			mousedown = false
		})
		$(".blockSliderChoice").width($(document).width()/options.count)
		// $(".edge").width(100).css("text-align", "center").css("background-color", "white").css("font-size", "200%")
		$(".blockSlider").find("td:first-child").html("-").addClass("edge").addClass("neg")
		$(".blockSlider").find("td:last-child").html("+").addClass("edge").addClass("pos")


	}

})
(jQuery)
