import itertools, copy

class square:
	def __init__(self, val = '0', x = '0', y = '0'):
		self.val, self.loc, self.dom = val, (x, y), ['1', '2', '3', '4', '5', '6', '7', '8', '9']
		if self.val != '0': self.dom = [self.val]

def sector(x, y):
	if x <= 2               and y <= 2:             return (0, 0)
	if x >= 3 and x <= 5    and y <= 2:             return (3, 0)
	if x >= 6               and y <= 2:             return (6, 0)
	if x <= 2               and y >= 3 and y <= 5:  return (0, 3)
	if x >= 3 and x <= 5    and y >= 3 and y <= 5:  return (3, 3)
	if x >= 6               and y >= 3 and y <= 5:  return (6, 3)
	if x <= 2               and y >= 6:             return (0, 6)
	if x >= 3 and x <= 5    and y >= 6:             return (3, 6)
	if x >= 6               and y >= 6:             return (6, 6)	

class puzzle:
	def __init__(self, filename):
		newfile = open(filename, 'r')
		lines = newfile.readlines()
		self.squares = [['' for x in range(9)] for y in range(9)]  
		for x in range(9):
			for y in range(9):
				self.squares[x][y] = square(lines[x][y], x, y)
		newfile.close()
	def draw(self):
		for x in range(9):
			for y in range(9):
				print self.squares[x][y].val, 
				if y == 2 or y == 5: print '|',
			print ''
			if x == 2 or x == 5: print '---------------------'
		print ''
	def solved(self):
		for x in range(9):
			for y in range(9):
				if len(self.squares[x][y].dom) > 1: return False
		return True	
	def copy(self): return copy.deepcopy(self)
	def difference(self, other):
		count = 0
		for x in range(9):
			for y in range(9):
				if int(self.squares[x][y].val) - int(other.squares[x][y].val) != 0:
					count += 1
		return count
	def solve_reduce(self):
		for x in range(9):
			for y in range(9):
				if len(self.squares[x][y].dom) > 1: 	
					for i in range(9):
						if self.squares[i][y].val != '0' and self.squares[x][y].dom.count(self.squares[i][y].dom[0]) != 0:
							self.squares[x][y].dom.remove(self.squares[i][y].dom[0])
					for j in range(9):
						if self.squares[x][j].val != '0' and self.squares[x][y].dom.count(self.squares[x][j].dom[0]) != 0:
							self.squares[x][y].dom.remove(self.squares[x][j].dom[0])
					z = sector(x, y)
					dx, ex, dy, ey = z[0], z[0]+3, z[1], z[1]+3
					for m in range(dx, ex):
						for n in range(dy, ey):
							if self.squares[m][n].val != '0' and self.squares[x][y].dom.count(self.squares[m][n].dom[0]) != 0:
								self.squares[x][y].dom.remove(self.squares[m][n].dom[0])
					if len(self.squares[x][y].dom) == 1: self.squares[x][y].val = self.squares[x][y].dom[0]
# 	def solve_unique(self):
# 		for x in range(9):
# 			for y in range(9):		
# 				if len(self.squares[x][y].dom) > 1: 	
# 					for h in self.squares[x][y].dom:
# 						for i in range(9):
# 							if y = i: continue
# 							for a in self.squares[x][i].dom:
								
				
				
				
				
sudoku = puzzle('medium.txt')
previous = sudoku.copy()
sudoku.solve_reduce()
while sudoku.difference(previous) != 0:
	previous = sudoku.copy()
	sudoku.solve_reduce()

sudoku.draw()
for y in range(9):
	if len(sudoku.squares[7][y].dom) == 1: continue
	dup = False
	for h in sudoku.squares[7][y].dom:
		for dy in range(9):
			if y == dy: continue
			for dh in sudoku.squares[7][dy].dom:
				if h == dh: 
					dup = True
					break
			if dup: break
		dup = False
		if not dup:
			sudoku.squares[7][y].val = h
			sudoku.squares[7][y].dom = list(h)

sudoku.draw()
for x in range(9):
 	for y in range(9):
 		print sudoku.squares[x][y].dom
 	print ''













#def blank():
#    puzzle = Puzzle()
#    puzzle.grid = [['' for x in range(9)] for y in range(9)]
#    for i in range(9):
#        for j in range(9):
#            valueue = int((i*3 + i/3 + j) % (3**2) + 1)
#            puzzle.grid[i][j] = Square(value, i, j)
#    return puzzle
# 
#In any unit (row, column, or box), find three squares that each have a domain that contains the same 3
#numbers or a subset of those numbers. Remove all numbers within that domain from the unit. 
# 
#81 finite domain variables and 27 constraints
#sums must equal 45. helpful? yes, for completion--maybe
# 
# 	def AC3(puzzle):
# 		puzzle.queue = list(itertools.product(puzzle.spaces, repeat=2))
# 		while len(puzzle.queue) > 0:
# 			carc = puzzle.queue.pop()
# 			cx1, cy1, cx2, cy2 = carc[0][0], carc[0][1], carc[1][0], carc[1][1]
# 			csquare1, csquare2 = puzzle.grid[cx1][cy1], puzzle.grid[cx2][cy2]
# 			if revise(puzzle, csquare1, csquare2):
# 				if len(csquare1.domain) == 1: 
# 					csquare1.value = csquare1.domain[0]
# 					continue
# 				for neighbor in csquare1.neighbors:
# 					puzzle.queue.append((csquare1.location, neighbor))
# 		return puzzle
# 
# 	def getneighbors(puzzle, square):
# 		samerow = row_get_coordinates(puzzle, square)
# 		samecol = col_get_coordinates(puzzle, square)
# 		samesec = sec_get_coordinates(puzzle, square)
# 		for coordinate in samerow: 
# 			if coordinate == (square.x, square.y): continue
# 			square.neighbors.append(coordinate)
# 		for coordinate in samecol: 
# 			if coordinate == (square.x, square.y): continue
# 			square.neighbors.append(coordinate)
# 		for coordinate in samesec: 
# 			if coordinate == (square.x, square.y): continue
# 			square.neighbors.append(coordinate)
# 		square.neighbors = list(set(square.neighbors))
# 
# 			
# 	def revise(puzzle, square1, square2):
# 		revised = False
# 		for x in square1.domain:
# 			
# 				square1.domain.remove(x)
# 				revised = True
# 		return revised
