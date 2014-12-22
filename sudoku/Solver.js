/**
 * Sudoku solver.
 *
 * @author Jan Břečka
 */

this.sudoku = this.sudoku || {};

(function()
{
	var Solver = function() { };
	var p = Solver.prototype;

	/**
	 * @param Array grid 9x9 1D array, 0 means empty cell
	 * @return Solved grid.
	 * @throw Error When grid can't be solved.
 	 */
	p.solve = function(grid)
	{
		if (!this.solveWithBacktracking(grid)) {
			throw new Error('Impossible to solve.');
		}

		return grid;
	};

	/**
	 * @private
	 */
	p.solveWithBacktracking = function(grid)
	{
		var index = this.findEmptyCell(grid);

		if (index == -1) {
			return true;
		}

		var values = this.getValues();
		var value;

		for (var i = 0; i < 9; i++) {
			value = values[i];

			if (this.isPossible(grid, index, value)) {
				grid[index] = value;

				if (this.solveWithBacktracking(grid)) {
					return true;
				}

				grid[index] = 0;
			}
		}

		return false;
	};

	/**
	 * @private
	 */
	p.findEmptyCell = function(grid)
	{
		var gridLength = grid.length;

		for (var i = 0; i < gridLength; i++) {
			if (grid[i] === 0) {
				return i;
			}
		}

		return -1;
	};

	/**
	 * @protected
	 */
	p.getValues = function() {
		return [1, 2, 3, 4, 5, 6, 7, 8, 9];
	};

	/**
	 * @private
	 */
	p.isPossible = function(grid, index, value)
	{
		var x = Math.floor(index % 9);
		var y = Math.floor(index / 9);
		var squareX = x - (x % 3);
		var squareY = y - (y % 3);

		for (var i = 0; i < 9; i++) {
			if (this.getAt(grid, i, y) == value ||
				this.getAt(grid, x, i) == value ||
				this.getAt(grid, squareX + Math.floor(i % 3), squareY + Math.floor(i / 3)) == value) {
				return false;
			}
		}

		return true;
	};

	/**
	 * @private
	 */
	p.getAt = function(grid, x, y)
	{
		return grid[y * 9 + x];
	};

	sudoku.Solver = Solver;
}());
