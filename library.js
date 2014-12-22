

Array.prototype.sort		= function() 	{var tmp; for(var i = 0; i < this.length; i++) {for(var j = 0; j < this.length; j++) {if(this[i] < this[j]) {tmp = this[i]; this[i] = this[j]; this[j] = tmp}}}}
Array.prototype.shuffle	 	= function() 	{var i = this.length, j, t; while(i--) {j = Math.floor((i + 1) * Math.random()); t = arr[i]; arr[i] = arr[j]; arr[j] = t}}
Array.prototype.unshift	 	= function(el)	{this[this.length] = null; for(var i = 1; i < this.length; i++) {this[i] = this[i-1]}; this[0] = el; return this.length}
Array.prototype.shift	 	= function() 	{var result = this[0]; for(var i = 1; i < this.length; i++) {this[i-1] = this[i]}; this.length = this.length-1; return result}
Array.prototype.clear	 	= function() 	{this.length = 0}
Array.prototype.unique		= function() 	{var a = [],i; this.sort(); for(i = 0; i < this.length; i++) {if(this[i] !== this[i + 1]) {a[a.length] = this[i]}}; return a}
Array.prototype.lastIndexOf = function(n)	{var i = this.length; while(i--) {if(this[i] === n) {return i}}; return -1}
Array.prototype.contains	= function(el) 	{for (var i = 0; i < this.length; i++) {if (this[i] == el) {return true}}; return false}
Array.prototype.remove		= function(el) 	{var i = 0; while (i < this.length) {if (this[i] == el) {this.splice(i, 1)} else {i++}}}
Array.prototype.inArray		= function(val) {for (var i = 0; i < this.length; i++) {if (this[i] === val) {return true}}; return false}
Array.prototype.append		= function(el) 	{this.push(el); return this.length}
Array.prototype.chunk 		= function(arr, n) {var result = []; for (i = 0; i < arr.length; i += n) {result.push(arr.slice(i, i+n))} return result}
Array.prototype.sum 		= function()
{
	var sum = 0;
	for (var i in this)
	{
		if (!this.hasOwnProperty(i)) {continue}
		sum += parseFloat(this[i])
	}
	return sum
}
Array.prototype.ave 		= function() {return this.sum()/this.length}
Array.prototype.dev = function()
{
	var mean = comp_ave(this)
	var dev = 0
	for (i in this) {this[i] = (this[i] - mean)}
	for (i in this) {this[i] = (this[i] * this[i])}
	for (i in this) {dev += this[i]}
	dev /= (this.length-1)
	dev = Math.sqrt(dev)
	return dev
}

Number.prototype.randomInt = function(min, max)
{
	if (!min) {min = 1}
	if (!max) {max = 10}
	return Math.floor(Math.random() * (max - min + 1)) + min;
}
Number.prototype.randomFloat = function(min, max)
{
	if (!min) {min = 1}
	if (!max) {max = 10}
	return (Math.random() * (max - min + 1)) + min;
}

function Canvas(el)
{
	this.canvas = document.getElementsByTagName('canvas')[0]
	this.width = canvas.width
	this.height = canvas.height
	this.c = this.canvas.getContext('2d')
	this.color = "red"
	this.origin = {}
	this.origin.x = this.width/2
	this.origin.y = this.height/2
	this.g = 25
	this.minx = -10
	this.miny = -10
	this.maxx = 10
	this.maxy = 10

	this.clear = function()
	{
		this.c.clearRect(0, 0, this.width, this.height)
		return this
	}
	this.draw = function(f)
	{
		f()
	}
	this.redraw = function()
	{
		this.clear()
		this.draw()
	}
	this.tra = function(x, y)
	{
		return {x: (x * this.g + this.origin.x), y: (this.height - (y * this.g + this.origin.y))}
	}
	this.dot = function(x, y, color)
	{
		var p = this.tra(x, y)

		this.c.beginPath()
		this.c.arc(p.x, p.y, 3, Math.PI, -Math.PI, false)
		this.c.lineWidth = 1
		this.c.fillStyle = color
		this.c.fill()
		return this
	}
	this.line = function(x1, y1, x2, y2, color, width)
	{
		var p1 = this.tra(x1, y1)
		var p2 = this.tra(x2, y2)

		this.c.beginPath()
		this.c.moveTo(p1.x, p1.y)
		this.c.lineTo(p2.x, p2.y)
		this.c.strokeStyle = color || "black"
		this.c.lineWidth = width || 1
		this.c.stroke()
		this.c.closePath()
		return this
	}
	this.render = function(f)
	{
		if (_.isFunction(f)) 	{for(var i = -10; i < 10; i+=.01) {this.dot(i, f(i), "red")}}
		if (_.isArray(f)) 		{for(var d in f) {this.dot(d, f[d], "red")}}
		return this
	}
	this.integr = function(f)
	{
		for(var i = -10; i < 10; i+=.01) {this.line(i, 0, i, f(i), "red")}
		return this
	}
	//this.differ = function(f, x) {return this}

	this.grid = function()
	{
		this.c.strokeStyle = "rgba(0, 0, 255, 1)"
		for (var i = this.minx; i <= this.maxx; i++) {this.line(i, this.miny, i, this.maxy, "rgba(0, 0, 255, 1)")}
		for (var j = this.miny; j <= this.maxy; j++) {this.line(this.minx, j, this.maxx, j, "rgba(0, 0, 255, 1)")}

		this.line(this.minx, 0, this.maxx, 0, "rgba(0, 0, 0, 1)", 4)
		this.line(0, this.miny, 0, this.maxy, "rgba(0, 0, 0, 1)", 4)

		for (var i = this.minx; i <= this.maxx; i++) {this.line(i, -.2, i, .2, "rgba(0, 0, 0, 1)", 4)}
		for (var j = this.miny; j <= this.maxy; j++) {this.line(-.2, j, .2, j, "rgba(0, 0, 0, 1)", 4)}
		return c
	}
	return this
}


function circle(c, x, y, r, w, s, f, l)
{
	c.beginPath()
	c.arc(x, y, r, Math.PI, -Math.PI, false)
	c.lineWidth = w
	if (s != '') {c.strokeStyle = s; c.stroke()}
	if (f != '') {c.fillStyle = f; c.fill()}
	c.closePath()
	if (l != '') {label(l, x, y)}
	return c
}








function piesection(a, b, color)
{
	c.beginPath()
	c.arc(150,150,150,a,b,false)
	c.fillStyle = color
	c.lineTo(150,150)
	c.fill()
}


function label(l, x, y)
{
	c.font = "10pt Calibri"
	c.fillStyle = "rgba(0, 0, 0, 1)"
	c.textAlign = "center";
	c.textBaseline = "middle";
	c.fillText(l, x, y)
}

