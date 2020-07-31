var optionSelected = argument0;

switch (optionSelected)
{
	case "Pane":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Main", "Search", "Nav", "Grid", "Dev");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 14;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;
	
	case "Word":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Text", "Transcript");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 15;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;
	
	case "Justify":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Left", "Right", "Center");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing*2)  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 16;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;
	
	case "Prose":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Prose", "Grid");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing*3)  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 17;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;
	
	case "Hide":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Track", "Rez", "Stack", "Place");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing*4)  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 18;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;

	case "Filter":
		
		if (obj_control.filterGridActive) {
			if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
				//obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList);
				//obj_control.prevCenterYDest = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colUnitID, obj_control.currentCenterDisplayRow);
				obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
				// Keep the focus on previous currentCenterDisplayRow
				//with (obj_control) {
				//	alarm[5] = 1;
				//}
			}
			
			// Switch to active grid
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
		}
		else {
			
			obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
			// If filter is unactive. activate it
			with (obj_control) {
				scr_renderFilter();
			}
		}
		// Add to moveCounter
		obj_control.moveCounter ++;
		
		instance_destroy(obj_dropDown);
	break;
	
	case "Context":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Prior", "Tween", "Next");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing*6)  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 19;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;

	case "Dark Theme":
		
		global.colorTheme++;
		if (global.colorTheme >= ds_grid_height(global.colorThemeGrid)) {
			global.colorTheme = 0;
		}
	
		global.colorThemeBG = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colBG, global.colorTheme);
		global.colorThemeText = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colText, global.colorTheme);
		global.colorThemeSelected1 = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colSelected1, global.colorTheme);
		global.colorThemeSelected2 = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colSelected2, global.colorTheme);
		global.colorThemeBorders = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colBorders, global.colorTheme);
		global.colorThemePaneBG = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colPaneBG, global.colorTheme);
		global.colorThemeOutOfBounds = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colOutOfBounds, global.colorTheme);
		global.colorThemeHighlight = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colHighlight, global.colorTheme);
	
		var layerID = layer_get_id("Background");
		var backID = layer_background_get_id(layerID);
		layer_background_blend(backID, global.colorThemeBG);
		
		instance_destroy(obj_dropDown);
	break;
	case "Zoom":
	
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "In", "Out", "Wide", "Narrow", "Tall", "Short");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y+ (obj_dropDown.optionSpacing*5), -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 13;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	
	break;
	
	default:
	break;
}