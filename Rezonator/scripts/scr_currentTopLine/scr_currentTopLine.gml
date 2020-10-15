function scr_currentTopLine() {
	/*
		scr_currentTopLine();
	
		Last Updated: 2019-12-27
	
		Called from: obj_control
	
		Purpose: Return the Line in the Discourse estimated to be in the Top of the screen
	
		Mechanism: Get the midline of the current screen, then loop through the Lines within 
		the drawRange to find the Line with the closest Y position to the midline
	
		Author: Terry DuBois, Georgio Klironomos
	*/
	
	var focusLineYPos = obj_control.wordTopMargin;// - (obj_control.gridSpaceVertical / 2);
	var lineloopOffset = (obj_control.currentActiveLineGrid == obj_control.lineGrid) ? 1 : 2;
	
	var currentActiveLineGridHeight = ds_grid_height(obj_control.currentActiveLineGrid);
	for(var centerLineLoop = obj_control.drawRangeStart; centerLineLoop < currentActiveLineGridHeight; centerLineLoop++){
		var currentYPos = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, centerLineLoop);
	
		if(currentYPos >= focusLineYPos){
			//show_message(string(i));
			if(obj_control.gridSpaceVertical > 40) {
				return centerLineLoop + lineloopOffset;// + 1;// + lineGridOffset;
			}
			else {
				return centerLineLoop + lineloopOffset;// + 3;// + lineGridOffset;
			}
		}
		else if(centerLineLoop + 1 == ds_grid_height(obj_control.currentActiveLineGrid) and currentYPos + obj_control.gridSpaceVertical >= focusLineYPos) {
			return centerLineLoop + lineloopOffset;// + 1;// + lineGridOffset;
		}
	}
 
	return -1;


}