function pretty(x, y)
{
	circle(x-100, 	y, 		100, 5, "", 'rgba(250, 0, 0, 0.5)');
	circle(x, 		y-100, 	100, 5, "", 'rgba(0, 0, 0, 0.5)');
	circle(x, 		y+100, 	100, 5, "", 'rgba(0, 250, 0, 0.5)');
	circle(x+100, 	y, 		100, 5, "", 'rgba(0, 0, 250, 0.5)');
	circle(x-70, 	y-70, 	100, 5, "", 'rgba(250, 0, 250, 0.5)');
	circle(x+70, 	y+70, 	100, 5, "", 'rgba(250, 250, 0, 0.5)');
	circle(x-70, 	y+70, 	100, 5, "", 'rgba(0, 250, 250, 0.5)');
	circle(x+70, 	y-70, 	100, 5, "", 'rgba(250, 250, 250, 0.5)');

	circle(x-100, y, 100, 5, "black");
	circle(x, y-100, 100, 5, "black");
	circle(x, y+100, 100, 5, "black");
	circle(x+100, y, 100, 5, "black");
	circle(x-70, y-70, 100, 5, "black");
	circle(x-70, y+70, 100, 5, "black");
	circle(x+70, y-70, 100, 5, "black");
	circle(x+70, y+70, 100, 5, "black");
}


function rectangle(x, y, dx, dy, s, f, l)
{
	c.beginPath()
	if (s != '')
	{
		c.strokeStyle = s
		c.stroke()
	}
	if (f != '')
	{
		c.fillStyle = f
		c.fill()
	}
	c.fillRect(x, y, dx, dy)
	if (l != '')
	{
		label(l, x, y)
	}
	c.closePath()
}


function square(x, y, e, w, s, f)
{
	if (s == "")
	{
		s = 'rgba(0, 0, 0, 0)'
	}
	c.beginPath()
	c.rect(x, y, e, e)
	c.lineWidth = w
	c.strokeStyle = s
	c.stroke()
	if (f)
	{
		c.fillStyle = f
		c.fillRect(x, y, e, e)
	}
}

function bowtied(c)
{
	c.fillRect(25, 25, 100, 100)
	c.clearRect(45, 45, 60, 60)
	c.strokeRect(50, 50, 50, 50)
}
function drawBowties(c)
{
	c.translate(45, 45)

	c.save()
	drawBowtie(c, "red")
	dot(c)
	c.restore()

	c.save()
	c.translate(85, 0)
	c.rotate(45 * Math.PI / 180)
	drawBowtie(c, "green")
	dot(c)
	c.restore()

	c.save()
	c.translate(0, 85)
	c.rotate(135 * Math.PI / 180)
	drawBowtie(c, "blue")
	dot(c)
	c.restore()

	c.save()
	c.translate(85, 85)
	c.rotate(90 * Math.PI / 180)
	drawBowtie(c, "yellow")
	dot(c)
	c.restore()
}
function drawBowtie(c, color)
{
	c.fillStyle = "rgba(200, 200, 200, 0.3)"
	c.fillRect(-30, -30, 60, 60)

	c.fillStyle = color
	c.globalAlpha = 1.0
	c.beginPath()
	c.moveTo(25, 25)
	c.lineTo(-25, -25)
	c.lineTo(25, -25)
	c.lineTo(-25, 25)
	c.closePath()
	c.fill()
}


function roundedRect(x, y, w, h, r)
{
	c.beginPath()
	c.moveTo(x, y+r)
	c.lineTo(x, y+h-r)
	c.quadraticCurveTo(x, y+h, x+r, y+h)
	c.lineTo(x+w-r, y+h)
	c.quadraticCurveTo(x+w, y+h, x+w, y+h-r)
	c.lineTo(x+w, y+r)
	c.quadraticCurveTo(x+w, y, x+w-r, y)
	c.lineTo(x+r, y)
	c.quadraticCurveTo(x, y, x, y+r)
	c.stroke()
}
function smiley(x, y, r)
{

	c.beginPath()
	c.arc(x,y,r/2,0,Math.PI*2,true)			 //	 Outer circle
	c.stroke()
	c.closePath()

	c.beginPath()
	c.arc(x,y+r/10,r/4,0,Math.PI,false)	 //	 Mouth (clockwise)
	c.stroke()
	c.closePath()

	c.beginPath()
	c.arc(x-r/5,y-r/8,r/10,0,Math.PI*2,true)	//	 Left eye
	c.stroke()
	c.closePath()

	c.beginPath()
	c.arc(x+r/5,y-r/8,r/10,0,Math.PI*2,true)	//	 Right eye
	c.stroke()
	c.closePath()
}



function triangle()
{
	c.beginPath()
	c.moveTo(25,25)
	c.lineTo(105,25)
	c.lineTo(25,105)
	c.fill()

	c.beginPath()
	c.moveTo(125,125)
	c.lineTo(125,45)
	c.lineTo(45,125)
	c.closePath()
	c.stroke()
}
function arcs()
{
	for (i = 0; i < 4; i++)
	{
		for(j = 0; j < 3; j++)
		{
			c.beginPath()
			var x					 = 25 + j * 50							 // x coordinate
			var y					 = 25 + i * 50							 // y coordinate
			var r					 = 20												// Arc r
			var startAngle	= 0												 // Starting point on circle
			var endAngle		= Math.PI + (Math.PI*j)/2	 // End point on circle
			var clockwise	 = i % 2 == 0 ? false : true // clockwise or anticlockwise

			c.arc(x, y, r, startAngle, endAngle, clockwise)

			if (i > 1)	{c.fill()}
			else				{c.stroke()}
		}
	}
}
function speechbubble()
{
	c.beginPath()
	c.moveTo(75, 25)
	c.quadraticCurveTo(25, 25, 25, 62.5)
	c.quadraticCurveTo(25, 100, 50, 100)
	c.quadraticCurveTo(50, 120, 30, 125)
	c.quadraticCurveTo(60, 120, 65, 100)
	c.quadraticCurveTo(125, 100, 125, 62.5)
	c.quadraticCurveTo(125, 25, 75, 25)
	c.stroke()
}
function heart()
{
	c.beginPath()
	c.moveTo(75, 40)
	c.bezierCurveTo(75, 37, 70, 25, 50, 25)
	c.bezierCurveTo(20, 25, 20, 62.5, 20, 62.5)
	c.bezierCurveTo(20, 80, 40, 102, 75, 120)
	c.bezierCurveTo(110, 102, 130, 80, 130, 62.5)
	c.bezierCurveTo(130, 62.5, 130, 25, 100, 25)
	c.bezierCurveTo(85, 25, 75, 37, 75, 40)
	c.fill()
}
function pacman()
{
	roundedRect(c, 12, 12, 150, 150, 15)
	roundedRect(c, 19, 19, 150, 150, 9)
	roundedRect(c, 53, 53, 49, 33, 10)
	roundedRect(c, 53, 119, 49, 16, 6)
	roundedRect(c, 135, 53, 49, 33, 10)
	roundedRect(c, 135, 119, 25, 49, 10)

	// Character 1
	c.beginPath()
	c.arc(37, 37, 13, Math.PI/7, -Math.PI/7, false)
	c.fillStyle = "gold"
	c.lineTo(34, 37)
	c.fill()
	c.fillStyle = "black"

	// blocks
	for(i = 0; i < 8; i++) {c.fillRect(51+i*16, 35, 4, 4)}
	for(i = 0; i < 6; i++) {c.fillRect(115, 51+i*16, 4, 4)}
	for(i = 0; i < 8; i++) {c.fillRect(51+i*16, 99, 4, 4)}

	// character 2
	c.beginPath()
	c.moveTo(83, 116)
	c.lineTo(83, 102)
	c.fillStyle = "green"
	c.bezierCurveTo(83, 94, 89, 88, 97, 88)
	c.bezierCurveTo(105, 88, 111, 94, 111, 102)
	c.lineTo(111, 116)
	c.lineTo(106.333, 111.333)
	c.lineTo(101.666, 116)
	c.lineTo(97, 111.333)
	c.lineTo(92.333, 116)
	c.lineTo(87.666, 111.333)
	c.lineTo(83, 116)
	c.fill()
	c.fillStyle = "white"
	c.beginPath()
	c.moveTo(91, 96)
	c.bezierCurveTo(88, 96, 87, 99, 87, 101)
	c.bezierCurveTo(87, 103, 88, 106, 91, 106)
	c.bezierCurveTo(94, 106, 95, 103, 95, 101)
	c.bezierCurveTo(95, 99, 94, 96, 91, 96)
	c.moveTo(103, 96)
	c.bezierCurveTo(100, 96, 99, 99, 99, 101)
	c.bezierCurveTo(99, 103, 100, 106, 103, 106)
	c.bezierCurveTo(106, 106, 107, 103, 107, 101)
	c.bezierCurveTo(107, 99, 106, 96, 103, 96)
	c.fill()
	c.fillStyle = "blue"
	c.beginPath()
	c.arc(101, 102, 2, 0, Math.PI*2, true)
	c.fill()
	c.beginPath()
	c.arc(89, 102, 2, 0, Math.PI*2, true)
	c.fill()
}





