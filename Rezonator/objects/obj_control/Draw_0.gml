/*
	obj_control: Draw
	
	Last Updated: 2019-02-11
	
	Called from: Every frame of the game
	
	Purpose: Call the camera adjuster, show the display columns and the developer variables
	
	Mechanism: DevVars: checks for necessity, then draws developer variables wherever the camera is
	
	Author: Terry DuBois
*/

// color theme control
scr_colorThemeControl();

// adjust view to window size
scr_windowCameraAdjust();

if (gridView) {
	exit;
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


scr_drawLine();
//scr_drawChunk();
//scr_drawSearchBox();


// Draw the mouse drag rectangle
if (not mouseoverPanelPane) {
	if (current_time - sessionStartTime > 2000 and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush and !obj_chain.inRezPlay) { // Curfew for the volunteers
		scr_mouseRect();
	}
	else if (current_time - sessionStartTime > 2000 and obj_toolPane.currentTool == obj_toolPane.toolBoxBrush and !obj_chain.inRezPlay) {
		scr_boxRect();
	}
}



// Create the quickStack with the mouse drag, if possible
if (mouseRectMade and quickStackAbleToInitiate) {
	quickStackAbleToInitiate = false;
	alarm[7] = 5;
}
else if (mouseRectMade and obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
	alarm[8] = 5;
}
if(boxRectMade and obj_toolPane.currentTool == obj_toolPane.toolBoxBrush and boxRectAbleToInitiate) {
	boxRectAbleToInitiate = false;
	alarm[10] = 5;
}

draw_set_font(fnt_debug);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_alpha(1);



// Shows variables used for in game bugtesting
if (showDevVars) {
	
	draw_set_color(c_ltgray);
	draw_line(0, 150 + (camera_get_view_height(view_camera[0]) - 150) / 2, camera_get_view_width(view_camera[0]), 150 + (camera_get_view_height(view_camera[0]) - 150) / 2);

	draw_set_color(global.colorThemeText);
	draw_text(camera_get_view_width(view_camera[0]) - 100, 80, "currentFocusedChainID: " + string(obj_chain.currentFocusedChainID));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 100, "fps: " + string(fps));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 130, "gridSpaceVertical: " + string(gridSpaceVertical));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 150, "currentCenterDisplayRow: " + string(currentCenterDisplayRow));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 170, "lineGrid height: " + string(ds_grid_height(lineGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 190, "unitGrid height: " + string(ds_grid_height(unitGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 210, "total unit amount: " + string(global.totalUnitAmount));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 230, "units loaded: " + string((ds_grid_height(unitGrid) / global.totalUnitAmount) * 100) + "%");
	draw_text(camera_get_view_width(view_camera[0]) - 100, 270, "wordGrid height: " + string(ds_grid_height(wordGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 290, "dynamicWordGrid height: " + string(ds_grid_height(dynamicWordGrid)));

	draw_text(camera_get_view_width(view_camera[0]) - 100, 310, "displayRowAscending: " + string(displayRowAscending));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 330, "currentChainID: " + string(obj_chain.currentChainID));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 350, "clickedChunkID: " + string(clickedChunkID));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 400, "newWordHoverWordID: " + string(newWordHoverWordID));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 440, "moveCounter: " + string(moveCounter));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 485, "chainIDModifyList: ");
	draw_text(camera_get_view_width(view_camera[0]) - 100, 500, scr_getStringOfList(obj_chain.chainIDModifyList));
	
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 550, "inRectUnitIDList: ");
	draw_text(camera_get_view_width(view_camera[0]) - 100, 570, scr_getStringOfList(inRectUnitIDList));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 590, "inRectWordIDList: ");
	draw_text(camera_get_view_width(view_camera[0]) - 100, 610, scr_getStringOfList(inRectWordIDList));
	
	
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 630, "mostRecentlyAddedWord: " + string(mostRecentlyAddedWord));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 650, "mostRecentlyAddedWordMoved: " + string(mostRecentlyAddedWordMoved));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 680, "global.participantColorList: ");
	draw_text(camera_get_view_width(view_camera[0]) - 100, 700, scr_getStringOfList(global.participantColorList));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 750, "chainColorID[1]: " + string(obj_chain.chainColorID[1]));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 770, "chainColorID[2]: " + string(obj_chain.chainColorID[2]));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 790, "chainColorID[3]: " + string(obj_chain.chainColorID[3]));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 810, "leftScreenBound: " + string(leftScreenBound));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 840, "speakerLabelColWidth[0]: " + string(speakerLabelColWidth[0]));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 860, "speakerLabelColWidth[1]: " + string(speakerLabelColWidth[1]));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 880, "speakerLabelColWidth[2]: " + string(speakerLabelColWidth[2]));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 900, "speakerLabelMargin: " + string(speakerLabelMargin));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 930, "allSaved: " + string(allSaved));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 960, "current_time: " + string(current_time));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 980, "hoverWordID: " + string(hoverWordID));
}