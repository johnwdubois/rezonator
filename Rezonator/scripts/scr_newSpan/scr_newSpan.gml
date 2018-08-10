var spanList = argument0;

var dbb = "";
for (var db = 0; db < ds_list_size(spanList); db++)
{
	dbb += string(ds_list_find_value(spanList, db)) + ",";
}
show_message(dbb);

var wordID = ds_grid_height(obj_control.wordGrid) + ds_grid_height(obj_span.spanGrid) + 1;
var spanID = ds_grid_height(obj_span.spanGrid) + 1;
var firstWordID = 999999999999;
var lastWordID = -1;
var lineID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colLineID, ds_list_find_value(spanList, 0));

for (var i = 0; i < ds_list_size(spanList); i++)
{
	var currentWordGridRow = ds_list_find_value(spanList, i);
	
	show_message(string(currentWordGridRow));
	
	
	
	var currentWordID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentWordGridRow);
	var currentLineID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colLineID, currentWordGridRow);
	
	if (not currentLineID == lineID)
	{
		exit;
	}
	
	show_message("currentWordID = " +  string(currentWordID));
	
	if (currentWordID < firstWordID)
	{
		firstWordID = currentWordID;
	}
	else if (currentWordID > lastWordID)
	{
		lastWordID = currentWordID;
	}
	
}

ds_grid_resize(obj_span.spanGrid, obj_span.spanGrid_width, ds_grid_height(obj_span.spanGrid) + 1);

var currentSpanGridRow = ds_grid_height(obj_span.spanGrid) - 1;

ds_grid_set(obj_span.spanGrid, obj_span.spanGrid_colWordID, currentSpanGridRow, wordID);
ds_grid_set(obj_span.spanGrid, obj_span.spanGrid_colspanID, currentSpanGridRow, spanID);
ds_grid_set(obj_span.spanGrid, obj_span.spanGrid_colFirstWordID, currentSpanGridRow, firstWordID);
ds_grid_set(obj_span.spanGrid, obj_span.spanGrid_colLastWordID, currentSpanGridRow, lastWordID);
ds_grid_set(obj_span.spanGrid, obj_span.spanGrid_colLineID, currentSpanGridRow, lineID);