function Graph()
{
	this.vertices = []
	this.edges = []

	this.newV = function(x, y)	{var v = new Vertex(x, y); this.addV(v); return this.vertices[this.vertices.length-1]}
	this.addV = function(v)	 {this.vertices.push(v); v.draw()}
	this.newE = function(a, b)	{var e = new Edge(a, b); this.addE(e); return this.edges[this.edges.length-1]}
	this.addE = function(e)	 {this.edges.push(e); e.draw()}
	this.getV = function(i)	 {return this.vertices[i]}
	this.getE = function(i)	 {return this.edges[i]}

	this.collide = function(x, y)
	{
		for(var v in this.vertices)
		{
			if (this.vertices[v].proximity(x, y) < 5)
			{
				this.vertices[v].recolor("blue")
				return this.vertices[v]
			}
			else
			{
				this.vertices[v].recolor("black")
			}
		}
	}

	this.draw = function()
	{
		for(var v in this.vertices)
		{
			this.vertices[v].draw()
		}
		for(var e in this.edges)
		{
			this.edges[e].draw()
		}
	}
	this.crossCount = function()
	{
		var total = 0
		for(var i in range(0, this.edges.length-1))
		{
			for(var j in range(parseInt(i)+1, this.edges.length-1))
			{
				if (i == j) {continue}
				x1 = this.edges[i].a.x; y1 = this.edges[i].a.y
				x2 = this.edges[i].b.x; y2 = this.edges[i].b.y
				x3 = this.edges[j].a.x; y3 = this.edges[j].a.y
				x4 = this.edges[j].b.x; y4 = this.edges[j].b.y
				// alert(i+" "+j+" "+x1+" "+y1+" "+x2+" "+y2+" "+x3+" "+y3+" "+x4+" "+y4)
				var den = (y4 - y3) * (x2 - x1) - (x4 * x3) * (y2 - y1)

				if (den == 0) {continue}

				var ua = ((x4 - x3) * (y1 - y3) - (y4 * y3) * (x1 - x3))
				var ub = ((x2 - x1) * (y1 - y3) - (y2 * y1) * (x1 - x3))

				if (ua > 0 && ua < 1 && ub > 0 && ub < 1)
				{
					total++
				}
			}
		}
		return total
	}
}






function Line(a, b)
{
	this.a = a
	this.b = b

	// if (!a || !b) {throw TypeError("Must provide two points.")}

	this.getA = function()	{return this.a}
	this.getB = function()	{return this.b}
	this.setA = function(a) {this.a = a}
	this.setB = function(b) {this.b = b}
	this.draw = function()
	{
		c.beginPath()
		c.moveTo(this.a.x, this.a.y)
		c.lineTo(this.b.x, this.b.y)
		c.stroke()
		c.closePath()
		return this
	}
	this.swap = function()
	{
		var c = this.a
		this.a = this.b
		this.b = c
	}
	this.slope = function()
	{
		return (a.y - b.y) / (a.x - b.x)
	}
	this.intercept = function()
	{
		return this.a.y - this.slope() * this.a.x
	}
	this.distance = function()
	{
		var dx = this.a.x - this.b.x
		var dy = this.a.y - this.b.y
		return Math.sqrt(dx * dx + dy * dy)
	}
	this.equals = function(that)
	{
		return this.a.equals(that.a) && this.b.equals(that.b)
	}
}


function randomNumber(min, max, round)
{
	result = (Math.random()*max)+min
	result *= Math.pow(10, round)
	result = Math.round(result)
	result /= Math.pow(10, round)
	return result
}


function comp_sum(array)
{
	var sum = 0
	for (i in array) {sum += parseInt(array[i])}
	return sum
}
function comp_ave(array)
{
	var ave = comp_sum(array)/array.length
	return ave
}
function comp_dev(array)
{
	var mean = comp_ave(array)
	var dev = 0
	for (i in array) {array[i] = (array[i] - mean)}
	for (i in array) {array[i] = (array[i] * array[i])}
	for (i in array) {dev += array[i]}
	dev /= (array.length-1)
	dev = Math.sqrt(dev)
	return dev
}
function get_r(xs, ys, xbar, ybar, sdx, sdy)
{
	var xy = 0
	for(var j = 0; j < xs.length; j++)
	{
		xs[j] = parseFloat(xs[j])
		ys[j] = parseFloat(ys[j])
		xy += (xs[j] - xbar) * (ys[j] - ybar)
	}
	corr = Math.round(1/(xs.length-1)*xy/(sdx*sdy)*10000)/10000
	return corr
}

function least_squares(twodarray)
{
	var ave = []
	for (var j = 0; j < twodarray[0].length; j++)
	{
		aver = []
		for (var i = 0; i < twodarray.length; i++)
		{
			aver.push(twodarray[i][j])
		}
		ave.push(aver)
	}
	var xbar = comp_ave(ave[0].slice())
	var ybar = comp_ave(ave[1].slice())
	var sdx = comp_dev(ave[0].slice())
	var sdy = comp_dev(ave[1].slice())
	var r = get_r(ave[0].slice(), ave[1].slice(), xbar, ybar, sdx, sdy)

	var b = r*(sdy/sdx)
	var a = ybar - (b*xbar)

	return [a, b].slice()
}






//	 floor, ceil, round
//	 max, min
//	 pow, sqrt
//	 sin, cos, tan, asin, acos, atan

//	 Math.SQRT2
//	 1.4142135623730951
//	 Math.E
//	 2.718281828459045
//	 Math.LN2
//	 0.6931471805599453
//	 Math.LN10
//	 2.302585092994046
//	 Number.MAX_VALUE
//	 Number.MIN_VALUE
//	 Number.NaN
//	 Number.POSITIVE_INFINITY
//	 Number.NEGATIVE_INFINITY

