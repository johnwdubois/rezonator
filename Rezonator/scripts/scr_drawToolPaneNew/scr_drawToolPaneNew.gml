function scr_drawToolPaneNew() {
	if (not obj_panelPane.showNav or not obj_toolPane.showTool) {
		y = -(windowHeight * 2);
		exit;
	}
	y = obj_menuBar.menuHeight;

	var toolSprScale = 1;//clamp(windowHeight / 210, 0.5, 1);
	//var toolButtonBuffer = 10;

	for (var i = 0; i < 3; i++) {
	
		var toolButtonX = x + ((i + 1) * (global.toolPaneWidth / 4));
		if (i == 0) {
			toolButtonX -= 15;
		}
		else if (i == 2) {
			toolButtonX += 15;
		}
		var toolButtonY = floor(y + (windowHeight / 2));
		//y + toolButtonBuffer + ((sprite_get_height(spr_toolsNew) * toolSprScale) * 0.5);
	
		/*
		if (i == 0) {
			var toolButtonY = y + toolButtonBuffer + ((sprite_get_height(spr_toolsNew) * toolSprScale) * 0.5);
		}
		else {
			var toolButtonY = y + (toolButtonBuffer * 2) + ((sprite_get_height(spr_toolsNew) * toolSprScale) * 1.5);
		}
		*/
		var mouseover = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, toolButtonX - (sprite_get_width(spr_toolsNew) / 2), toolButtonY - (sprite_get_height(spr_toolsNew) / 2), toolButtonX + (sprite_get_width(spr_toolsNew) / 2), toolButtonY + (sprite_get_height(spr_toolsNew) / 2));
		
		var toolImageIndex = 0;
		var toolTipText = "";
		if (i == 0) {
			toolImageIndex = (currentMode == modeRead) ? 2 : 0;
			if (currentMode != modeRead and mouseover) {
				toolImageIndex = 1;
			}
			toolTipText = "Read Mode";
		}
		else if (i == 1) {
			toolImageIndex = (currentMode == modeTrack) ? 8 : 6;
			if (currentMode != modeTrack and mouseover) {
				toolImageIndex = 7;
			}
			toolTipText = "Track Mode";
		}
		else {
			toolImageIndex = (currentMode == modeRez) ? 5 : 3;
			if (currentMode != modeRez and mouseover) {
				toolImageIndex = 4;
			}
			toolTipText = "Rez Mode";
		}
	
		draw_sprite_ext(spr_toolsNew, toolImageIndex, toolButtonX, toolButtonY, toolSprScale, toolSprScale, 0, c_white, 1);

	
		if (mouseover and not obj_panelPane.scrollBarClickLock) {
			hoverTime[i]++;

			//show_message("BUH: " + string(hoverTime) );
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
		
			scr_createTooltip(toolButtonX, toolButtonY + (sprite_get_height(spr_toolsNew) * 0.5), toolTipText, obj_tooltip.arrowFaceUp);
	
		}
	
		else {
			hoverTime[i] = 0;		
		}
	
	

	

	}
	/*
	for (var i = 0; i < 3; i++) {
		//draw tooltips
		if(hoverTime[i] == hoverTimeLimit){
			ToolTipPosX = mouse_x;
			ToolTipPosY = mouse_y;
		}
		else if(hoverTime[i] > hoverTimeLimit){
			if (i == 0) {
				scr_drawToolTip(ToolTipPosX, ToolTipPosY, "Read Mode", "top");
			}
			else if (i == 1) {
				scr_drawToolTip(ToolTipPosX, ToolTipPosY, "Track Mode", "top");
			}
			else if (i == 2) {
				scr_drawToolTip(ToolTipPosX, ToolTipPosY, "Rez Mode", "top");

			}
		}
	}
	*/


	// Prevent typing in text from changing the tool mode
	if (!obj_control.gridView and !obj_control.dialogueBoxActive) {
		if (keyboard_check_pressed(ord("R"))) {
			currentMode = modeRez;
		}
		if (keyboard_check_pressed(ord("T"))) {
			currentMode = modeTrack;
		}
	}

	if (global.wheresElmo) {
		currentMode = modeTrack;
	}


}
