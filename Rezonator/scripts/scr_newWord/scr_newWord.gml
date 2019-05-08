var unitID = argument0;
var wordSeq = argument1;


if (unitID == -1 or wordSeq == -1 or gridView or currentActiveLineGrid == searchGrid) {
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

scr_loadDynamicWordGridIndividual(ds_grid_height(obj_control.wordGrid) - 1);


var wordIDListUnitGrid = ds_grid_get(unitGrid, unitGrid_colWordIDList, unitID - 1);


var rowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), unitID);
if (rowInLineGrid < 0 or rowInLineGrid >= ds_grid_height(obj_control.lineGrid)) {
	exit;
}

var wordIDListLineGrid = ds_grid_get(lineGrid, lineGrid_colWordIDList, rowInLineGrid);



ds_list_insert(wordIDListLineGrid, wordSeq + 1, wordID);
for (var i = wordSeq + 2; i < ds_list_size(wordIDListLineGrid); i++) {
	var currentWordID = ds_list_find_value(wordIDListLineGrid, i);
	var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
	var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
	
	ds_grid_set(wordGrid, wordGrid_colWordSeq, currentWordID - 1, currentWordSeq + 1);	
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol + 1);
}