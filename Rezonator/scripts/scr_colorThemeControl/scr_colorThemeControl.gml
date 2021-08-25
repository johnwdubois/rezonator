function scr_colorThemeControl() {
	// Change the Rezonator color theme to lightmode/darkmode

	if (global.ctrlHold and keyboard_check_pressed(ord("B"))) {

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
		global.colorThemeNegSpace = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colNegSpace, global.colorTheme);
	
		var layerID = layer_get_id("Background");
		var backID = layer_background_get_id(layerID);
		layer_background_blend(backID, global.colorThemeBG);
	}


}
