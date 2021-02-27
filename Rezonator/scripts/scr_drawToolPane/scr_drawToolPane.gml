function scr_drawToolPane(toolSprScale) {


	var toolSprWidth = sprite_get_width(spr_toolsNew) * toolSprScale;
	var toolSprHeight = sprite_get_height(spr_toolsNew) * toolSprScale;
	var camHeight = camera_get_view_height(camera_get_active());

	for (var i = 0; i < 3; i++) {
	
		// get tool button coordinates
		var toolButtonX = floor(x + (windowWidth / 2));
		var toolButtonY = floor(y + (toolSprHeight * ((i * 1.3) + 1)));
		var toolButtonRectBuffer = toolSprWidth * 0.06;
		var toolButtonRectX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
		var toolButtonRectY1 = floor(toolButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
		var toolButtonRectX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
		var toolButtonRectY2 = floor(toolButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
		
		var mouseover = point_in_rectangle(mouse_x, mouse_y, toolButtonRectX1, toolButtonRectY1, toolButtonRectX2, toolButtonRectY2) && !instance_exists(obj_dropDown);
		var toolSelected = (i == 0 && currentMode == modeRead) || (i == 1 && currentMode == modeTrack) || (i == 2 && currentMode == modeRez);
		
		// determine which image index of sprite to use
		var toolImageIndex = 0;
		var toolTipText = "";
		if (i == 0) {
			toolImageIndex = (toolSelected) ? 2 : 0;
			if (currentMode != modeRead and mouseover) {
				toolImageIndex = 1;
			}
			toolTipText = "Read Mode";
		}
		else if (i == 1) {
			toolImageIndex = (toolSelected) ? 8 : 6;
			if (currentMode != modeTrack and mouseover) {
				toolImageIndex = 7;
			}
			toolTipText = "Track Mode";
		}
		else {
			toolImageIndex = (toolSelected) ? 5 : 3;
			if (currentMode != modeRez and mouseover) {
				toolImageIndex = 4;
			}
			toolTipText = "Rez Mode";
		}
		
		// draw highlight rectangle if tool is selected
		if (toolSelected) {
			draw_set_color(global.colorThemeBG);
			draw_roundrect(toolButtonRectX1, toolButtonRectY1, toolButtonRectX2, toolButtonRectY2, false);
		}
		
		// draw tool button sprite
		draw_sprite_ext(spr_toolsNew, toolImageIndex, toolButtonX, toolButtonY, toolSprScale, toolSprScale, 0, c_white, 1);
	
		// mouseover & click on tool button
		if (mouseover and not obj_panelPane.scrollBarClickLock) {
			hoverTime[i]++;
			if (mouse_check_button_released(mb_left) and not obj_panelPane.scrollBarClickLock) {
				if (i == 0) {
					currentMode = modeRead;
					obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabLine;
					if(obj_control.searchGridActive) {
						obj_toolPane.setModeSearch = obj_toolPane.modeRead;
					}
					else {
						obj_toolPane.setModeMain = obj_toolPane.modeRead;
					}
				}
				else if (i == 1) {
					currentMode = modeTrack;
					obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabTrackBrush;
					if(obj_control.searchGridActive) {
						obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
					}
					else {
						obj_toolPane.setModeMain = obj_toolPane.modeTrack;
					}
				}
				else if (i == 2) {
					currentMode = modeRez;
					obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabRezBrush;
					if(obj_control.searchGridActive) {
						obj_toolPane.setModeSearch = obj_toolPane.modeRez;
					}
					else {
						obj_toolPane.setModeMain = obj_toolPane.modeRez;
					}
				}
				if (obj_control.gridView) {
					obj_control.gridView = false;
				}
			}
		
			scr_createTooltip(toolButtonX - (toolSprWidth *0.5), toolButtonY, toolTipText, obj_tooltip.arrowFaceRight);
		}
		else {
			hoverTime[i] = 0;		
		}
	}


	// Prevent typing in text from changing the tool mode
	if (!obj_control.gridView and !obj_control.dialogueBoxActive and !instance_exists(obj_dropDown) and !instance_exists(obj_dialogueBox) and obj_control.mouseoverTagShortcut == "") {
		if (keyboard_check_pressed(ord("E")) and not keyboard_check(vk_control)) {
			currentMode = modeRead;
			obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabLine;
		}
		if (keyboard_check_pressed(ord("R")) and not keyboard_check(vk_control)) {
			currentMode = modeRez;
			obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabRezBrush;
		}
		if (keyboard_check_pressed(ord("T"))) {
			currentMode = modeTrack;
			obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabTrackBrush;
		}
	}

	if (global.wheresElmo) {
		currentMode = modeTrack;
	}
	
	// clicking on toolpane will deselect chain
	if (device_mouse_check_button_released(0, mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (not obj_control.gridView) {
			with (obj_chain) {
				scr_chainDeselect();
			}
		}
	}
	
	// help button
	var helpSpriteWidth = sprite_get_width(spr_helpToggle) * toolSprScale;
	var helpX1 = x + (windowWidth/2) - (helpSpriteWidth/2);
	var helpY1 = camHeight * 0.95;
	var helpX2 = helpX1 + helpSpriteWidth;
	var helpY2 = helpY1 + helpSpriteWidth;
	var mouseOverHelp = point_in_rectangle(mouse_x,mouse_y,helpX1, helpY1, helpX2, helpY2);
	
	var helpSubImage = (mouseOverHelp) ? 1 : 0;
	
	draw_sprite_ext(spr_helpToggle, helpSubImage , floor( mean( helpX2 , helpX1)), floor( mean( helpY2 , helpY1)) , toolSprScale, toolSprScale,0, c_white ,1);
	
	var helpToolTipText = "Help";
	
	if(mouseOverHelp){
		scr_createTooltip(helpX1, floor( mean( helpY2 , helpY1)), helpToolTipText , obj_tooltip.arrowFaceRight);
		if(device_mouse_check_button_released(0, mb_left)){
			with(obj_panelPane){
				functionHelp_collapsed = !functionHelp_collapsed;
			}
		}
	}
	
	
	// justify buttons
	var justifySprWidth = sprite_get_width(spr_justifyLeft) * toolSprScale;
	for (var i = 0; i < 3; i++) {
		
		// determine stuff based on i loop
		var justifyX = 0;
		var sprIndex = spr_justifyLeft;
		var justifyMode = 0;
		var tipText = "";
		if (i == 0) {
			justifyX = x + (global.toolPaneWidth * 0.2);
			sprIndex = spr_justifyLeft;
			justifyMode = obj_control.justifyLeft;
			tipText = "Justify left";
		}
		else if (i == 1) {
			justifyX = x + (global.toolPaneWidth / 2);
			sprIndex = spr_justifyCenter;
			justifyMode = obj_control.justifyCenter;
			tipText = "Justify center";
		}
		else if (i == 2) {
			justifyX = x + (global.toolPaneWidth * 0.8);
			sprIndex = spr_justifyRight;
			justifyMode = obj_control.justifyRight;
			tipText = "Justify right";
		}
	
		// coordinates for justify buttons
		var justifyRectX1 = justifyX - (justifySprWidth / 2);
		var justifyRectY1 = camHeight * 0.9;
		var justifyRectX2 = justifyRectX1 + justifySprWidth;
		var justifyRectY2 = justifyRectY1 + justifySprWidth;
		var mouseoverJustify = point_in_rectangle(mouse_x, mouse_y, justifyRectX1, justifyRectY1, justifyRectX2, justifyRectY2);
		var justifySelected = ((i == 0 && obj_control.justify == obj_control.justifyLeft)
							|| (i == 1 && obj_control.justify == obj_control.justifyCenter)
							|| (i == 2 && obj_control.justify == obj_control.justifyRight));
		
		var imgIndex = 0;
		if (justifySelected) imgIndex = 2;
		else if (mouseoverJustify) imgIndex = 1;
		
		// selected rect
		if (justifySelected) {
			var selectedRectBuffer = justifySprWidth * 0.1;
			draw_set_color(global.colorThemeBG);
			draw_roundrect(floor(justifyRectX1 - selectedRectBuffer-1), floor(justifyRectY1 - selectedRectBuffer-1), floor(justifyRectX2 + selectedRectBuffer), floor(justifyRectY2 + selectedRectBuffer), false);
		}
		
		// mouseover & click
		if (mouseoverJustify) {
			if (mouse_check_button_released(mb_left)) {
				obj_control.justify = justifyMode;
			}
			scr_createTooltip(justifyX, justifyRectY1, tipText, obj_tooltip.arrowFaceDown);
		}
		
		draw_sprite_ext(sprIndex, imgIndex, mean(justifyRectX1, justifyRectX2), mean(justifyRectY1, justifyRectY2), toolSprScale, toolSprScale, 0, c_white, 1);
		
	}
	
	
	// shape buttons
	var shapeSprWidth = sprite_get_width(spr_proseText) * toolSprScale;

	for (var i = 0; i < 2; i++) {
		
		// determine stuff based on i loop
		var shapeX = 0;
		var sprIndex = spr_proseText;
		var shapeMode = 0;
		var tipText = "";
		if (i == 0) {
			shapeX = x + (global.toolPaneWidth * 0.33);
			sprIndex = spr_proseText;
			shapeMode = obj_control.shapeText;
			tipText = "Prose view";
		}
		else if (i == 1) {
			shapeX = x + (global.toolPaneWidth * 0.66);
			sprIndex = spr_gridText;
			shapeMode = obj_control.shapeBlock;
			tipText = "Grid view";
		}
	
		// coordinates for justify buttons
		var shapeRectX1 = shapeX - (shapeSprWidth / 2);
		var shapeRectY1 = camHeight * 0.85;
		var shapeRectX2 = shapeRectX1 + shapeSprWidth;
		var shapeRectY2 = shapeRectY1 + shapeSprWidth;
		var mouseoverShape = point_in_rectangle(mouse_x, mouse_y, shapeRectX1, shapeRectY1, shapeRectX2, shapeRectY2);
		var shapeSelected = ((i == 0 && obj_control.shape == obj_control.shapeText)
							|| (i == 1 && obj_control.shape == obj_control.shapeBlock));

		
		var imgIndex = 0;
		if (shapeSelected) imgIndex = 2;
		else if (mouseoverShape) imgIndex = 1;
		
		// selected rect
		if (shapeSelected) {
			var selectedRectBuffer = shapeSprWidth * 0.1;
			draw_set_color(global.colorThemeBG);
			draw_roundrect(floor(shapeRectX1 - selectedRectBuffer-1), floor(shapeRectY1 - selectedRectBuffer-1), floor(shapeRectX2 + selectedRectBuffer), floor(shapeRectY2 + selectedRectBuffer), false);
		}
		
		// mouseover & click
		if (mouseoverShape) {
			if (mouse_check_button_released(mb_left)) {
				obj_control.shape = shapeMode;
			}
			scr_createTooltip(shapeX, shapeRectY1, tipText, obj_tooltip.arrowFaceDown);
		}
		
		draw_sprite_ext(sprIndex, imgIndex, mean(shapeRectX1, shapeRectX2), mean(shapeRectY1, shapeRectY2), toolSprScale, toolSprScale, 0, c_white, 1);
		
	}

}
