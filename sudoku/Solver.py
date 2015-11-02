import itertools, copy

#81 finite domain variables and 27 constraints
#http://en.wikipedia.org/wiki/Algorithmics_of_sudoku
#http://en.wikipedia.org/wiki/AC-3_algorithm
#sums must equal 45. helpful? yes, for completion--maybe

class Square:
    def __init__(self, value = '0', x = '0', y = '0'):
        self.value, self.domain = value, ['1', '2', '3', '4', '5', '6', '7', '8', '9']
        self.x, self.y = x, y
        self.location, self.neighbors = (x, y), []
        
class Puzzle: 
    def __init__(self):
        self.grid = []
        self.spaces = []
        self.queue = []
        #self.completed = []

def alldiff(squares): return len(squares) == len(set(squares))
def row_check(puzzle, x):
    values = []
    for y in range(9): values.append(puzzle.grid[x][y].value)
    dvalues = filter(lambda a: a != '0', values)
    svalues = list(set(dvalues))
    return len(dvalues) == len(svalues)
def row_get_squares(puzzle, square):
    squares = []
    for y in range(9): squares.append(puzzle.grid[square.x][y])
    return squares
def row_get_coordinates(puzzle, square):
    squares = []
    for y in range(9): squares.append((square.x, y))
    return squares
def row_get_values(puzzle, square):
    values = []
    for y in range(9): values.append(puzzle.grid[square.x][y].value)
    dvalues = filter(lambda a: a != '0', values)
    svalues = list(set(dvalues))
    return svalues
def row_sum(puzzle, square):
    total = 0
    for y in range(9): total += puzzle.grid[square.x][y].value
    return total
def col_check(puzzle, y):
    values = []
    for x in range(9): values.append(puzzle.grid[x][y].value)
    dvalues = filter(lambda a: a != '0', values)
    svalues = list(set(dvalues))
    return len(dvalues) == len(svalues)
def col_get_squares(puzzle, square):
    squares = []
    for x in range(9): squares.append(puzzle.grid[x][square.y])
    return squares   
def col_get_coordinates(puzzle, square):
    squares = []
    for x in range(9): squares.append((x, square.y))
    return squares 
def col_get_values(puzzle, square):
    values = []
    for x in range(9): values.append(puzzle.grid[x][square.y].value)
    dvalues = filter(lambda a: a != '0', values)
    svalues = list(set(dvalues))
    return svalues    
def col_sum(puzzle, square):
    total = 0
    for x in range(9): total += puzzle.grid[x][square.y].value
    return total
def sec_check(puzzle, z):
    values = []
    start = sectorcheck(z)
    for x in range(start[0], start[0]+3):
        for y in range(start[1], start[1]+3):
            values.append(puzzle.grid[x][y].value)
    dvalues = filter(lambda a: a != '0', values)
    svalues = list(set(dvalues))
    return len(dvalues) == len(svalues)
def sec_get_squares(puzzle, square):
    squares = []
    start = sectorcheck(checksector(square.x, square.y))
    for x in range(start[0], start[0]+3):
        for y in range(start[1], start[1]+3):
            squares.append(puzzle.grid[x][y])
    return squares
def sec_get_coordinates(puzzle, square):
    squares = []
    start = sectorcheck(checksector(square.x, square.y))
    for x in range(start[0], start[0]+3):
        for y in range(start[1], start[1]+3):
            squares.append((x, y))
    return squares
def sec_get_values(puzzle, square):
    values = []
    start = sectorcheck(checksector(square.x, square.y))
    for x in range(start[0], start[0]+3):
        for y in range(start[1], start[1]+3):
            values.append(puzzle.grid[x][y].value)
    dvalues = filter(lambda a: a != '0', values)
    svalues = list(set(dvalues))
    return svalues
def sec_sum(puzzle, z):
    start = sectorcheck(z)
    total = 0
    for x in range(start[0], start[0]+3):
        for y in range(start[1], start[1]+3):
            total += puzzle.grid[x][y].value
    return total
def sectorcheck(z):
    if z == 1: return (0, 0)
    if z == 2: return (3, 0)
    if z == 3: return (6, 0)
    if z == 4: return (0, 3)
    if z == 5: return (3, 3)
    if z == 6: return (6, 3)
    if z == 7: return (0, 6)
    if z == 8: return (3, 6)
    if z == 9: return (6, 6)         
def checksector(x, y):
    if x <= 2               and y <= 2:             return 1
    if x >= 3 and x <= 5    and y <= 2:             return 2
    if x >= 6               and y <= 2:             return 3
    if x <= 2               and y >= 3 and y <= 5:  return 4
    if x >= 3 and x <= 5    and y >= 3 and y <= 5:  return 5
    if x >= 6               and y >= 3 and y <= 5:  return 6
    if x <= 2               and y >= 6:             return 7
    if x >= 3 and x <= 5    and y >= 6:             return 8
    if x >= 6               and y >= 6:             return 9

def fromfile(filename):
    newfile = open(filename, 'r')
    lines = newfile.readlines()
    puzzle = Puzzle()
    puzzle.grid = [['' for x in range(9)] for y in range(9)]  
    for x in range(9):
        for y in range(9):
            puzzle.grid[x][y] = Square(lines[x][y], x, y)
            getneighbors(puzzle, puzzle.grid[x][y])
            puzzle.spaces.append((x, y))
    newfile.close()
    return puzzle

