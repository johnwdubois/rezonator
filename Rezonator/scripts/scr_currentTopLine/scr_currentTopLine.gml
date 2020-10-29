/*
	scr_currentTopLine();
	
	Last Updated: 2020-10-26
	
	Called from: obj_control
	
	Purpose: Return the Line in the Discourse estimated to be in the Top of the screen
	
	Mechanism: Get the position of the top of the discourse against the Nav Window, then loop through the Lines within 
	the drawRange to find the Line with the closest Y position
	
	Author: Terry DuBois, Georgio Klironomos
*/
function scr_currentTopLine() {
	
	// Get the destination position
	var focusLineYPos = obj_control.wordTopMargin;
	var lineloopOffset = (obj_control.currentActiveLineGrid == obj_control.lineGrid) ? 1 : 2;
	
	// Loop through the currently active Line Grid to gather line measurements
	var currentActiveLineGridHeight = ds_grid_height(obj_control.currentActiveLineGrid);
	for(var centerLineLoop = obj_control.drawRangeStart; centerLineLoop < currentActiveLineGridHeight; centerLineLoop++){
		var currentYPos = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, centerLineLoop);
	
		if(currentYPos >= focusLineYPos){
			return centerLineLoop + lineloopOffset;
		}
		else if(centerLineLoop + 1 == ds_grid_height(obj_control.currentActiveLineGrid) and currentYPos + obj_control.gridSpaceVertical >= focusLineYPos) {
			return centerLineLoop + lineloopOffset;
		}
	}
	return -1;
}
