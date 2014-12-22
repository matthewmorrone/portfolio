var MAX=9
var done=0
var stats={"backtracks":0,"iterations":0,"time":0}
var free_cell=false
function Cell(x,y)
{
	this.value=0
	this.x=x
	this.y=y
	this.avail=[]
	this.countAvail=function()
	{
		var free=[1,1,1,1,1,1,1,1,1,1]
		this.avail=[]
		for (var i=0;i<MAX;i++)
		{
			free[cells[i][this.y].value]=0
		}
		for (var j=0;j<MAX;j++)
		{
			free[cells[this.x][j].value]=0
		}
		var start_x=(this.x<3 ? 0 : this.x>5 ? 6 : 3)
		var start_y=(this.y<3 ? 0 : this.y>5 ? 6 : 3)
		var end_x=start_x+3
		var end_y=start_y+3
		for (var i=start_x;i<end_x;i++)
		{
			for (var j=start_y;j<end_y;j++)
			{
				free[cells[i][j].value]=0
			}
		}
		for (var i=1;i<=MAX;i++)
		{
			if (free[i])
			{
				this.avail.push(i)
			}
		}
	}
}
function solve()
{
	stats.iterations++
	if (!free_cell)
	{
		done=1
	}
	if (done)
	{
		return
	}
	var cell=free_cell
	var len=cell.avail.length
	if (!len)
	{
		stats.backtracks++
		return
	}
	for (var i=0;i<len;i++)
	{
		cell.value=cell.avail[i]
		get_free_candidate()
		solve()
		if (done)
		{
			return
		}
	}
	cell.value=0
}
function get_free_candidate()
{
	free_cell=false
	var min=MAX+1
	for (var i=0;i<MAX;i++)
	{
		for (var j=0;j<MAX;j++)
		{
			if(!(cells[i][j].value))
			{
				cells[i][j].countAvail()
				if (cells[i][j].avail.length<min)
				{
					min=cells[i][j].avail.length
					free_cell=cells[i][j]
				}
			}
		}
	}
}
function start_solving()
{
	done=0
	html2cells()
	var d1=new Date()
	var t1=d1.getTime()
	get_free_candidate()
	solve()
	if (done)
	{
		var d2=new Date()
		var t2=d2.getTime()
		cells2html()
		stats.time=(t2-t1)/1000
		var t=stats.time / 1000
		var score=stats.iterations / stats.time
		// alert("BENCHMARK: "+Math.round(score*100)/100+" ips\n\n"+ "iterations: "+stats.iterations+"\n"+ "backtracks: "+stats.backtracks+"\n"+ "time: "+stats.time+" s")
	}
	else
	{
		alert('No solution possible.')
	}
}
var cells={}
function attach(element,event,callback)
{
	if (element.addEventListener)
	{
		element.addEventListener(event,callback,false)
	}
	else if (element.attachEvent)
	{
		element.attachEvent("on"+event,callback)
	}
	else
	{
		element["on"+event]=callback
	}
}
function detach(element,event,callback)
{
	if (element.removeEventListener)
	{
		element.removeEventListener(event,callback,false)
	}
	else if (element.detachEvent)
	{
		element.detachEvent("on"+event,callback)
	}
	else
	{
		element["on"+event]=false
	}
}
function attach_edit(elm)
{
	var ref=function()
	{
		var inp=document.createElement("input")
		inp.setAttribute("size","1")
		inp.setAttribute("type","text")
		inp.style.width="20px"
		inp.style.border="1px solid #000"
		inp.style.textAlign="center"
		inp.value=elm.innerHTML
		while (elm.firstChild)
		{
			elm.removeChild(elm.firstChild)
		}
		elm.appendChild(inp)
		inp.focus()
		var callback=function(event)
		{
			var val=inp.value
			elm.removeChild(inp)
			elm.innerHTML=val
			detach(document,"mousedown",callback)
		}
		attach(document,"mousedown",callback)
	}
	elm.style.cursor="pointer"
	attach(elm,"click",ref)
}
function init()
{
	for (var i=0;i<MAX;i++)
	{
		cells[i]=[]
		for (var j=0;j<MAX;j++)
		{
			cells[i][j]=new Cell(i,j)
		}
	}
}
function cells2html()
{
	for (var i=0;i<MAX;i++)
	{
		for (var j=0;j<MAX;j++)
		{
			var id=i+"_"+j
			document.getElementById(id).innerHTML=(cells[i][j].value ? cells[i][j].value : "")
		}
	}
}
function html2cells()
{
	for (var i=0;i<MAX;i++)
	{
		for (var j=0;j<MAX;j++)
		{
			var id=i+"_"+j
			var val=document.getElementById(id).innerHTML
			var newval=parseInt(val)
			cells[i][j].value=( isNaN(newval) ? 0 : newval)
		}
	}
	cells2html()
}
function generate()
{
	var table=document.getElementsByTagName("tbody")[0]
	for (var j=0;j<MAX;j++)
	{
		var tr=document.createElement("tr")
		for (var i=0;i<MAX;i++)
		{
			var id=i+"_"+j
			var td=document.createElement("td")
			if (i==3)
			{
				td.className += " left "
			}
			if (i==5)
			{
				td.className += " right "
			}
			if (j==3)
			{
				td.className += " top "
			}
			if (j==5)
			{
				td.className += " bottom "
			}
			td.id=id
			attach_edit(td)
			tr.appendChild(td)
		}
		table.appendChild(tr)
	}
}
var easy 	= "020000010,850901074,004306200,041030980,000507000,062080540,009205800,230408095,080000060"
var medium 	= "008040503,063090000,150800006,001030000,470902031,000050900,500009048,000020350,309080100"
var hard 	= "000342000,540070080,002005406,060200000,308000204,000008070,609120500,030080019,000539000"


function from_text(input)
{
	var table = input.split(",")
	for(row in table)
	{
		table[row] = table[row].split("")
	}
	for(var i = 0; i < MAX; i++)
	{
		for(var j = 0; j < MAX; j++)
		{
			if (table[i][j] == 0) {continue}
			var td = document.getElementById(i+"_"+j)
			td.innerHTML = table[i][j]
			attach_edit(td)
		}
	}
}

function load_defaults()
{


	cells[1][0].value=2
	cells[5][0].value=8
	cells[8][0].value=3
	cells[4][1].value=4
	cells[2][2].value=4
	cells[3][2].value=9
	cells[6][2].value=6
	cells[7][2].value=1
	cells[3][3].value=6
	cells[4][3].value=1
	cells[6][3].value=4
	cells[6][4].value=9
	cells[8][4].value=5
	cells[1][5].value=9
	cells[2][5].value=3
	cells[8][5].value=1
	cells[2][6].value=6
	cells[3][6].value=7
	cells[7][6].value=2
	cells[8][6].value=9
	cells[1][7].value=1
	cells[0][8].value=3
	cells[4][8].value=5
	cells[6][8].value=7
}



function init_page()
{
	init()
	// load_defaults()
	cells2html()
	from_text(hard)

}


