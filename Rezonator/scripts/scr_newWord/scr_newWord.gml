var unitID = argument0;
var wordSeq = argument1;

if (unitID == -1 or wordSeq == -1 or gridView or currentActiveLineGrid == searchGrid)
{
	exit;
}

var wordTranscript = get_string("Type in new word", "example");
var wordToken = wordTranscript;

ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;

var wordID = ds_grid_height(wordGrid);

ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, wordID);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, unitID);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, wordSeq + 1);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, wordToken);
ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, wordTranscript);

scr_loadDynamicWordGridIndividual();


var wordIDListUnitGrid = ds_grid_get(unitGrid, unitGrid_colWordIDList, unitID - 1);

if (ds_grid_value_exists(lineGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(lineGrid), unitID))
{
	var rowInLineGrid = ds_grid_value_y(lineGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(lineGrid), unitID);
}
else
{
	exit;
}

var wordIDListLineGrid = ds_grid_get(lineGrid, lineGrid_colWordIDList, rowInLineGrid);


ds_list_insert(wordIDListLineGrid, wordSeq + 1, wordID);
for (var i = wordSeq; i < ds_list_size(wordIDListLineGrid); i++)
{
	var currentWordID = ds_list_find_value(wordIDListLineGrid, i);
	var currentDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordID - 1);
	var currentWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol + 1);
	ds_grid_set(wordGrid, wordGrid_colWordSeq, currentWordID - 1, currentWordSeq + 1);
}