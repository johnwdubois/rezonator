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
