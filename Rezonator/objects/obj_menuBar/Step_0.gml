/// @description Insert description here
// You can write your code in this editor
if(point_in_rectangle(mouse_x, mouse_y, 0, 0, camera_get_view_width(camera_get_active()), menuHeight)){
	with (obj_control) mouseoverPanelPane = true;
	if(!chainDeselected){
		with(obj_chain) {
			scr_chainDeselect();
			chainDeselected = true;
		}
	}
	else{
		chainDeselected = false;
	}
	
}

if(!menuClickedIn){
		ds_grid_set_region(menuBarGrid, menuBarGrid_colMouseOver, 0, menuBarGrid_colMouseOver, menuBarGridHeight, false);
}