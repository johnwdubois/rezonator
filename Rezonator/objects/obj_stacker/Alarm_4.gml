/// @description Create Turn Stacks

// So I gotta loop through the tokenImport grid, checking for units to collect into the list, and checking for new turns to swap lists
// It works!! But that stack bug is getting in the way...

if(obj_toolPane.currentMode == obj_toolPane.modeRead) {
	obj_toolPane.currentMode = obj_toolPane.modeTrack;	
}

obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabStackBrush;
			
// unfocus chains of all type
scr_unFocusAllChains();
			
//refocus chains related to currently selected tab
with(obj_panelPane) {
	scr_reFocusOldChains();
}

var currentUnitList = ds_list_create();
ds_list_clear(currentUnitList);
var tokenImportGridHeight = ds_grid_height(global.tokenImportGrid);
var unitCol = -1;
var turnCol = -1;


for (var unitColLoop = 0; unitColLoop < ds_list_size(global.tokenImportColNameList); unitColLoop++) {

	if (ds_list_find_value(global.tokenImportColNameList, unitColLoop) == "~UnitID") {
		unitCol = unitColLoop;
		//show_message(unitCol);
	}

}

for (var importColLoop = 0; importColLoop < ds_list_size(global.importGridColNameList); importColLoop++) {

	if (string(ds_list_find_value(global.importGridColNameList, importColLoop)) == "turnId") {
		

		turnCol = importColLoop;
		//show_message(turnCol);
	}
}

if (turnCol == -1) {
	show_message("No turn order found");
	splitSave = false;

	exit;	
}

//var turnOrderCol = //how do i get??
var currentTurnOrder = ds_grid_get(global.importGrid, turnCol, 0);
var previousTurnOrder = ds_grid_get(global.importGrid, turnCol, 0);

for (var tokenImportLoop = 0; tokenImportLoop < tokenImportGridHeight; tokenImportLoop++){
	currentTurnOrder = ds_grid_get(global.importGrid, turnCol, tokenImportLoop);
	if(tokenImportLoop >= 1){
	previousTurnOrder = ds_grid_get(global.importGrid, turnCol, tokenImportLoop);
	}
	while( (currentTurnOrder == previousTurnOrder) and (tokenImportLoop < tokenImportGridHeight)) { 	
		var randUnit = ds_grid_get(global.tokenImportGrid, unitCol, tokenImportLoop);
		ds_list_add(currentUnitList, randUnit);
		tokenImportLoop++
		currentTurnOrder = ds_grid_get(global.importGrid, turnCol, tokenImportLoop);
		//show_message(currentTurnOrder);
	}
	
	if(ds_list_size(currentUnitList) > 0) {
		//show_message(scr_getStringOfList(currentUnitList));
		var firstUnitID = ds_list_find_value(currentUnitList, 0);
		var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, firstUnitID - 1);
		var firstWordID = ds_list_find_value(currentWordIDList, 0);
		var prevUnitID = -1;
	
		// Loop through words found in rectangle at time of mouse release
		var inRectUnitIDListSize = ds_list_size(currentUnitList);
		for (var quickStackLoop = 0; quickStackLoop < inRectUnitIDListSize; quickStackLoop++) {
			var currentUnitID = ds_list_find_value(currentUnitList, quickStackLoop);
				if(currentUnitID != prevUnitID) {
				currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
				var currentWordID = ds_list_find_value(currentWordIDList, 0);
				obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
				with (obj_chain) {
					scr_wordClicked(firstWordID, firstUnitID);
					scr_wordClicked(currentWordID, currentUnitID);
				}
			}
			prevUnitID = currentUnitID;
		}
		// Unfocus all links and chains
		scr_unFocusAllChains();
		ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);

	}
	
	if(tokenImportLoop >= tokenImportGridHeight) {
	//	show_message(scr_getStringOfList(currentUnitList));	
	}
	ds_list_clear(currentUnitList);
	// switch randLines to next set of units

	//global.fileSaveName = global.fileSaveName + string(fileNameNumber++);
}
splitSave = false;

