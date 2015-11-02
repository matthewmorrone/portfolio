/**
 * Sudoku validator.
 *
 * @author Jan Břečka
 */

this.sudoku = this.sudoku || {};

(function()
{
	var Validator = function() { };
	var p = Validator.prototype;

	/**
	 * @param Array grid 9x9 grid.
	 * @throw Error When grid isn't valid.
 	 */
	p.validate = function(grid)
	{
		var gridLength = grid.length;

		if (gridLength != 81) {
			throw new Error('Invalid grid.');
		}

		for (var i = 0; i < gridLength; i++) {
			this.validateCell(grid, i);
		}
	};

	/**
	 * @private
	 */
	p.validateCell = function(grid, index)
	{
		var x = Math.floor(index % 9);
		var y = Math.floor(index / 9);
		var squareX = x - (x % 3);
		var squareY = y - (y % 3);
		var countsInVertical = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var countsInHorizontal = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var countsInSquare = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var i;

		for (i = 0; i < 9; i++) {
			countsInVertical[this.getAt(grid, i, y)]++;
			countsInHorizontal[this.getAt(grid, x, i)]++;
			countsInSquare[this.getAt(grid, squareX + Math.floor(i % 3), squareY + Math.floor(i / 3))]++;
		}

		for (i = 1; i < 11; i++) {
			if (countsInVertical[i] > 1 || countsInHorizontal[i] > 1 || countsInSquare[i] > 1) {
				throw new Error('Invalid grid.');
			}
		}
	};

	/**
	 * @private
	 */
	p.getAt = function(grid, x, y)
	{
		return grid[y * 9 + x];
	};

	sudoku.Validator = Validator;
}());