//	 Number.toFixed()
//	 String.fromCharCode(115, 99, 114, 105, 112, 116);
//	 charAt & charCodeAt


function Maths()
{
	// this.random = function(min, max, round)
	// {
	// 	result = (Math.random()*max)+min
	// 	result *= Math.pow(10, round)
	// 	result = Math.round(result)
	// 	result /= Math.pow(10, round)
	// 	return result
	// }
	// this.rand = function(n) {return Math.random()*n}
	// this.randI = function(n) {return parseInt(rnd(n))}
	this.range = function(start, end, step)
	{
		var range = []
		var typeofStart = typeof start
		var typeofEnd = typeof end

		if (step === 0) {throw TypeError("Step cannot be zero.") }
		if (typeofStart == "undefined" || typeofEnd == "undefined") {throw TypeError("Must pass start and end arguments.")}
		else if (typeofStart != typeofEnd) {throw TypeError("Start and end arguments must be of same type."+typeofStart+typeofEnd)}
		typeof step == "undefined" && (step = 1)
		if (end < start) {step = -step}
		if (typeofStart == "number") {while (step > 0 ? end >= start : end <= start) {range.push(start); start += step}}
		else if (typeofStart == "string")
		{
			if (start.length != 1 || end.length != 1) {throw TypeError("Only strings with one character are supported.") }
			start = start.charCodeAt(0)
			end = end.charCodeAt(0)
			while (step > 0 ? end >= start : end <= start) {range.push(String.fromCharCode(start)); start += step}
		}
		else {throw TypeError("Only string and number types are supported")}
		return range
	}
	this.convert = function(src, srcAlphabet, dstAlphabet, caps)
	{
		alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"

		if (caps == true) {alphabet = alphabet.toUpperCase()}
		if (typeof src === "number") {src = String(src)}
		if (typeof srcAlphabet !== typeof dstAlphabet) {TypeError("Alphabet types don't match. ")}
		if (typeof srcAlphabet === "number")
		{
			var srcBase = srcAlphabet
			var dstBase = dstAlphabet
			srcAlphabet = alphabet.substring(0, srcBase)
			dstAlphabet = alphabet.substring(0, dstBase)
		}
		if (typeof srcAlphabet === "string")
		{
			var srcBase = srcAlphabet.length
			var dstBase = dstAlphabet.length
		}
		var wet = src, val = 0, mlt = 1
		while (wet.length > 0)
		{
			var digit= wet.charAt(wet.length - 1)
			val	 += mlt * srcAlphabet.indexOf(digit)
			wet			= wet.substring(0, wet.length - 1)
			mlt	 *= srcBase
		}
		wet			= val
		var ret		= ""
		while (wet >= dstBase)
		{
			var digitVal = wet % dstBase
			var digit		= dstAlphabet.charAt(digitVal)
			ret			= digit + ret
			wet /= dstBase
		}
		var digit		= dstAlphabet.charAt(wet)
		return digit + ret
	}
	this.base26 = function(value)
	{
		var converted = ""
		var iteration = false
		do
		{
			var remainder = value % 26 + 1
			if (iteration == false && value < 26)
			{
				remainder--
			}
			converted = String.fromCharCode(64 + remainder) + converted
			value = (value - remainder) / 26

			iteration = true
		}
		while (value > 0)
		return converted
	}
}
function Point(x, y, color, velocity, radius, mass)
{
	this.x = x || 0
	this.y = y || 0
	this.color = color || "black"
	this.mass = mass
	this.acceleration = {x: 0, y: -10}
	this.velocity = velocity
	this.radius = radius

	if (empty(color))	 {color = "black"}
	if (empty(mass))	{mass = 1.0}


	this.applyForce = function(x, y)
	{
		this.velocity.x += x
		return this.velocity.y += y
	}

	this.tick = function()
	{
		if (this.y + this.velocity.y * .1 < 0 && this.velocity.y <= 0.1)
		{
			this.velocity.y = -this.velocity.y * .7
		}
		if ((this.x + this.velocity.x * .1 < 0) || (this.x + this.velocity.x * .1 > 512))
		{
			this.velocity.x = -this.velocity.x * .7
		}
		this.y += this.velocity.y * .1
		this.x += this.velocity.x * .1
		this.velocity.x += this.acceleration.x
		return this.velocity.y += this.acceleration.y
	}

	this.display = function(ctx)
	{
		ctx.save()
		ctx.beginPath()
		ctx.fillStyle = "rgba(" + this.color.red + ", " + this.color.green + ", " + this.color.blue + ", .8)"
		ctx.arc(this.x, 512 - this.y, this.radius, 0, 20, true)
		ctx.fill()
		return ctx.restore()
	}

	this.draw = function()
	{
		c.beginPath()
		c.arc(this.x, this.y, 5, 0, 2*Math.PI)
		c.fill()
		c.fillStyle = color
		c.closePath()
		return this
	}
	this.recolor = function(color)
	{
		this.color = color
		c.beginPath()
		c.arc(this.x, this.y, 5, 0, 2*Math.PI)
		c.fillStyle = color
		c.fill()
		c.closePath()
		return this
	}
	this.equals = function(that)
	{
		return this.x == that.x && this.y == that.y
	}
	this.proximity = function(x, y)
	{
		var dx = this.x - (x - o.left)
		var dy = this.y - (y - o.top)
		return Math.sqrt(dx * dx + dy * dy)
	}
	this.distance = function(that)
	{
		var dx = this.x - that.x
		var dy = this.y - that.y
		return Math.sqrt(dx * dx + dy * dy)
	}
	this.getX = function() {return x}
	this.getY = function() {return y}
	this.setX = function(x) {this.x = x}
	this.setY = function(y) {this.y = y}
	this.clone = function()
	{
		return new Point(this.x, this.y)
	}

	this.draw()
	this.add = function(v)
	{
		return new Point(this.x + v.x, this.y + v.y)
	}
	this.clone = function()
	{
		return new Point(this.x, this.y)
	}
	this.degreesTo = function(v)
	{
		var dx = this.x - v.x;
		var dy = this.y - v.y;
		var angle = Math.atan2(dy, dx); //	 radians
		return angle * (180 / Math.PI); //	 degrees
	}
	this.distance = function(v)
	{
		var x = this.x - v.x;
		var y = this.y - v.y;
		return Math.sqrt(x * x + y * y)
	}
	this.equals = function(toCompare)
	{
		return this.x == toCompare.x && this.y == toCompare.y
	}
	this.interpolate = function(v, f)
	{
		return new Point((this.x + v.x) * f, (this.y + v.y) * f)
	}
	this.length = function()
	{
		return Math.sqrt(this.x * this.x + this.y * this.y)
	}
	this.normalize = function(thickness)
	{
		var l = this.length();
		this.x = this.x / l * thickness;
		this.y = this.y / l * thickness;
	}
	this.orbit = function(origin, arcWidth, arcHeight, degrees)
	{
		var radians = degrees * (Math.PI / 180);
		this.x = origin.x + arcWidth * Math.cos(radians);
		this.y = origin.y + arcHeight * Math.sin(radians);
	}
	this.offset = function(dx, dy)
	{
		this.x += dx;
		this.y += dy;
	}
	this.subtract = function(v)
	{
		return new Point(this.x - v.x, this.y - v.y)
	}
	this.toString = function()
	{
		return "(x=" + this.x + ", y=" + this.y + ")"
	}
	return this
}
Point.interpolate = function(pt1, pt2, f)
{
	return new Point((pt1.x + pt2.x) * f, (pt1.y + pt2.y) * f)
}
Point.polar = function(len, angle)
{
	return new Point(len * Math.sin(angle), len * Math.cos(angle))
}
Point.distance = function(pt1, pt2)
{
	var x = pt1.x - pt2.x
	var y = pt1.y - pt2.y
	return Math.sqrt(x * x + y * y)
}

