/*
	scr_jumpToLine(discoID, lineStr);
	
	Last Updated: 2019-12-27
	
	Called from: obj_control
	
	Purpose: Send the user to a specific line in the discourse
	
	Mechanism: find the specified line within the currentActiveLineGrid and set the 
		scrollPlusYDest to that line's Y value
	
	Author: ?
*/
function scr_jumpToLine(discoID, lineStr) {
	// Get the current Discourse and specified line string
	discoID = obj_panelPane.selectedDiscoID;

	// Safety checks
	if (lineStr == "") {
		exit;
	}

	if (string_length(string_digits(lineStr)) < string_length(lineStr)
	or string_length(lineStr) < 1) {
		show_message(scr_get_translation("msg_numbers_only"));
		exit;
	}

	// Convert the input string to a real number
	var lineNum = real(lineStr);

	// Clamp the specified line between the currentActiveLineGrid's first and last line number
	var lineNumMin = ds_grid_get_min(obj_control.currentActiveLineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.currentActiveLineGrid));
	var lineNumMax = ds_grid_get_max(obj_control.currentActiveLineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.currentActiveLineGrid));

	lineNum = clamp(lineNum, lineNumMin, lineNumMax);

	// Ensure the clamp worked
	var currentLineCheck = lineNum;
	while (!ds_grid_value_exists(obj_control.currentActiveLineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.currentActiveLineGrid), currentLineCheck)
	and currentLineCheck >= lineNumMin) {
	
		currentLineCheck--;	
	}
	lineNum = currentLineCheck;

	// Specify the type of search based on the discoID
	var rowInLineGrid = -1;
	if (discoID == "") {
		rowInLineGrid = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.currentActiveLineGrid), lineNum);
	}
	else {
		rowInLineGrid = scr_findInGridTwoParameters(obj_control.currentActiveLineGrid, obj_control.lineGrid_colDiscoID, discoID, obj_control.lineGrid_colLineNumberLabel, lineNum);
	}
	
	if (rowInLineGrid >= 0) {
		show_debug_message("scr_jumpToLine() ... rowInLineGrid: " + string(rowInLineGrid));
		
		var linePixelY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
		var adjustedLinePixelY = -linePixelY + (obj_control.gridSpaceVertical / 2);
		
		show_debug_message("scr_jumpToLine() ... linePixelY: " + string(linePixelY));
		show_debug_message("scr_jumpToLine() ... adjustedLinePixelY: " + string(adjustedLinePixelY));
		
		obj_control.scrollPlusYDest = adjustedLinePixelY;
	}
	else {
		show_debug_message("scr_jumpToLine() ... rowInLineGrid < 0");
		exit;
	}
	

}
