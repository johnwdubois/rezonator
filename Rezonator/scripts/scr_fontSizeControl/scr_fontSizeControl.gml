// Adjust the font size

if(os_type == os_macosx){
		// Adjust the font size
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_subtract)
	or (keyboard_check(vk_control) and keyboard_check_direct(109)) and canPressPlus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize > 0) {
				global.fontSize--;
				with (obj_alarm) {
					alarm[0] = 5;
				}
			}
			gridSpaceVerticalMin = gridSpaceVerticalMinOriginal + ((global.fontSize + 1) * 5);
			//Vertical				
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentCenterLine();

			if(obj_control.gridSpaceVertical > obj_control.gridSpaceVerticalMin) {
				obj_control.gridSpaceVertical -= 10;
				// Don't go above the max
				obj_control.gridSpaceVertical = max(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMin);
				obj_control.lineSpacing -= 4;
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
				// Multiply each line's pixelY by the new ratio
				ds_grid_multiply_region(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.lineGrid), obj_control.gridSpaceRatio);
			
				// If the search or filter grids are populated, then set their pixelY's as well
				if(searchGridPopulated) {
					ds_grid_multiply_region(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.searchGrid), obj_control.gridSpaceRatio);
				}
				if(filterGridPopulated) {
					ds_grid_multiply_region(obj_control.filterGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.filterGrid), obj_control.gridSpaceRatio);
				}
				scr_jumpToLine("", obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed > obj_control.arrowSpeedMin) {
					obj_control.arrowSpeed--;	
				}
			}
			
			
			//Horizontal			
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal -= 20;
			}
			global.navTextBig = false;
		}
		else {
			if (!gridView) {
				gridSpaceHorizontal -= 20;
			}
		}
		canPressPlus = false;
		alarm[3] = 15;
	}
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_add)
	or (keyboard_check(vk_control) and keyboard_check(24)) and canPressMinus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize < 5) {
				global.fontSize++;
				with (obj_alarm) {
					alarm[0] = 5;
				}
			}
			gridSpaceVerticalMin = gridSpaceVerticalMinOriginal + ((global.fontSize + 1) * 5);
			//vertical
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentCenterLine();
		
			if(obj_control.gridSpaceVertical < obj_control.gridSpaceVerticalMax) {
				obj_control.gridSpaceVertical += 10;
				// Don't go above the max
				obj_control.gridSpaceVertical = min(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMax);
				obj_control.lineSpacing += 4;
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
				// Multiply each line's pixelY by the new ratio
				ds_grid_multiply_region(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.lineGrid), obj_control.gridSpaceRatio);
			
				// If the search or filter grids are populated, then set their pixelY's as well
				if(searchGridPopulated) {
					ds_grid_multiply_region(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.searchGrid), obj_control.gridSpaceRatio);
				}
				if(filterGridPopulated) {
					ds_grid_multiply_region(obj_control.filterGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.filterGrid), obj_control.gridSpaceRatio);
				}
				scr_jumpToLine("", obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed < obj_control.arrowSpeedMax) {
					obj_control.arrowSpeed++;	
				}
			}
			
			//horizontal
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal += 20;
			}
			global.navTextBig = true;
		}
		else {
			if (!gridView) {
				gridSpaceHorizontal += 20;
			}
		}
		canPressMinus = false;
		alarm[4] = 15;
	}
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_numpad0)
	or keyboard_check(vk_control) and keyboard_check_pressed(ord("0"))) {
		if (!gridView) {
			gridSpaceHorizontal = 100;
		}
	}
	
}
else{
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_subtract)
	or (keyboard_check(vk_control) and keyboard_check(189)) and canPressPlus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize > 0) {
				global.fontSize--;
				with (obj_alarm) {
					alarm[0] = 5;
				}
			}
			gridSpaceVerticalMin = gridSpaceVerticalMinOriginal + ((global.fontSize + 1) * 5);
			//Vertical				
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentCenterLine();

			if(obj_control.gridSpaceVertical > obj_control.gridSpaceVerticalMin) {
				obj_control.gridSpaceVertical -= 10;
				// Don't go above the max
				obj_control.gridSpaceVertical = max(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMin);
				obj_control.lineSpacing -= 4;
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
				// Multiply each line's pixelY by the new ratio
				ds_grid_multiply_region(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.lineGrid), obj_control.gridSpaceRatio);
			
				// If the search or filter grids are populated, then set their pixelY's as well
				if(searchGridPopulated) {
					ds_grid_multiply_region(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.searchGrid), obj_control.gridSpaceRatio);
				}
				if(filterGridPopulated) {
					ds_grid_multiply_region(obj_control.filterGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.filterGrid), obj_control.gridSpaceRatio);
				}
				scr_jumpToLine("", obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed > obj_control.arrowSpeedMin) {
					obj_control.arrowSpeed--;	
				}
			}
			
			
			//Horizontal			
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal -= 20;
			}
			global.navTextBig = false;
		}
		else {
			if (!gridView) {
				gridSpaceHorizontal -= 20;
			}
		}
		canPressPlus = false;
		alarm[3] = 15;
	}
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_add)
	or (keyboard_check(vk_control) and keyboard_check_direct(187)) and canPressMinus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize < 5) {
				global.fontSize++;
				with (obj_alarm) {
					alarm[0] = 5;
				}
			}
			gridSpaceVerticalMin = gridSpaceVerticalMinOriginal + ((global.fontSize + 1) * 5);
			//vertical
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentCenterLine();
		
			if(obj_control.gridSpaceVertical < obj_control.gridSpaceVerticalMax) {
				obj_control.gridSpaceVertical += 10;
				// Don't go above the max
				obj_control.gridSpaceVertical = min(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMax);
				obj_control.lineSpacing += 4;
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
				// Multiply each line's pixelY by the new ratio
				ds_grid_multiply_region(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.lineGrid), obj_control.gridSpaceRatio);
			
				// If the search or filter grids are populated, then set their pixelY's as well
				if(searchGridPopulated) {
					ds_grid_multiply_region(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.searchGrid), obj_control.gridSpaceRatio);
				}
				if(filterGridPopulated) {
					ds_grid_multiply_region(obj_control.filterGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.filterGrid), obj_control.gridSpaceRatio);
				}
				scr_jumpToLine("", obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed < obj_control.arrowSpeedMax) {
					obj_control.arrowSpeed++;	
				}
			}
			
			//horizontal
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal += 20;
			}
			global.navTextBig = true;
		}
		else {
			if (!gridView) {
				gridSpaceHorizontal += 20;
			}
		}
		canPressMinus = false;
		alarm[4] = 15;
	}
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_numpad0)
	or keyboard_check(vk_control) and keyboard_check_pressed(ord("0"))) {
		if (!gridView) {
			gridSpaceHorizontal = 100;
		}
	}
	
}

scr_fontGlobalUpdate();

gridSpaceVerticalMin = gridSpaceVerticalMinOriginal + ((global.fontSize + 1) * 5);

if(global.navTextBig){
//		global.fontChainContents = fnt_chainContentsLarge1;	
//		global.fontPanelTab = fnt_panelTabLarge1;
//		global.fontSortPane = fnt_sortPaneLarge1;
}
else{
//		global.fontChainContents = fnt_chainContents;
//		global.fontPanelTab = fnt_panelTab;
//		global.fontSortPane = fnt_sortPane;
}