function halfway(a, b)
{
	var dx = (a[0] + b[0]) / 2
	var dy = (a[1] + b[1]) / 2
	return {dx: dx, dy: dy}
}



function colorFormat(r, g, b, a)
{
	if (r > 255) {r = 255}
	if (g > 255) {g = 255}
	if (b > 255) {b = 255}

	var color = "rgba("+r+", "+g+", "+b+", "+a+")"
	$("title").html(color)
	return color
}

function colorChooser()
{
	var c1 = Math.round(parseInt($("#d1").slider("value")))
	var c2 = Math.round(parseInt($("#d2").slider("value")))
	var c3 = Math.round(parseInt($("#d3").slider("value")))
	var v	= (c1 + c2 + c3) / 12 - .25

	var r = Math.round(510 * (1 - v))
	var g = Math.round(510 * v)

	var color = colorFormat(r, g, 0, .75)

	return color
}

function Color(r, g, b, a)
{
	if (!a) {a = 1}

	this.r = r
	this.g = g
	this.b = b
	this.a = a


	this.rgb = function()
	{
		return "rgb("+this.r+", "+this.g+", "+this.b+")"
	}

	this.rgba = function()
	{
		return "rgba("+this.r+", "+this.g+", "+this.b+", "+this.a+")"
	}

	this.rgb2hex = function(r, g, b)
	{
		var hex = [r.toString(16), g.toString(16), b.toString(16)]
		$.each(hex, function(nr, val)
		{
			if (val.length === 1)
			{
				hex[ nr ] = "0" + val;
			}
		})
		return hex.join("").toUpperCase()
	}

	this.hex2rgb = function(hex)
	{
		R = hexToR(hex);
		G = hexToG(hex);
		B = hexToB(hex);
		return "rgb("+R+", "+G+", "+B+")"
	}
	function hexToR(h) {return parseInt((cutHex(h)).substring(0,2),16)}
	function hexToG(h) {return parseInt((cutHex(h)).substring(2,4),16)}
	function hexToB(h) {return parseInt((cutHex(h)).substring(4,6),16)}
	function cutHex(h) {return (h.charAt(0)=="#") ? h.substring(1,7):h}

	this.random = function(a)
	{
		if (a == "hex")
		{
			var letters = '0123456789ABCDEF'.split('')
			var color = '#'
			for (var i = 0; i < 6; i++)
			{
				color += letters[Math.round(Math.random() * 15)]
			}
			return color
		}
		if (a == "rgb")
		{
			return "rgb(" + randomnumber(0, 255, 0) + ", " + randomnumber(0, 255, 0) + ", " + randomnumber(0, 255, 0) + ")"
		}
		if (a == "rgba")
		{
			return "rgba(" + randomnumber(0, 255, 0) + ", " + randomnumber(0, 255, 0) + ", " + randomnumber(0, 255, 0) + ", " + alpha + ")"
		}

		var letters = '0123456789ABCDEF'.split('')
		var color = '#'
		for (var i = 0; i < 6; i++)
		{
			color += letters[Math.round(Math.random() * 15)]
		}
		return color
	}

	return this
}

