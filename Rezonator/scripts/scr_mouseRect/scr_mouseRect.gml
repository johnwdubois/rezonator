/*	
	Purpose: draw a rectangle for creating quickLinks/quickStacks
*/
function scr_mouseRect() {
	if(instance_exists(obj_dialogueBox))exit;
	// is user releases mouse, do something!
	if (mouse_check_button_released(mb_left)) {
		
		// quick stacks
		if (ds_list_size(inRectUnitIDList) > 1 && mouseoverSpeakerLabel) {
			scr_quickStackCreation();
		}
		else if (ds_list_size(inRectTokenIDList) > 0) {
			// create chunk
			if (ds_list_size(inRectUnitIDList) == 1) {
				inRectTokenIDList = scr_discourseSort(inRectTokenIDList);
				scr_createChunk();
			}
			// quicklinks
			else if (ds_list_size(inRectUnitIDList) > 1 && obj_toolPane.currentMode == obj_toolPane.modeRez && !mouseoverSpeakerLabel) {
				scr_quickLinkCreation();
			}
		}
		
		
		// reset mouserect variables
		mouseHoldRectX1 = -1;
		mouseHoldRectY1 = -1;
	}
	
	// if user clicks, save the position of their mouse
	var canMakeMouseRect = !mouseoverPanelPane && mouseoverNeutralSpace && mouse_check_button_pressed(mb_left) && !mouseoverScrollBar;
	if (canMakeMouseRect) {
		mouseHoldRectX1 = mouse_x;
		mouseHoldRectY1 = mouse_y;
	}
	
	// if user is making a mouse rect, let's draw it
	if (mouseHoldRectX1 >= 0 && mouseHoldRectY1 >= 0) {
		
		// if the mouseRect contains multiple units, let's fill it in
		if (ds_list_size(inRectUnitIDList) > 1) {
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(0.3);
			draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouse_x, mouse_y, false);
		}
		
		// draw mouse rect border
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(0.7);
		scr_drawRectWidth(mouseHoldRectX1, mouseHoldRectY1, mouse_x, mouse_y, 2, false);
		draw_set_alpha(1);
	}
	
}
