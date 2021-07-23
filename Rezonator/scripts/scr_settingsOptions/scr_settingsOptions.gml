function scr_settingsOptions(optionSelected) {

	switch (optionSelected)
	{
		case "menu_theme":
		
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
		case "menu_zoom":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "help_label_zoom-in", "help_label_zoom-out", "menu_wide", "menu_narrow", "help_label_tall-rows", "help_label_short");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + optionSpacing, dropDownOptionList, global.optionListTypeZoom);
			}
	
		break;

		case "menu_user":
			obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.changeAuthor = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			obj_dialogueBox.inputWindowActive = true;
			instance_destroy(obj_dropDown);
		break;
		case "menu_zero":
			obj_control.currentNewWordPre = 4;
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.changeZero = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			obj_dialogueBox.inputWindowActive = true;
			instance_destroy(obj_dropDown);
		break;
		case "menu_restore-hints":
			global.readHintHide = false;
			instance_destroy(obj_dropDown);
		break;
		case "menu_language":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_language-en", "menu_language-it", "menu_language-es", "menu_language-he", "menu_language-vi", "menu_language-ja", "menu_language-zh","Gujarati","Armenian");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * 5), dropDownOptionList, global.optionListTypeLanguage);
			}
		break;
		
		case "menu_autosave":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_5-min", "menu_10-min", "menu_20-min", "menu_30-min", "Off");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * 6), dropDownOptionList, global.optionListTypeAutosave);
			}
		break;
		case "menu_advanced":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			
			ds_list_add(dropDownOptionList, "menu_developer");

						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * 7), dropDownOptionList, global.optionListTypeAdvanced);
			}
		break
		default:
		break;
	
	}


}
