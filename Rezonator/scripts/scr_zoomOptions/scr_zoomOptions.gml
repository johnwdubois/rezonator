function scr_zoomOptions(optionSelected) {

	switch (optionSelected)
	{
		case "Increase Text Size":
		
			if (global.fontSize < 5) {
				global.fontSize++;
				scr_setSpeakerLabelColWidth();
			}

			break;
		case "Decrease Text Size":
		
			if (global.fontSize > 0) {
				global.fontSize--;
				scr_setSpeakerLabelColWidth();
			}
			
			break;
		case "menu_wide":
		
			if (!obj_control.gridView) {
				scr_adjustTokenSpacing(20);
			}
		
			show_debug_message("BUH 4");
			break;
		case "menu_narrow":
		
			if (!obj_control.gridView) {
				scr_adjustTokenSpacing(-20);
			}
		
			show_debug_message("BUH 5");
			break;
		case "help_label_tall-rows":
			
			obj_control.prevCenterDisplayRow = scr_currentTopLine();
		
			if (obj_control.gridSpaceVertical < obj_control.gridSpaceVerticalMax) {
			
				obj_control.gridSpaceVertical += 10;
				// Don't go above the max
				obj_control.gridSpaceVertical = min(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMax);
				obj_control.lineSpacing += 4;
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
				obj_control.offIndex = true;
				scr_jumpToUnitTop(obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if (obj_control.arrowSpeed < obj_control.arrowSpeedMax) {
					obj_control.arrowSpeed++;	
				}
			}

			break;
		case "help_label_short":
		
			obj_control.prevCenterDisplayRow = scr_currentTopLine();

			if (obj_control.gridSpaceVertical > obj_control.gridSpaceVerticalMin) {
				obj_control.gridSpaceVertical -= 10;
				// Don't go below the min
				obj_control.gridSpaceVertical = max(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMin);
				obj_control.lineSpacing -= 4;
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
				obj_control.offIndex = true;
				scr_jumpToUnitTop(obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if (obj_control.arrowSpeed > obj_control.arrowSpeedMin) {
					obj_control.arrowSpeed--;	
				}
			
			}

			break;
		case "help_label_zoom-in":
		
			if (room == rm_openingScreen || room == rm_aiChat) {
				if (global.fontSize != 5) global.fontSize++;
			}
			else if (room == rm_mainScreen) {
			
				//vertical
				obj_control.prevCenterDisplayRow = scr_currentTopLine();
		
				if (obj_control.gridSpaceVertical < obj_control.gridSpaceVerticalMax) {
					obj_control.gridSpaceVertical += 10;
					// Don't go above the max
					obj_control.gridSpaceVertical = min(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMax);
					obj_control.lineSpacing += 4;
					obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
					obj_control.offIndex = true;
					scr_jumpToUnitTop(obj_control.prevCenterDisplayRow);
					// reset the ratio
					obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
					if (obj_control.arrowSpeed < obj_control.arrowSpeedMax) {
						obj_control.arrowSpeed++;	
					}
				}
			
				//horizontal
				if (!obj_control.gridView) {
					scr_adjustTokenSpacing(20);
				}
			
				//Text		
				if (global.fontSize < 5) {
					global.fontSize++;
					scr_setSpeakerLabelColWidth();
				}
			}
			break;
			
		case "help_label_zoom-out":
			
			if (room == rm_openingScreen || room == rm_aiChat) {
				if (global.fontSize != 0) global.fontSize--;
			}
			else if (room == rm_mainScreen) {
			
				//Vertical
				obj_control.prevCenterDisplayRow = scr_currentTopLine();

				if (obj_control.gridSpaceVertical > obj_control.gridSpaceVerticalMin) {
					obj_control.gridSpaceVertical -= 10;
					// Don't go above the max
					obj_control.gridSpaceVertical = max(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMin);
					obj_control.lineSpacing -= 4;
					obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
					obj_control.offIndex = true;
					scr_jumpToUnitTop(obj_control.prevCenterDisplayRow);
					// reset the ratio
					obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
					if (obj_control.arrowSpeed > obj_control.arrowSpeedMin) {
						obj_control.arrowSpeed--;	
					}
				}
			
			
				//Horizontal			
				if (!obj_control.gridView) {
					scr_adjustTokenSpacing(-20);
				}
		
				//TEXT		
				if (global.fontSize > 0) {
					global.fontSize--;
					scr_setSpeakerLabelColWidth();
				}
			
			}
			
			break;
	}


}
