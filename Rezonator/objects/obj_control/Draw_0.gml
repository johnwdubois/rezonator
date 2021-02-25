     /*
	obj_control: Draw
	
	Last Updated: 2019-02-11
	
	Called from: Every frame of the game
	
	Purpose: Call the camera adjuster, show the display columns and the developer variables
	
	Mechanism: DevVars: checks for necessity, then draws developer variables wherever the camera is
	
	Author: Terry DuBois
*/

window_set_cursor(cr_default);

// color theme control
scr_colorThemeControl();

// adjust view to window size
scr_windowCameraAdjust();

if (gridView) {
	exit;
}

if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(camera_get_active()) - 20, 200, camera_get_view_width(camera_get_active()), max(200, camera_get_view_height(camera_get_active())))) {
	mouseoverPanelPane = true;
}

// Turns on a grid of lines
if (showDisplayCols) {
	draw_set_alpha(0.25);
	draw_set_color(c_black);
	
	for (var i = 0; i < 20; i++) {
		var displayColX = wordLeftMargin + (i * gridSpaceHorizontal);
		draw_line(displayColX, 0, displayColX, room_height);
		draw_text(displayColX, 160, string(i));
	}
}

obj_control.mouseoverSpeakerLabel = false;
if(global.canScroll) {
	if(!stackShowWindowActive){
		obj_control.mouseoverNeutralSpace = true;
	}
}
if (!hideAll) {
	scr_drawLine();
}
//scr_drawChunk();
//scr_drawDialogueBox();
//scr_stackShowWindow();

//mouseRectWithinLine = false;
// Draw the mouse drag rectangle
if (not mouseoverPanelPane and not obj_panelPane.scrollBarClickLock and obj_toolPane.currentTool != obj_toolPane.toolNewWord and not mouseoverNeutralSpace and obj_toolPane.currentMode != obj_toolPane.modeRead) {
	if(not mouseRectMade) {
		if (current_time - sessionStartTime > 2000 and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {// Curfew for the volunteers
			if(obj_toolPane.currentTool != obj_toolPane.toolStackBrush or mouseoverSpeakerLabel) {
				scr_mouseRect();
			}
		}
		else if (current_time - sessionStartTime > 2000 and obj_toolPane.currentTool == obj_toolPane.toolBoxBrush) {
			scr_boxRect();
		}
	}

	// Create the quickStack with the mouse drag, if possible
	if (mouseRectMade and quickStackAbleToInitiate) {
		quickStackAbleToInitiate = false;
		alarm[7] = 5;
	}
	// SHould this be just an if??
	if (mouseRectMade and obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
		alarm[8] = 5;
	}
	/*else if (mouseRectMade and obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
		//show_message("made");
		alarm[10] = 5;
	}*/
	else if (mouseRectMade and obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
		alarm[8] = 5;
	}
	else if(mouseRectMade) {
		alarm[9] = 5;
	}
	
	if(boxRectMade and obj_toolPane.currentTool == obj_toolPane.toolBoxBrush and boxRectAbleToInitiate) {
		boxRectAbleToInitiate = false;
		alarm[10] = 5;
	}
	/*if(abs(mouseHoldRectY1 - mouseHoldRectY2) < gridSpaceVertical) {
		mouseRectWithinLine = true;
	}*/
}



// Shows variables used for in game bugtesting
if (showDevVars) {

	scr_drawCompassRose();
	
	// draw line in center of screen
	draw_set_color(c_ltgray);
	draw_line(0, 150 + (camera_get_view_height(camera_get_active()) - 150) / 2, camera_get_view_width(camera_get_active()), 150 + (camera_get_view_height(camera_get_active()) - 150) / 2);
	
	// draw dev variables on right side of screen
	scr_drawDevVars();
}

var scrollBarMarginTop = 230;
if (!obj_panelPane.showNav) {
	scrollBarMarginTop -= inst_panelPane_help.windowHeight;
	if(!obj_toolPane.showTool) {
		scrollBarMarginTop -= obj_toolPane.windowHeight;
	}
}


// draw scrollbar for main screen!!
var drawScrollBar = false;
if (filterGridActive or searchGridActive or quickFilterGridActive) {
	drawScrollBar = true;
	scr_gridViewDrawBackArrow();
}
else {
	if (!hideAll) {
		drawScrollBar = true;
	}
}

if (drawScrollBar) {
	scr_scrollBar(ds_grid_height(currentActiveLineGrid), -1, gridSpaceVertical, wordTopMargin,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, camera_get_view_width(camera_get_active()) - global.toolPaneWidth, camera_get_view_height(camera_get_active()));
}




	