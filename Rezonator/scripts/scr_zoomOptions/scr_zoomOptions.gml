function scr_zoomOptions(argument0) {
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Increase Text Size":
		
			if (global.fontSize < 5) {
				global.fontSize++;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = true;
		
			//show_message("BUH 2");
			break;
		case "Decrease Text Size":
		
			if (global.fontSize > 0) {
				global.fontSize--;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = false;
			
			//show_message("BUH 3");
			break;
		case "Wide":
		
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal += 20;
			}
		
			//show_message("BUH 4");
			break;
		case "Narrow":
		
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal -= 20;
			}
		
			//show_message("BUH 5");
			break;
		case "Tall":
			
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
			//show_message("BUH 4");
			break;
		case "Short":
		
			
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
			//show_message("BUH 5");
			break;
		case "In":
		
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
			
			//Text		
			if (global.fontSize < 5) {
				global.fontSize++;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = true;
			
			break;
		case "Out":
			
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
		
			//TEXT		
			if (global.fontSize > 0) {
				global.fontSize--;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = false;
			
			break;
	}


}
