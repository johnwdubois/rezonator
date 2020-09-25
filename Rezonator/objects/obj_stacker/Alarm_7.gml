/// @description Create endNoteTagList
// You can write your code in this editor
var tokenImportColNameListSize = ds_list_size(global.tokenImportColNameList);
var endCol = -1;
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
		if(ds_list_size(endNoteTagsList) > 0) {
			for(var possibleEndTagsLoop = 0; possibleEndTagsLoop < ds_list_size(endNoteTagsList); possibleEndTagsLoop++) {
				if(possibleEndNoteTag == ds_list_find_value(endNoteTagsList, possibleEndTagsLoop)) {
					break;
				}
				if (possibleEndTagsLoop == ds_list_size(endNoteTagsList) - 1) {
					ds_list_add(endNoteTagsList, possibleEndNoteTag);
				}
			}
		}
		else {
			ds_list_add(endNoteTagsList, possibleEndNoteTag);
		}
	}
}

show_debug_message("obj_stacker Alarm[7] ... tokenImportColNameList: " + scr_getStringOfList(global.tokenImportColNameList));
show_debug_message("obj_stacker Alarm[7] ... tokenImportGridHeight: " + string(tokenImportGridHeight));
show_debug_message("obj_stacker Alarm[7] ... endNoteTagsList: " + scr_getStringOfList(endNoteTagsList));