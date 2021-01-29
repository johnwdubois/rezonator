/*
	obj_toolPane: Draw
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Draw the tool pane and all of its contents
	
	Mechanism: Draw all text, icons, and boxes in the tool pane, and check for user mouseover
	
	Author: Terry DuBois
*/

windowWidth = global.toolPaneWidth;
x = camera_get_view_width(camera_get_active()) - global.toolPaneWidth;
y = 0;

if (obj_control.gridView) {
windowHeight = 100;
//	exit;
}
if (obj_control.hideAll) {
	exit;
}

// Set the original height as the file loads
if(current_time - obj_control.sessionStartTime < 2000) {
	//originalWindowHeight = y;
}
// Allow hiding the Nav Window via setting each window's height to 2000
else{
	if(showTool) {
		y = originalWindowHeight;	
	} 
}

if (device_mouse_check_button_released(0, mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	if (not obj_control.gridView) {
		with (obj_chain) {
			scr_chainDeselect();
		}
	}
}


if (obj_panelPane.showNav && obj_toolPane.showTool) {
	draw_set_alpha(1);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
}


scr_drawToolPaneNew();



progressBarX = camera_get_view_width(camera_get_active()) - 100;
