/**
 * Sudoku generator.
 *
 * @author Jan Břečka
 */

this.sudoku = this.sudoku || {};

(function()
{
	var Generator = function() { };
	var p = Generator.prototype = new sudoku.Solver();

	p.generateReference = function()
	{
		var grid = [];

		for (var i = 0; i < 81; i++) {
			grid[i] = 0;
		}

		this.solveWithBacktracking(grid);

		return grid;
	};

	/**
	 * @param Array grid
	 * @param uint count Number of cells that will be randomly replaced by 0. 
	 */
	p.generateGame = function(grid, count)
	{
		if (count <= 0) {
			return grid;
		}

		var gridLength = grid.length;

		count = count > gridLength ? gridLength : count;

		var indices = [];
		var i;

		for (i = 0; i < gridLength; i++) {
			indices[i] = i;
		}

		for (i = 0; i < count; i++) {
			grid[this.removeRandomItem(indices)] = 0;
		}

		return grid;
	};

	p.parent_getValues = p.getValues;
	p.getValues = function()
	{
		var values = this.parent_getValues();
		var result = [];

		for (var i = 0; i < 9; i++) {
			result[i] = this.removeRandomItem(values);
		}

		return result;
	};

	/**
	 * @private
	 */
	p.removeRandomItem = function(array)
	{
		return array.splice(Math.floor(Math.random() * array.length), 1)[0];	
	};

	sudoku.Generator = Generator;
}());
