function scr_settingsOptions(argument0) {
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Theme":
		
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
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + optionSpacing , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 13;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
	
		break;

		case "User":
			obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.changeAuthor = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			instance_destroy(obj_dropDown);
		break;
		case "Zero":
			obj_control.currentNewWordPre = 4;
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.changeZero = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			instance_destroy(obj_dropDown);
		break;
		
		
		case "Autosave":
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "5 minutes", "10 minutes", "20 minutes", "30 minutes", "Off");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing*3)  , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 40;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		break;
		case "Advanced":
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Developer");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing*4)  , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 5;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		break
		default:
		break;
	
	}


}
