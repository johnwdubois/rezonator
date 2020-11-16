function scr_colorThemeGridInit() {
	/*
		scr_colorThemeGridInit();
	
		Last Updated: 2018-09-11
	
		Called from: obj_openingScreen
	
		Purpose: creates color theme grid and populates it with default values
	
		Mechanism: GM grid functions
	*/
	global.colorTheme = 0;

	// columns = Color sections
	// rows = themes
	global.colorThemeGridWidth = 9;
	global.colorThemeGrid_colBG = 0;
	global.colorThemeGrid_colText = 1;
	global.colorThemeGrid_colSelected1 = 2;
	global.colorThemeGrid_colSelected2 = 3;
	global.colorThemeGrid_colBorders = 4;
	global.colorThemeGrid_colPaneBG = 5;
	global.colorThemeGrid_colOutOfBounds = 6;
	global.colorThemeGrid_colHighlight = 7;
	global.colorThemeGrid_colNegSpace = 8;
	global.colorThemeGrid = ds_grid_create(global.colorThemeGridWidth, 2);

	// light theme
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colBG, 0, c_white);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colText, 0, c_black);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colSelected1, 0, c_ltgray);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colSelected2, 0, c_gray);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colBorders, 0, c_black);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colPaneBG, 0, c_white);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colOutOfBounds, 0, c_ltgray);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colHighlight, 0, c_green);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colNegSpace, 0, make_color_rgb(234,234,234));
	
	// dark theme
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colBG, 1, make_color_hsv(0, 0, 40));
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colText, 1, c_white);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colSelected1, 1, c_gray);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colSelected2, 1, c_ltgray);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colBorders, 1, c_green);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colPaneBG, 1, make_color_hsv(0, 0, 40));
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colOutOfBounds, 1, c_black);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colHighlight, 1, c_green);
	ds_grid_set(global.colorThemeGrid, global.colorThemeGrid_colNegSpace, 1, make_color_rgb(20,20,20));


	global.colorThemeBG = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colBG, global.colorTheme);
	global.colorThemeText = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colText, global.colorTheme);
	global.colorThemeSelected1 = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colSelected1, global.colorTheme);
	global.colorThemeSelected2 = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colSelected2, global.colorTheme);
	global.colorThemeBorders = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colBorders, global.colorTheme);
	global.colorThemePaneBG = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colPaneBG, global.colorTheme);
	global.colorThemeOutOfBounds = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colOutOfBounds, global.colorTheme);
	global.colorThemeHighlight = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colHighlight, global.colorTheme);
	global.colorThemeNegSpace = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colNegSpace, global.colorTheme);
	

}
