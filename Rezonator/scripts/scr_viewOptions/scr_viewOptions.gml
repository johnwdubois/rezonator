function scr_viewOptions(optionSelected) {
	
	var optionIndex = ds_list_find_index(optionList, optionSelected);

	switch (optionSelected)
	{
		case "menu_window":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_nav", "menu_search", "menu_grid");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y, dropDownOptionList, global.optionListTypePane);
			}
		break;
	
	
		case "menu_justify":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_left", "menu_right");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing), dropDownOptionList, global.optionListTypeJustify);
			}
		break;
	
		case "menu_prose":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_prose", "menu_grid");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeProse);
			}
		break;
	
		case "menu_hide":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_track", "menu_resonance", "menu_stack");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeHide);
			}
		break;

		
	
		case "menu_filter-context":
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_above", "menu_between", "menu_below");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeContext);
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
		case "menu_zoom":
	
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "help_label_zoom-in", "help_label_zoom-out", "menu_wide", "menu_narrow", "help_label_tall-rows", "help_label_short");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeZoom);
			}
	
		break;
		
		case "word_tip":
			obj_wordTip.wordTipDisplay = !obj_wordTip.wordTipDisplay;			
		break;
		
		case "tab_name_chunk":
			obj_control.hideChunks = !obj_control.hideChunks;
		break;
		
		case "arrheads":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			
			ds_list_add(dropDownOptionList,"menu_all", "menu_track-arrows", "menu_rez-arrows");
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeArrows);
			}
			break;
		
		case "text_dir":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			
			ds_list_add(dropDownOptionList, "menu_left-to-right","menu_right-to-left");
				
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeTextDirection);
			}
		
		break;
	
		default:
		break;
	}


}
