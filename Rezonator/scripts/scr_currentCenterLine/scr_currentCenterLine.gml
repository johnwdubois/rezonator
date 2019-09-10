var navWindowHeight = (obj_panelPane.showNav) ? inst_PanelPane_chainContents.windowHeight : 0;	

var lineRangeHeight = camera_get_view_height(view_camera[0]) - navWindowHeight;
var midLineYPos = (lineRangeHeight / 2) + navWindowHeight;

for(var centerLineLoop = obj_control.drawRangeStart; centerLineLoop < ds_grid_height(obj_control.currentActiveLineGrid); centerLineLoop++){
	var currentYPos = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, centerLineLoop);
	
	if(currentYPos >= midLineYPos){
		//show_message(string(i));
		return centerLineLoop + 1;
	}
}
 
return -1;