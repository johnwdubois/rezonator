/// @description Create endNoteTagList
// You can write your code in this editor
var tokenImportColNameListSize = ds_list_size(global.tokenImportColNameList);
for (var tokenColLoop = 0; tokenColLoop < tokenImportColNameListSize; tokenColLoop++) {

	if (ds_list_find_value(global.tokenImportColNameList, tokenColLoop) == "endNote") {
		endCol = tokenColLoop;
		show_debug_message("obj_stacker Alarm 5 ... endCol: " + string(endCol));
		break;
	}

}

var tokenImportGridHeight = ds_grid_height(global.tokenImportGrid);
for(var endNoteLoop = 0; endNoteLoop < tokenImportGridHeight; endNoteLoop++) {
	var possibleEndNoteTag = ds_grid_get(global.tokenImportGrid, endCol, endNoteLoop);
	if(possibleEndNoteTag != "") {
		if (ds_grid_height(endNoteTagsGrid) > 0) {
			for (var possibleEndTagsLoop = 0; possibleEndTagsLoop < ds_grid_height(endNoteTagsGrid); possibleEndTagsLoop++) {
				if (possibleEndNoteTag == ds_grid_get(endNoteTagsGrid, endNoteTagsGrid_colTag, possibleEndTagsLoop)) {
					break;
				}
				if (possibleEndTagsLoop == ds_grid_height(endNoteTagsGrid) - 1) {
					// add tag to endNoteTagsGrid
					ds_grid_resize(endNoteTagsGrid, ds_grid_width(endNoteTagsGrid), ds_grid_height(endNoteTagsGrid) + 1);
					ds_grid_set(endNoteTagsGrid, endNoteTagsGrid_colTag, ds_grid_height(endNoteTagsGrid) - 1, possibleEndNoteTag);
					ds_grid_set(endNoteTagsGrid, endNoteTagsGrid_colChecked, ds_grid_height(endNoteTagsGrid) - 1, false);
				}
			}
		}
		else {
			// add tag to endNoteTagsGrid
			ds_grid_resize(endNoteTagsGrid, ds_grid_width(endNoteTagsGrid), ds_grid_height(endNoteTagsGrid) + 1);
			ds_grid_set(endNoteTagsGrid, endNoteTagsGrid_colTag, ds_grid_height(endNoteTagsGrid) - 1, possibleEndNoteTag);
			ds_grid_set(endNoteTagsGrid, endNoteTagsGrid_colChecked, ds_grid_height(endNoteTagsGrid) - 1, false);
		}
	}
}

show_debug_message("obj_stacker Alarm[7] ... tokenImportColNameList: " + scr_getStringOfList(global.tokenImportColNameList));
show_debug_message("obj_stacker Alarm[7] ... tokenImportGridHeight: " + string(tokenImportGridHeight));
show_debug_message("obj_stacker Alarm[7] ... endNoteTagsGridHeight: " + string(ds_grid_height(endNoteTagsGrid)));