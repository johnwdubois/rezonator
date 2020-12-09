/// @description shuffle view 
// You can write your code in this editor

if (keyboard_check(vk_control) && shortcutsEnabled) {
	
	if(keyboard_check(vk_shift)){
		ds_grid_copy(obj_control.lineGrid, obj_control.lineGridBackup);
		scr_refreshLineGridPixelY();
		scr_refreshLineGridDisplayRow(obj_control.lineGrid);
	}
	else{
		scr_shuffleDisplayRows();
		scr_refreshLineGridDisplayRow(obj_control.lineGrid);
	}
	
}
