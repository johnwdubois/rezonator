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

if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) - 20, 200, camera_get_view_width(view_camera[0]), max(200, camera_get_view_height(view_camera[0])))) {
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
obj_control.mouseoverNeutralSpace = false;

scr_drawLine();
//scr_drawChunk();
//scr_drawDialogueBox();
//scr_stackShowWindow();

//mouseRectWithinLine = false;
// Draw the mouse drag rectangle
if (not mouseoverPanelPane and not scrollBarHolding and obj_toolPane.currentTool != obj_toolPane.toolNewWord and not mouseoverNeutralSpace and obj_toolPane.currentMode != obj_toolPane.modeRead) {
	if(not mouseRectMade) {
		if (current_time - sessionStartTime > 2000 and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush and !obj_chain.inRezPlay) {// Curfew for the volunteers
			if(obj_toolPane.currentTool != obj_toolPane.toolStackBrush or mouseoverSpeakerLabel) {
				scr_mouseRect();
			}
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




draw_set_font(fnt_debug);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_alpha(1);



// Shows variables used for in game bugtesting
if (showDevVars) {
	

	scr_drawCompassRose();
	
	draw_set_color(c_ltgray);
	draw_line(0, 150 + (camera_get_view_height(view_camera[0]) - 150) / 2, camera_get_view_width(view_camera[0]), 150 + (camera_get_view_height(view_camera[0]) - 150) / 2);

	draw_set_color(global.colorThemeText);
	draw_text(camera_get_view_width(view_camera[0]) - 100, 80, "currentFocusedChainID: " + string(obj_chain.currentFocusedChainID));
	
	draw_text(camera_get_view_width(view_camera[0]) - 500, 250, "fps: " + string(fps));
	draw_text(camera_get_view_width(view_camera[0]) - 500, 330, "gridSpaceVertical: " + string(gridSpaceVertical));
	draw_text(camera_get_view_width(view_camera[0]) - 500, 350, "arrowSpeed: " + string(arrowSpeed));
	draw_text(camera_get_view_width(view_camera[0]) - 500, 400, "Tooltip Hover time: " + string(obj_toolPane.hoverTime[0]) +", "+ string(obj_toolPane.hoverTime[1]) +", "+ string(obj_toolPane.hoverTime[2]));
	draw_text(camera_get_view_width(view_camera[0]) - 500, 400, "Tooltip Hover time Helpbar: " + string(obj_panelPane.hoverTime[0]) +", "+ string(obj_panelPane.hoverTime[1]) +", "+ string(obj_panelPane.hoverTime[2]) +", "+ string(obj_panelPane.hoverTime[3]));	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 150, "currentCenterDisplayRow: " + string(currentCenterDisplayRow));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 170, "lineGrid height: " + string(ds_grid_height(lineGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 190, "unitGrid height: " + string(ds_grid_height(unitGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 210, "total unit amount: " + string(global.totalUnitAmount));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 230, "units loaded: " + string((ds_grid_height(unitGrid) / global.totalUnitAmount) * 100) + "%");
	draw_text(camera_get_view_width(view_camera[0]) - 100, 270, "wordGrid height: " + string(ds_grid_height(wordGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 290, "dynamicWordGrid height: " + string(ds_grid_height(dynamicWordGrid)));

	draw_text(camera_get_view_width(view_camera[0]) - 100, 310, "displayRowAscending: " + string(displayRowAscending));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 330, "currentChainID: " + string(obj_chain.currentChainID));
	//draw_text(camera_get_view_width(view_camera[0]) - 100, 350, "clickedChunkID: " + string(clickedChunkID));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 370, "mouseLineHide: " + string(showMouseLine));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 400, "newWordHoverWordID: " + string(newWordHoverWordID));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 420, "rectNotInPanelPane: " + string(rectNotInPanelPane));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 440, "mouseOverPanelPane: " + string(mouseoverPanelPane));
	
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 460, "Right clicked word: " + string(rightClickWordID));
	
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
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 810, "wordLeftMargin: " + string(wordLeftMargin));
	draw_text(camera_get_view_width(view_camera[0]) -500 , 810, "cursorPos: " + string(obj_control.cursorPos));
	draw_text(camera_get_view_width(view_camera[0]) -500 , 830, "inputString Length: " + string(string_length(obj_control.inputText)));

		
	draw_text(camera_get_view_width(view_camera[0]) - 100, 830, "speakerLabelColXList: " + scr_getStringOfList(speakerLabelColXList));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 850, "speakerLabelColPrevList: " + scr_getStringOfList(speakerLabelColPrevList));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 870, "speakerLabelColXHolding: " + string(speakerLabelColXHolding));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 900, "speakerLabelMargin: " + string(speakerLabelMargin));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 930, "allSaved: " + string(allSaved));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 960, "current_time: " + string(current_time));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 980, "hoverWordID: " + string(hoverWordID));
	
	draw_text(camera_get_view_width(view_camera[0]) - 400, 850, "drawLine offset: " + string(drawRangeCenterOffset));
	draw_text(camera_get_view_width(view_camera[0]) - 600, 880, "drawRangeExtraStepsBack: " + string(drawRangeExtraStepsBack));
	draw_text(camera_get_view_width(view_camera[0]) - 600, 900, "drawRangeExtraStepsForward: " + string(drawRangeExtraStepsForward));
	draw_text(camera_get_view_width(view_camera[0]) - 600, 920, "drawRangeCenter: " + string(drawRangeCenter));
	
	
	draw_text(camera_get_view_width(view_camera[0]) - 400, 930, "toolPane.currentTool: " + string(obj_toolPane.currentTool));
	draw_text(camera_get_view_width(view_camera[0]) - 400, 950, "toolPane.tempReturnTool: " + string(obj_toolPane.tempReturnTool));
	
	
	draw_text(camera_get_view_width(view_camera[0]) - 300, 680, "scrollPlusY: " + string(scrollPlusY));
	draw_text(camera_get_view_width(view_camera[0]) - 300, 700, "scrollPlusYDest: " + string(scrollPlusYDest));
	draw_text(camera_get_view_width(view_camera[0]) - 300, 720, "scrollBarPlusY: " + string(scrollBarPlusY));
	
	draw_text(camera_get_view_width(view_camera[0]) - 300, 750, "mouseoverScrollBar: " + string(mouseoverScrollBar));
	draw_text(camera_get_view_width(view_camera[0]) - 300, 780, "mouseoverSpeakerLabel: " + string(mouseoverSpeakerLabel));
	
	
	var chainListY = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListY = y;
		}
	}
	draw_text(camera_get_view_width(view_camera[0]) - 500, 550, "chainListY: " + string(chainListY));
	draw_text(camera_get_view_width(view_camera[0]) - 500, 580, "mouseXY: (" + string(mouse_x) + ", " + string(mouse_y) + ")");
	draw_text(camera_get_view_width(view_camera[0]) - 500, 600, "wordTopMargin: " + string(wordTopMargin));
	draw_text(camera_get_view_width(view_camera[0]) - 500, 620, "wordTokenView: " + string(wordTokenView));
	
	
	draw_text(camera_get_view_width(view_camera[0]) - 1000, 400, "chainShowList: " + scr_getStringOfList(obj_chain.chainShowList));
}
var scrollBarMarginTop = 230;
if(!obj_panelPane.showNav) {
	scrollBarMarginTop -= inst_panelPane_help.windowHeight;
	if(!obj_toolPane.showTool) {
		scrollBarMarginTop -= obj_toolPane.windowHeight;
	}
}
if(filterGridActive){
	/*
	if(stackShowActive)	{
		scr_scrollBar(ds_grid_height(currentActiveLineGrid) + stackShowBuffer , -1, gridSpaceVertical, wordTopMargin,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));
	}
	else{
		scr_scrollBar(ds_grid_height(currentActiveLineGrid) + stackShowBuffer , -1, gridSpaceVertical, wordTopMargin,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));
	}
	*/
	if(stackShowActive)	{
		scr_scrollBar(ds_grid_height(currentActiveLineGrid), -1, gridSpaceVertical, wordTopMargin,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));
	}
	else {
		scr_scrollBar(ds_grid_height(currentActiveLineGrid), -1, gridSpaceVertical, wordTopMargin,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));
	}
}
else{
	scr_scrollBar(ds_grid_height(currentActiveLineGrid), -1, gridSpaceVertical, wordTopMargin,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

}







	