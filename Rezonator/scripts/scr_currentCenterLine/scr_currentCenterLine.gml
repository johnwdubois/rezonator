var navWindowHeight = (obj_panelPane.showNav) ? inst_PanelPane_chainContents.windowHeight : 0;	
var lineGridOffset = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0) - 1;
var negativeOffset = false;
var offsetCheck = lineGridOffset;
while(offsetCheck < 0) {
	offsetCheck = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, ++lineGridOffset) - 1;
	negativeOffset = true;
}
lineGridOffset = negativeOffset ? -lineGridOffset : lineGridOffset;
//show_message(string(lineGridOffset));

var lineRangeHeight = camera_get_view_height(view_camera[0]) - navWindowHeight;
var midLineYPos = (lineRangeHeight / 2) + navWindowHeight;

for(var centerLineLoop = obj_control.drawRangeStart; centerLineLoop < ds_grid_height(obj_control.currentActiveLineGrid); centerLineLoop++){
	var currentYPos = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, centerLineLoop);
	
	if(currentYPos >= midLineYPos){
		//show_message(string(i));
		if(obj_control.gridSpaceVertical > 40) {
			return centerLineLoop + 1 + lineGridOffset;
		}
		else {
			return centerLineLoop + 3 + lineGridOffset;
		}
	}
	else if(centerLineLoop + 1 == ds_grid_height(obj_control.currentActiveLineGrid) and currentYPos + obj_control.gridSpaceVertical >= midLineYPos) {
		return centerLineLoop + 1 + lineGridOffset;
	}
}
 
return -1;