var colors =
[
	{"hex":"F0F8FF", "name":"aliceblue"},
	{"hex":"FFA07A", "name":"lightsalmon"},
	{"hex":"FAEBD7", "name":"antiquewhite"},
	{"hex":"20B2AA", "name":"lightseagreen"},
	{"hex":"00FFFF", "name":"aqua"},
	{"hex":"87CEFA", "name":"lightskyblue"},
	{"hex":"7FFFD4", "name":"aquamarine"},
	{"hex":"778899", "name":"lightslategray"},
	{"hex":"F0FFFF", "name":"azure"},
	{"hex":"B0C4DE", "name":"lightsteelblue"},
	{"hex":"F5F5DC", "name":"beige"},
	{"hex":"FFFFE0", "name":"lightyellow"},
	{"hex":"FFE4C4", "name":"bisque"},
	{"hex":"00FF00", "name":"lime"},
	{"hex":"000000", "name":"black"},
	{"hex":"32CD32", "name":"limegreen"},
	{"hex":"FFEBCD", "name":"blanchedalmond"},
	{"hex":"FAF0E6", "name":"linen"},
	{"hex":"0000FF", "name":"blue"},
	{"hex":"FF00FF", "name":"magenta"},
	{"hex":"8A2BE2", "name":"blueviolet"},
	{"hex":"800000", "name":"maroon"},
	{"hex":"A52A2A", "name":"brown"},
	{"hex":"66CDAA", "name":"mediumaquamarine"},
	{"hex":"DEB887", "name":"burlywood"},
	{"hex":"0000CD", "name":"mediumblue"},
	{"hex":"5F9EA0", "name":"cadetblue"},
	{"hex":"BA55D3", "name":"mediumorchid"},
	{"hex":"7FFF00", "name":"chartreuse"},
	{"hex":"9370DB", "name":"mediumpurple"},
	{"hex":"D2691E", "name":"chocolate"},
	{"hex":"3CB371", "name":"mediumseagreen"},
	{"hex":"FF7F50", "name":"coral"},
	{"hex":"7B68EE", "name":"mediumslateblue"},
	{"hex":"6495ED", "name":"cornflowerblue"},
	{"hex":"00FA9A", "name":"mediumspringgreen"},
	{"hex":"FFF8DC", "name":"cornsilk"},
	{"hex":"48D1CC", "name":"mediumturquoise"},
	{"hex":"DC143C", "name":"crimson"},
	{"hex":"C71585", "name":"mediumvioletred"},
	{"hex":"00FFFF", "name":"cyan"},
	{"hex":"191970", "name":"midnightblue"},
	{"hex":"00008B", "name":"darkblue"},
	{"hex":"F5FFFA", "name":"mintcream"},
	{"hex":"008B8B", "name":"darkcyan"},
	{"hex":"FFE4E1", "name":"mistyrose"},
	{"hex":"B8860B", "name":"darkgoldenrod"},
	{"hex":"FFE4B5", "name":"moccasin"},
	{"hex":"A9A9A9", "name":"darkgray"},
	{"hex":"FFDEAD", "name":"navajowhite"},
	{"hex":"006400", "name":"darkgreen"},
	{"hex":"000080", "name":"navy"},
	{"hex":"BDB76B", "name":"darkkhaki"},
	{"hex":"FDF5E6", "name":"oldlace"},
	{"hex":"8B008B", "name":"darkmagenta"},
	{"hex":"808000", "name":"olive"},
	{"hex":"556B2F", "name":"darkolivegreen"},
	{"hex":"6B8E23", "name":"olivedrab"},
	{"hex":"FF8C00", "name":"darkorange"},
	{"hex":"FFA500", "name":"orange"},
	{"hex":"9932CC", "name":"darkorchid"},
	{"hex":"FF4500", "name":"orangered"},
	{"hex":"8B0000", "name":"darkred"},
	{"hex":"DA70D6", "name":"orchid"},
	{"hex":"E9967A", "name":"darksalmon"},
	{"hex":"EEE8AA", "name":"palegoldenrod"},
	{"hex":"8FBC8F", "name":"darkseagreen"},
	{"hex":"98FB98", "name":"palegreen"},
	{"hex":"483D8B", "name":"darkslateblue"},
	{"hex":"AFEEEE", "name":"paleturquoise"},
	{"hex":"2F4F4F", "name":"darkslategray"},
	{"hex":"DB7093", "name":"palevioletred"},
	{"hex":"00CED1", "name":"darkturquoise"},
	{"hex":"FFEFD5", "name":"papayawhip"},
	{"hex":"9400D3", "name":"darkviolet"},
	{"hex":"FFDAB9", "name":"peachpuff"},
	{"hex":"FF1493", "name":"deeppink"},
	{"hex":"CD853F", "name":"peru"},
	{"hex":"00BFFF", "name":"deepskyblue"},
	{"hex":"FFC0CB", "name":"pink"},
	{"hex":"696969", "name":"dimgray"},
	{"hex":"DDA0DD", "name":"plum"},
	{"hex":"1E90FF", "name":"dodgerblue"},
	{"hex":"B0E0E6", "name":"powderblue"},
	{"hex":"B22222", "name":"firebrick"},
	{"hex":"800080", "name":"purple"},
	{"hex":"FFFAF0", "name":"floralwhite"},
	{"hex":"FF0000", "name":"red"},
	{"hex":"228B22", "name":"forestgreen"},
	{"hex":"BC8F8F", "name":"rosybrown"},
	{"hex":"FF00FF", "name":"fuchsia"},
	{"hex":"4169E1", "name":"royalblue"},
	{"hex":"DCDCDC", "name":"gainsboro"},
	{"hex":"8B4513", "name":"saddlebrown"},
	{"hex":"F8F8FF", "name":"ghostwhite"},
	{"hex":"FA8072", "name":"salmon"},
	{"hex":"FFD700", "name":"gold"},
	{"hex":"FAA460", "name":"sandybrown"},
	{"hex":"DAA520", "name":"goldenrod"},
	{"hex":"2E8B57", "name":"seagreen"},
	{"hex":"808080", "name":"gray"},
	{"hex":"FFF5EE", "name":"seashell"},
	{"hex":"008000", "name":"green"},
	{"hex":"A0522D", "name":"sienna"},
	{"hex":"ADFF2F", "name":"greenyellow"},
	{"hex":"C0C0C0", "name":"silver"},
	{"hex":"F0FFF0", "name":"honeydew"},
	{"hex":"87CEEB", "name":"skyblue"},
	{"hex":"FF69B4", "name":"hotpink"},
	{"hex":"6A5ACD", "name":"slateblue"},
	{"hex":"CD5C5C", "name":"indianred"},
	{"hex":"708090", "name":"slategray"},
	{"hex":"4B0082", "name":"indigo"},
	{"hex":"FFFAFA", "name":"snow"},
	{"hex":"FFFFF0", "name":"ivory"},
	{"hex":"00FF7F", "name":"springgreen"},
	{"hex":"F0E68C", "name":"khaki"},
	{"hex":"4682B4", "name":"steelblue"},
	{"hex":"E6E6FA", "name":"lavender"},
	{"hex":"D2B48C", "name":"tan"},
	{"hex":"FFF0F5", "name":"lavenderblush"},
	{"hex":"008080", "name":"teal"},
	{"hex":"7CFC00", "name":"lawngreen"},
	{"hex":"D8BFD8", "name":"thistle"},
	{"hex":"FFFACD", "name":"lemonchiffon"},
	{"hex":"FF6347", "name":"tomato"},
	{"hex":"ADD8E6", "name":"lightblue"},
	{"hex":"40E0D0", "name":"turquoise"},
	{"hex":"F08080", "name":"lightcoral"},
	{"hex":"EE82EE", "name":"violet"},
	{"hex":"E0FFFF", "name":"lightcyan"},
	{"hex":"F5DEB3", "name":"wheat"},
	{"hex":"FAFAD2", "name":"lightgoldenrodyellow"},
	{"hex":"FFFFFF", "name":"white"},
	{"hex":"90EE90", "name":"lightgreen"},
	{"hex":"F5F5F5", "name":"whitesmoke"},
	{"hex":"D3D3D3", "name":"lightgrey"},
	{"hex":"FFFF00", "name":"yellow"},
	{"hex":"FFB6C1", "name":"lightpink"},
	{"hex":"9ACD32", "name":"yellowgreen"}//,
	// {"hex":"'aqua'/'cyan'"},
	// {"hex":"'gray'/'grey'"},
	// {"hex":"'magenta'/'fuchsia'"}
]




function Cookie()
{
	this.get = function(name)
	{
		var i, x, y, ARRcookies = document.cookie.split(";")
		for (i = 0; i < ARRcookies.length; i++)
		{
			x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="))
			y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1)
			x = x.replace(/^\s+|\s+$/g,"")
			if (x == name) {return unescape(y)}
		}
	}

	this.set = function(name, value, exdays)
	{
		var exdate = new Date()
		exdate.setDate(exdate.getDate() + exdays)
		var cvalue = escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString())
		document.cookie = name + "=" + cvalue
	}

	this.unset = function(name)
	{
		setCookie(name, "", -1)
		return name
	}

	this.clear = function()
	{
		var cookies = document.cookie.split(";")
		for (var i = 0; i < cookies.length; i++)
		{
			unsetCookie(cookies[i].split("=")[0])
		}
	}
}

function showDate()
{
	var d = new Date();
	var curr_date = d.getDate();
	var curr_month = d.getMonth() + 1;
	//months are zero based
	var curr_year = d.getFullYear();
	return curr_date + "-" + curr_month + "-" + curr_year
}



