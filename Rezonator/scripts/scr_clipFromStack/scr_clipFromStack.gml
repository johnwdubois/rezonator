// Save a Rez file containing the collection of lines within the selected Stack
function scr_clipFromStack(selectedStackID) {

	// gather the beginning and the end of the Stack
	var unitIDList = scr_getChainTempList(selectedStackID);
	var firstUnitInStack = ds_list_find_value(unitIDList, 0);
	var lastUnitInStack = ds_list_find_value(unitIDList, ds_list_size(unitIDList) - 1);
	
	// Set the first and last lines of the file based on the start and end Units of the stack
	obj_fileLoader.subLineGridBeginning = string_digits(firstUnitInStack);//ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), firstUnitInStack));
	obj_fileLoader.subLineGridEnd = string_digits(lastUnitInStack);//ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), lastUnitInStack));

	global.stackGrabSave = true;

	// Start the Save As process
	var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
	instLoading.loadSprite = spr_saving;
	with(obj_fileLoader){
		alarm[0] = 2;
	}
}
