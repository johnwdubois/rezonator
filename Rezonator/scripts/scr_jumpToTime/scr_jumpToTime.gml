function scr_jumpToTime(timeStr) {
	/*
		scr_jumpToTime(timeStr);
	
		Last Updated: 2019-12-27
	
		Called from: obj_dialogueBox
	
		Purpose: Find and go to the line with the UnitStartTime closest to the user specified time
	
		Mechanism: Iterate through the Line grid column lineGrid_colUnitStart until landing on a relative match with the
			specified time, then jump to that line using the JumpToLine mechanism
	
		Author: ?
	*/

	discoID = obj_panelPane.selectedDiscoID;

	var foundRow = 0;

	if (timeStr == "") {
		exit;
	}
	
	
	var strLenDigits = string_length(string_digits(timeStr));
	var strLenTotal = string_length(timeStr);
	show_debug_message("scr_jumpToTime() ... strLenDigits: " + string(strLenDigits) + ", strLenTotal: " + string(strLenTotal));

	if (strLenDigits < strLenTotal) {
		show_message("Input a number please.");
		exit;
	}
	
	var timeStrReal = real(timeStr);
	
	
	if(discoID != ""){
		var startOfDisco = ds_grid_value_y(obj_control.lineGrid , obj_control.lineGrid_colDiscoID , 0 , obj_control.lineGrid_colDiscoID, ds_grid_height(obj_control.lineGrid), discoID );
	}
	else{
		var startOfDisco = 0;
	}
	
	var unitGridHeight = ds_grid_height(obj_control.unitGrid);
	for (var i = 0; i < unitGridHeight; i++){
		var currentTime = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, i);
		var currentTimeReal = real(currentTime);
		show_debug_message("scr_jumpToTime() ... currentTimeReal: " + string(currentTimeReal));
		
		if (currentTimeReal >= timeStrReal) {
			foundRow = i;
			i = unitGridHeight;
		}
	}

	show_debug_message("scr_jumpToTime() ... foundRow: " + string(foundRow));
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