(function($)
{
	$.file_get_contents = function(address)
	{
		return $.ajax({url: address, async: false}).responseText
	}
	$.uppercase = function(input)
	{
		if (typeof input !== "string" || !input) {return null;}
		return input.toUpperCase()
	}
	$.lowercase = function(input)
	{
		if (typeof input !== "string" || !input) {return null;}
		return input.toLowerCase()
	}
	$.capitalize = function(input)
	{
		if (typeof input !== "string" || !input) {return null;}
		return input.charAt(0).toUpperCase() + input.slice(1).toLowerCase()
	}
	$.chomp = function(input, offset)
	{
		if (typeof input !== "string" || !input) {return null;}
		return input.substring(0, input.length-offset)
	}
	$.title = function(input)
	{
		if (arguments.length == 0)
		{
			return $("title").html()
		}
		$("title").html(input)
	}
	$.fn.repeat = function(input, n)
	{
		var result = ""
		for (var i = 0; i < n; i++) {result += input}
		return result
	}
	$.fn.confirm = function(mode)
	{
		if (mode == 1){window.onbeforeunload = function() {return "Please Confirm."}}
		else			{window.onbeforeunload = function() {}}
	}
	$.fn.visible = function()
	{
		return $(this).is(":visible")
	}
	$.fn.antiselect = function()
	{
		$(this).css({"-webkit-touch-callout":"none", "-webkit-user-select":"none", "-khtml-user-select":"none", "-moz-user-select":"none", "-ms-user-select":"none", "user-select":"none"})
		if ($(this)[0].nodeType == 1)
		{
			$(this)[0].setAttribute("unselectable", "on")
		}
		var child = $(this)[0].firstChild
		while (child)
		{
			$(child).antiselect()
			child = child.nextSibling
		}
	}
	$.fn.generateTable = function(x, y, head)
	{
		result = "<table>"
		for (i = 0; i < x; i++)
		{
			head && i == 0 ? result += "<thead>" : ""
			head && i == 1 ? result += "<tbody>" : ""
			result += "<tr>"
			for (j = 0; j < y; j++)
			{
				if	(i == 0)	{result += "<th class='col'>"+String.fromCharCode(64 + j)+"</th>"}
				else if (j == 0)	{result += "<th class='row'>"+i+"</th>"}
				else				{result += "<td></td>"} //<input type='text' class='cell'></input>
			}
			result += "</tr>"
			head && i == 0 ? result += "</thead>" : ""
			head && i == x-1 ? result += "</tbody>" : ""
		}
		result += "</table>"
		$(this).html(result)
	}
	$.fn.maxHeight = function()
	{
		var max = 0
		this.each(function() {max = Math.max(max, $(this).height())})
		return max
	}
	$.fn.maxWidth = function()
	{
		var max = 0
		this.each(function() {max = Math.max(max, $(this).width())})
		return max
	}
	$.fn.tag = function()
	{
		return $(this)[0].tagName
	}
	$.fn.id = function(i)
	{
		if (i === undefined)
		{
			return $(this)[0].id
		}
		if (arguments.length == 0)
		{
			return $(this).attr("id")
		}
		if (i == "")
		{
			$(this).removeAttr("id")
			return this
		}
		$(this).attr("id", i)
	}
	$.fn.removeAttrs = function()
	{
		return this.each(function()
		{
			var attributes = $.map(this.attributes, function(item) {return item.name})
			var el = $(this)
			$.each(attributes, function(i, item) {el.removeAttr(item)})
		})
	}
	$.fn.center = function()
	{
		$(this).css("position", "absolute")
		$(this).css("top",	($(window).height() - $(this).height()) / 2 + $(window).scrollTop()	+ "px")
		$(this).css("left", ($(window).width()	- $(this).width())	/ 2 + $(window).scrollLeft() + "px")
		return $(this)
	}
	$.fn.viewport = function()
	{
		var w = isLessThanIE(8)
			?(!(document.documentElement.clientWidth)
			|| (document.documentElement.clientWidth === 0)) ? document.body.clientWidth:document.documentElement.clientWidth:window.innerWidth
		var h = isLessThanIE(8)
			?(!(document.documentElement.clientHeight)
			|| (document.documentElement.clientHeight === 0)) ? document.body.clientHeight:document.documentElement.clientHeight:window.innerHeight
		return {width: w, height: h}
	}
	$.each({top: "top", bottom: "bottom", left: "left", right: "right"}, function(name, type)
	{
		elem = this[0]
		$.fn[name] = function(value)
		{
			return $.access(this, function(elem, type, value)
			{
				if (value === undefined)
				{
					orig = $.css(elem, type)
					ret = parseFloat(orig)
					return $.isNumeric(ret) ? ret : orig
				}
				$(elem).css(type, value)

			}, type, value, arguments.length, null)
		}
	})
})
(jQuery)



String.prototype.extension 			= function() {return String(this).substring(String(this).length-3, String(this).length)}
String.prototype.is_range			= function() {return String(this).search(/\w\d:\w\d/) != -1}
String.prototype.is_col				= function() {return String(this).search(/\w/) != -1}
String.prototype.is_col_range		= function() {return String(this).search(/\w:\w/) != -1}
String.prototype.is_row				= function() {return String(this).search(/\d/) != -1}
String.prototype.is_row_range		= function() {return String(this).search(/\d:\d/) != -1}
String.prototype.is_number			= function() {return String(this).search(/^\s*(\+|-)?\d+\s*$/) != -1}
String.prototype.isnt_blank			= function() {return String(this).search(/\S/) != -1}
String.prototype.is_decimal			= function() {return String(this).search(/^\s*(\+|-)?((\d+(\.\d+)?)|(\.\d+))\s*$/) != -1}
String.prototype.is_email			= function() {return String(this).search(/^\s*[\w\-\+_]+(\.[\w\-\+_]+)*\@[\w\-\+_]+\.[\w\-\+_]+(\.[\w\-\+_]+)*\s*$/) != -1}
String.prototype.get_digits			= function() {return String(this).replace(/[^\d]/g, "")}
String.prototype.is_number			= function() {return String(this).search(/^\s*(\+|-)?\d+\s*$/) != -1}
String.prototype.is_url				= function() {return /(http:\/\/)?(www\.)?(.+?)(\.com|\.org|\.gov|\.edu)(\/.*?)?/.test(this)}
String.prototype.strip				= function() {return String(this).replace(new RegExp('</?.+?>', 'g'), '') }
String.prototype.isInteger			= function() {return /^-?\d+$/.test(this)}
String.prototype.isPositiveDecimal 	= function() {return (!/\D/.test(this)) || (/^\d+\.\d+$/.test(this))}
String.prototype.isAlphanumeric		= function() {return !(/\W/.test(this))}
String.prototype.validEmail			= function() {return String(this).match(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/) ===null}
String.prototype.checkMail			= function() {return /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(this)}
String.prototype.onlyLetters	 	= function() {return String(this).toLowerCase().replace(/[^a-z]/g, "") }
String.prototype.onlyLettersNums 	= function() {return String(this).toLowerCase().replace(/[^a-z,0-9,-]/g, "")}
String.prototype.trim				= function() {return String(this).replace(/^\s+|\s+$/g, '')}
String.prototype.ltrim				= function() {return String(this).replace(/^\s+/,'')}
String.prototype.rtrim				= function() {return String(this).replace(/\s+$/,'')}
String.prototype.ftrim				= function() {return String(this).replace(/(?:(?:^|\n)\s+|\s+(?:$|\n))/g,'').replace(/\s+/g,' ')}
// String.prototype.prefixArticle	 	= function() {var result = (['a', 'e', 'i', 'o', 'u'].indexOf(this[0]) > -1) ? "an "+this : return "a "+this; return result}
(function()
{
	window.nativeAlert = window.alert
	window.alert = function() {window.nativeAlert(Array.prototype.slice.call(arguments).join(", "))}
	window.onerror = function(msg, url, line) {window.nativeAlert("Message: " + msg, "\nurl: " + url, "\nLine Number: " + line )}
	window.connect = function(a)
	{
		if (a == true)
		{
			window.addEventListener("offline",	function(e) {alert("offline")}, false)
			window.addEventListener("online", 	function(e) {alert("online")}, false)
		}
		return window.navigator.onLine
	}
	window.js = function(a) {window.navigator.javaEnabled(a); return window.navigator.javaEnabled()}
	window.taint = function(a) {window.navigator.taintEnabled(a);	return window.navigator.taintEnabled()}
	window.title = function() 	{document.title(Array.prototype.slice.call(arguments).join(", "))}
	window.video = function() 	{return !!document.createel('video').canPlayType}
	window.empty = function(a) 	{return !(typeof a === "undefined")}
	window.type = function(input)
	{
		if (input instanceof String) 	{return "String"}
		if (input instanceof Number) 	{return "Number"}
		if (input instanceof Boolean)	{return "Boolean"}
		if (input instanceof Object) 	{return "Object"}
		if (input instanceof Array) 	{return "Array"}
		return typeof input
	}
	window.url = function() {return window.location.pathname}
	window.goto = function(url) {window.location.href = url}
	window.getWindowCoords = (navigator.userAgent.toLowerCase().indexOf('opera')>0||navigator.appVersion.toLowerCase().indexOf('safari')!=-1)?function()
	{
		canvasX = window.innerWidth;
		canvasY = window.innerHeight;
	}:function()
	{
		canvasX = document.documentElement.clientWidth||document.body.clientWidth||document.body.scrollWidth;
		canvasY = document.documentElement.clientHeight||document.body.clientHeight||document.body.scrollHeight;
	}
	window.onresize = window.getWindowCoords
	window.apiload = function()
	{
		$("head").append('<script src="http://www.google.com/jsapi" type="text/javascript"></script>')
		google.load('jquery', '1.9.1')
		google.load('jqueryui', '1.5.3')
		// google.load('mootools', '1.2.1')
		// google.load('prototype', '1.6.0.3')
		// google.load('scriptaculous', '1.8.2')
		// google.load('mootools', '1.2.1')
		// google.load('dojo', '1.2.3')
		// google.load('swfobject', '2.1')
		// google.load('yui', '2.6.0')
	}
})

