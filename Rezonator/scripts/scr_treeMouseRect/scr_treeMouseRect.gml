/*	
	Purpose: draw a rectangle for combining leafs
*/
function scr_treeMouseRect(rectIDList) {
	show_debug_message(string(ds_list_size(rectIDList)) + "   FIRST");
	if(instance_exists(obj_dialogueBox))exit;
	// is user releases mouse, do something!
	if (mouse_check_button_released(mb_left)) {
		show_debug_message(string(ds_list_size(rectIDList))+ "   ON REALEASE");
		if (ds_list_size(rectIDList) > 1) {
			scr_combineLeafs(rectIDList);
			scr_createTreeLink(rectIDList[|0]);
		}

		// reset mouserect variables
		obj_control.mouseHoldRectX1 = -1;
		obj_control.mouseHoldRectY1 = -1;
	}
	
	// if user clicks, save the position of their mouse
	var canMakeMouseRect = obj_control.mouseoverPanelPane &&  mouse_check_button_pressed(mb_left) && !obj_control.mouseoverScrollBar;
	if (canMakeMouseRect) {
		obj_control.mouseHoldRectX1 = mouse_x;
		obj_control.mouseHoldRectY1 = mouse_y;
	}
	
	// if user is making a mouse rect, let's draw it
	if (obj_control.mouseHoldRectX1 >= 0 && obj_control.mouseHoldRectY1 >= 0) {
		
		// draw mouse rect border
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(0.7);
		scr_drawRectWidth(obj_control.mouseHoldRectX1, obj_control.mouseHoldRectY1, mouse_x, mouse_y, 2, false);
		draw_set_alpha(1);
	}
	
}
