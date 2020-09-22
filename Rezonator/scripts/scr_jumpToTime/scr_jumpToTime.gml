function scr_jumpToTime(argument0) {
	/*
		scr_jumpToTime(timeStr);
	
		Last Updated: 2019-12-27
	
		Called from: obj_dialogueBox
	
		Purpose: Find and go to the line with the UnitStartTime closest to the user specified time
	
		Mechanism: Iterate through the Line grid column lineGrid_colUnitStart until landing on a relative match with the
			specified time, then jump to that line using the JumpToLine mechanism
	
		Author: ?
	*/

	var timeStr = argument0;
	discoID = obj_panelPane.selectedDiscoID;

	var foundRow = 0;

	if (timeStr == "") {
		exit;
	}

	if (string_length(timeStr) < 1) {
		show_message("Input a number please.");
		exit;
	}
	if(discoID != ""){
		var startOfDisco = ds_grid_value_y(obj_control.lineGrid , obj_control.lineGrid_colDiscoID , 0 , obj_control.lineGrid_colDiscoID, ds_grid_height(obj_control.lineGrid), discoID );
	}
	else{
		var startOfDisco = 0;
	}
	var lineGridHeight = ds_grid_height(obj_control.lineGrid);
	for(var i = startOfDisco ; i< lineGridHeight; i++){
		var currentTime = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, i);
	
		if(real(string_digits(currentTime)) >= real(string_digits(timeStr))){
			//Is this search necessary? - Geo
			foundRow = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, 0, obj_control.lineGrid_colUnitStart, ds_grid_height(obj_control.lineGrid) , currentTime);
			i = ds_grid_height(obj_control.lineGrid);
		}
	}

		//show_message(foundRow);
		//show_message(ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, foundRow));

	var lineNum = real(ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, foundRow));

	var lineNumMin = ds_grid_get_min(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid));
	var lineNumMax = ds_grid_get_max(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid));

	lineNum = clamp(lineNum, lineNumMin, lineNumMax);

	var rowInLineGrid = -1;
	if (discoID == "") {
		rowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid), lineNum);
	}
	else {
		rowInLineGrid = scr_findInGridTwoParameters(obj_control.lineGrid, obj_control.lineGrid_colDiscoID, discoID, obj_control.lineGrid_colLineNumberLabel, lineNum);
	}
	
	if (rowInLineGrid >= 0) {
		var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
		obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(camera_get_active()) / 2) - 100;
	}
	else {
		exit;
	}


}