def getneighbors(puzzle, square):
    samerow, samecol, samesec = row_get_coordinates(puzzle, square), col_get_coordinates(puzzle, square), sec_get_coordinates(puzzle, square)
    for coordinate in samerow: 
        if coordinate == (square.x, square.y): continue
        square.neighbors.append(coordinate)
    for coordinate in samecol: 
        if coordinate == (square.x, square.y): continue
        square.neighbors.append(coordinate)
    for coordinate in samesec: 
        if coordinate == (square.x, square.y): continue
        square.neighbors.append(coordinate)
    square.neighbors = list(set(square.neighbors))
    
def draw(puzzle):
    for x in range(9):
        for y in range(9):
            print puzzle.grid[x][y].value, 
            if y == 2 or y == 5: print '|',
        print ''
        if x == 2 or x == 5: print '---------------------'
    print ''

def AC3(puzzle):
    puzzle.queue = list(itertools.product(puzzle.spaces, repeat=2))
    while len(puzzle.queue) > 0:
        carc = puzzle.queue.pop()
        cx1, cy1, cx2, cy2 = carc[0][0], carc[0][1], carc[1][0], carc[1][1]
        csquare1, csquare2 = puzzle.grid[cx1][cy1], puzzle.grid[cx2][cy2]
        if revise(puzzle, csquare1, csquare2):
            if len(csquare1.domain) == 1: 
                csquare1.value = csquare1.domain[0]
                continue
            for neighbor in csquare1.neighbors:
                puzzle.queue.append((csquare1.location, neighbor))
    return puzzle
        
def revise(puzzle, square1, square2):
    revised = False
    for x in square1.domain:
        
            square1.domain.remove(x)
            revised = True
    return revised

def one_level_supposition(self):
        progress=True
        while progress :
            progress=False
            for row in range(0,9) :
                for col in range(0,9):
                    if len(self.squares[row][col]) > 1 :
                        bad_x = []
                        for x in self.squares[row][col] :
                            sudoku_copy = self.copy()
                            try:
                                sudoku_copy.set_cell(row,col,x)
                                sudoku_copy.check(level=1)
                            except AssertionError, e :
                                bad_x.append(x)
                            del sudoku_copy
                        if len(bad_x) == 0 :
                            pass
                        elif len(bad_x) < len(self.squares[row][col]) :
                            for x in bad_x :
                                self.cell_exclude(row,col,x)
                                self.check() 
                            progress=True
                        else :
                            assert False, "Bugger! All possible values for square (%i,%i) fail" \
                            % (row,col)
    
def difference(puzzle1, puzzle2):
    count = 0
    for x in range(9):
        for y in range(9):
            if int(puzzle1.grid[x][y].value) - int(puzzle2.grid[x][y].value) != 0:
                count += 1
    return count

puzzle1 = fromfile('easy.txt')
draw(puzzle1)
puzzle2 = AC3(copy.deepcopy(puzzle1))
draw(puzzle2)
print difference(puzzle1, puzzle2)







    
#def blank():
#    puzzle = Puzzle()
#    puzzle.grid = [['' for x in range(9)] for y in range(9)]
#    for i in range(9):
#        for j in range(9):
#            value = int((i*3 + i/3 + j) % (3**2) + 1)
#            puzzle.grid[i][j] = Square(value, i, j)
#    return puzzle
  
#def preliminary(puzzle): 
#    for space in puzzle.spaces:
#        current = puzzle.grid[space[0]][space[1]]
#        if current.value != '0':
#            current.domain = [current.value]
#        else:
#            for i in row_get_values(puzzle, current):
#                if i in current.domain:
#                    current.domain.remove(i)
#            for j in col_get_values(puzzle, current):
#                if j in current.domain:
#                    current.domain.remove(j)
#            for k in sec_get_values(puzzle, current):
#                if k in current.domain:
#                    current.domain.remove(k)       
#        if len(current.domain) == 1:
#            current.value = current.domain[0]
#            puzzle.completed.append(current)  
#    return puzzle
 
#def secondary(puzzle):
#    while len(puzzle.completed) > 0:
#        current = puzzle.completed.pop()
#        for x in range(9): 
#            if current.value in puzzle.grid[x][current.y].domain: 
#                puzzle.grid[x][current.y].domain.remove(current.value)
#                if len(puzzle.grid[x][current.y].domain) == 1:
#                    puzzle.grid[x][current.y].value = puzzle.grid[x][current.y].domain[0]
#        for y in range(9):
#            if current.value in puzzle.grid[current.x][y].domain:
#                puzzle.grid[current.x][y].domain.remove(current.value)
#                if len(puzzle.grid[current.x][y].domain) == 1:
#                    puzzle.grid[current.x][y].value = puzzle.grid[current.x][y].domain[0]
#        start = sectorcheck(checksector(current.x, current.y))
#        for i in range(start[0], start[0]+3):
#            for j in range(start[1], start[1]+3):
#                if current.value in puzzle.grid[i][j].domain:
#                    puzzle.grid[i][j].domain.remove(current.value)
#                    if len(puzzle.grid[i][j].domain) == 1:
#                        puzzle.grid[i][j].value = puzzle.grid[i][j].domain[0]
#    return puzzle  

#In any unit (row, column, or box), find three squares that each have a domain that contains the same 3
#numbers or a subset of those numbers. Remove all numbers within that domain from the unit. 