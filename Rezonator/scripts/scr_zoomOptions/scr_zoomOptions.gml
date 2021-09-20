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
				if (!scr_checkNativeJustification() && obj_control.shape == obj_control.shapeBlock) scr_refreshDisplayCol();
			}
		
			show_debug_message("BUH 4");
			break;
		case "menu_narrow":
		
			if (!obj_control.gridView) {
				scr_adjustTokenSpacing(-20);
				if (!scr_checkNativeJustification() && obj_control.shape == obj_control.shapeBlock) scr_refreshDisplayCol();
			}
		
			show_debug_message("BUH 5");
			break;
		case "help_label_tall-rows":
			
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentTopLine();
		
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
				scr_jumpToUnit(obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed < obj_control.arrowSpeedMax) {
					obj_control.arrowSpeed++;	
				}
			}

			break;
		case "help_label_short":
		
			
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentTopLine();

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
				scr_jumpToUnit(obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed > obj_control.arrowSpeedMin) {
					obj_control.arrowSpeed--;	
				}
			
			}

			break;
		case "help_label_zoom-in":
		
			if(room == rm_openingScreen){
				if(global.fontSize != 5) global.fontSize++;
				exit;
			}
			
			//vertical
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentTopLine();
		
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
				scr_jumpToUnit(obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed < obj_control.arrowSpeedMax) {
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
			with (obj_dropDown) instance_destroy();
			break;
			
		case "help_label_zoom-out":
			
			if(room == rm_openingScreen){
				if(global.fontSize != 0) global.fontSize--;
				exit;
			}
			
			
			//Vertical				
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentTopLine();

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
				scr_jumpToUnit(obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed > obj_control.arrowSpeedMin) {
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
			
			with (obj_dropDown) instance_destroy();
			break;
	}


}
