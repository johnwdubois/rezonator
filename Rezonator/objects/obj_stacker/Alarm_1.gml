/// @description Insert description here
// You can write your code in this editor
var endLine = ds_grid_height(obj_control.lineGrid) - 1;
var randUnit = -1;
	quickStackAbleToInitiate = true;
	quickStackAbleToSwitch = true;

for (var stackLoop = 0; stackLoop < 4; stackLoop++) {
//while (randLine2 <= endLine && randLine1 < endLine){ 
	for(var randUnitLoop = randLine1; randUnitLoop < randLine2; randUnitLoop++){
		randUnit = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, randUnitLoop-1);
		ds_list_add(obj_control.inRectUnitIDList, randUnit);
	}
	
	obj_control.alarm[7] = 1;


	randLine1 = randLine2 + 1;
	randLine2 = randLine1 + floor(random(25)) + 1;
	//global.fileSaveName = global.fileSaveName + string(fileNameNumber++);
}
splitSave = false;
randLine1 = 1;
randLine2 = randLine1 + floor(random(7)) + 1;