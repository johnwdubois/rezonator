/*
	obj_span: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of openingScreen objects
	
	Purpose: Instantiate all variables used by openingScreen objects
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

spanGrid_width = 5;
spanGrid_colWordID = 0;
spanGrid_colspanID = 1;
spanGrid_colFirstWordID = 2;
spanGrid_colLastWordID = 3;
spanGrid_colLineID = 4;

spanGrid = ds_grid_create(spanGrid_width, 0);

/*
spanGrid_colWordIDList
spanGrid_colLineIDList