var optionSelected = argument0;

switch (optionSelected)
{
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
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 13;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	
	break;
	case "Mute":
		show_message("Coming Soon");
	break;
	case "Author":
		show_message("Coming Soon");
	break;
	default:
	break;
	
}