/// @description shuffle view 
// You can write your code in this editor

if (global.ctrlHold && shortcutsEnabled) {
	
	if(keyboard_check(vk_shift)){
		ds_grid_copy(obj_control.lineGrid, obj_control.lineGridBackup);
	}
	else{
		scr_shuffleDisplayRows();
	}
	
}