function isLessThanIE(version)
{
	if (navigator.appName === 'Microsoft Internet Explorer')
	{
		var ua = navigator.userAgent, re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})")
		if (re.exec(ua) !== null) {if (parseFloat(RegExp.$1) < version) {return true}}
	}
	return false
}

function insertAtCursor(myField, myValue)
{
	if (document.selection)
	{
		myField.focus()
		sel = document.selection.createRange()
		sel.text = myValue
	}
	else if (myField.selectionStart || myField.selectionStart == '0')
	{
		var startPos = myField.selectionStart
		var endPos = myField.selectionEnd
		restoreTop = myField.scrollTop

		myField.value = myField.value.substring(0, startPos) + myValue + myField.value.substring(endPos, myField.value.length)

		myField.selectionStart = startPos + myValue.length
		myField.selectionEnd = startPos + myValue.length

		if (restoreTop > 0) {myField.scrollTop = restoreTop}
	}
	else {myField.value += myValue}
}










// function Position()
// {

// 	this.offset = function()		{return {x: window.pageXOffset, y: window.pageYOffset}}
// 	this.dimensions = function(){return {inner: {width: window.innerWidth, height: window.innerHeight}, outer: {width: window.outerWidth, height: window.outerHeight}}}
// 	this.d = function() {return {i: {w: window.innerWidth, h: window.innerHeight}, o: {w: window.outerWidth, h: window.outerHeight}}}
// 	// resizeBy()	 Resizes the window by the specified pixels
// 	// resizeTo()	 Resizes the window to the specified width and height
// 	// scroll()
// 	// scrollBy()	 Scrolls the content by the specified number of pixels
// 	// scrollTo()	 Scrolls the content to the specified coordinates

// 	this.viewport = function()
// 	{
// 		var w = isLessThanIE(8)?(!(document.documentElement.clientWidth)	|| (document.documentElement.clientWidth===0))?document.body.clientWidth:document.documentElement.clientWidth:window.innerWidth
// 		var h = isLessThanIE(8)?(!(document.documentElement.clientHeight) 	|| (document.documentElement.clientHeight===0))?document.body.clientHeight:document.documentElement.clientHeight:window.innerHeight;
// 		return {width: w, height: h}
// 	}
// }

// function Timer()
// {
// 	// window.setInterval() Calls a function or evaluates an expression at specified intervals (in milliseconds)
// 	// window.setTimeout()			Calls a function or evaluates an expression after a specified number of milliseconds
// 	// window.clearInterval()	 Clears a timer set with setInterval()
// 	// window.clearTimeout()		Clears a timer set with setTimeout()

// 	this.timedRefresh = function(timeoutPeriod) {window.setTimeout("window.location.reload(true);", timeoutPeriod)}

// }


// function Pane()
// {
// 	// alert()	Displays an alert box with a message and an OK button
// 	// blur()	 Removes focus from the current window

// 	// close()	Closes the current window
// 	// confirm()		Displays a dialog box with a message and an OK and a Cancel button
// 	// createPopup()		Creates a pop-up window
// 	// focus()	Sets focus to the current window
// 	// moveBy() Moves a window relative to its current position
// 	// moveTo() Moves a window to the specified position
// 	// open()	 Opens a new browser window
// 	// print()	Prints the content of the current window
// 	// prompt() Displays a dialog box that prompts the visitor for input

// 	this.iframes = function()	 {return {frames: window.frames, length: window.length}}

// 	this.context = function()	 {return {self: window.self, parent: window.parent, opener: window.opener, top: window.top}}

// }



// function Screen()
// {
// 	this.top			= window.screenTop
// 	this.left	 		= window.screenLeft
// 	this.x				= window.screenX
// 	this.y				= window.screenY

// 	this.availHeight	= window.screen.availHeight // Returns the height of the screen (excluding the Windows Taskbar)
// 	this.availWidth		= window.screen.availWidth	// Returns the width of the screen (excluding the Windows Taskbar)
// 	this.colorDepth		= window.screen.colorDepth	// Returns the bit depth of the color palette for displaying images
// 	this.height			= window.screen.height		// Returns the total height of the screen
// 	this.pixelDepth		= window.screen.pixelDepth	// Returns the color resolution (in bits per pixel) of the screen
// 	this.width			= window.screen.width		// Returns the total width of the screen
// }

// function History()
// {
// 	this.length		= function() 	{return window.history.length}
// 	this.back		= function()	{window.history.back()}
// 	this.backward	= function()	{window.history.back()}
// 	this.forward	= function()	{window.history.forward()}
// 	this.go 		= function(i) 	{window.history.go(i)}
// }

// window.location.hash		 // Returns the anchor portion of a URL
// window.location.host		 // Returns the hostname and port of a URL
// window.location.hostname // Returns the hostname of a URL
// window.location.href		 // Returns the entire URL
// window.location.pathname // Returns the path name of a URL
// window.location.port		 // Returns the port number the server uses for a URL
// window.location.protocol // Returns the protocol of a URL
// window.location.search	 // Returns the query portion of a URL

// assign() Loads a new document
// reload() Reloads the current document
// replace()		Replaces the current document with a new one



