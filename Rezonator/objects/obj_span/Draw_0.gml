/*
	obj_span: Draw
	
	Last Updated: 2019-02-11
	
	Called from: Every frame of the game
	
	Purpose: Draw the attributes of spans
	
	Mechanism: Collect information from the span grids then draw them to the screen
	
	Author: Terry DuBois
*/

for (var i = 0; i < ds_grid_height(spanGrid); i++)
{
	var currentFirstWordID = ds_grid_get(spanGrid, spanGrid_colFirstWordID, i);
	var currentLastWordID = ds_grid_get(spanGrid, spanGrid_colLastWordID, i);
	
	if (not ds_grid_value_exists(obj_control.wordGrid, obj_control.wordGrid_colWordID, 0, obj_control.wordGrid_colWordID, ds_grid_height(obj_control.wordGrid), currentFirstWordID)
	or not ds_grid_value_exists(obj_control.wordGrid, obj_control.wordGrid_colWordID, 0, obj_control.wordGrid_colWordID, ds_grid_height(obj_control.wordGrid), currentLastWordID))
	{
		continue;
	}
	
	var rowInWordGridCurrentFirstWord = ds_grid_value_y(obj_control.wordGrid, obj_control.wordGrid_colWordID, 0, obj_control.wordGrid_colWordID, ds_grid_height(obj_control.wordGrid), currentFirstWordID);
	var rowInWordGridCurrentLastWord = ds_grid_value_y(obj_control.wordGrid, obj_control.wordGrid_colWordID, 0, obj_control.wordGrid_colWordID, ds_grid_height(obj_control.wordGrid), currentLastWordID);
	var rowInLineGrid = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colLineID, rowInWordGridCurrentFirstWord);
	
	draw_text(30, 20 + i * 30, "rowInWordGridCurrentFirstWord = " + string(rowInWordGridCurrentFirstWord) + ", rowInWordGridCurrentLastWord = " + string(rowInWordGridCurrentLastWord) + ", rowInLineGrid = " + string(rowInLineGrid));
	
	var x1 = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colX, rowInWordGridCurrentFirstWord);
	var y1 = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colY, rowInLineGrid) - 10;
	
	var x2 = x1 + 30;
	//var x2 = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colX, rowInWordGridCurrentLastWord) + string_width(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordStringDisplay, rowInWordGridCurrentLastWord));
	var y2 = y1 + 20;
	
	draw_set_color(c_black);
	draw_set_alpha(1);
	draw_rectangle(x1, x2, y1, y2, true);
}

draw_text(80, 80, "height: " + string(ds_grid_height(spanGrid)));

for (var k = 0; k < ds_grid_width(spanGrid); k++)
{
	for (var j = 0; j < ds_grid_height(spanGrid); j++)
	{
		var str = string(ds_grid_get(spanGrid, k, j));
		
		draw_text(100 + (k * 60), 100 + (j * 20), str);
	}
}