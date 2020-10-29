function scr_panelPane_drawSearch() {
	/*
		scr_panelPane_drawchainContentsLoop();
	
		Last Updated: 2018-07-12
	
		Called from: obj_panelPane
	
		Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	
		Mechanism: loop through the IDList of the focused chain and gather information from corresponding grids
	
		Author: Terry DuBois
	*/

	var textMarginLeft = 10;
	var textMarginTop = 20;

	var iconX = x + (windowWidth / 2);
	var iconY = y + (windowHeight / 2);

	var mouseover = false;
	if (point_in_rectangle(mouse_x, mouse_y, x, y + textMarginTop + 12, x + windowWidth, y + windowHeight) and not instance_exists(obj_dropDown))
	{
		mouseover = true;
	}

	if (mouseover or obj_control.searchGridActive)
	{
		draw_set_alpha(0.5);
		draw_set_color(c_ltgray);
		draw_rectangle(x, y + textMarginTop + 12, x + windowWidth, y + windowHeight, false);
	}

	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_searchPaneBold);

	draw_line(x, y + textMarginTop + 12, x + windowWidth, y + textMarginTop + 12);
	draw_text(x + textMarginLeft, y + textMarginTop, "Search");

	if (obj_control.searchGridActive)
	{
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_set_halign(fa_left);
		draw_set_font(fnt_searchPane);
	
		var matchCount = ds_grid_height(obj_control.searchGrid);
	
		draw_text(x + textMarginLeft, y + windowHeight - textMarginTop, string(matchCount) + " matches");
	}

	if (mouseover and device_mouse_check_button_released(0, mb_left))
	{
		with (obj_control)
		{
			if (searchGridActive)
			{
				searchGridActive = false;
				filterGridActive = false;
				currentActiveLineGrid = lineGrid;
				obj_toolPane.currentMode = obj_toolPane.setModeMain;
				wordLeftMarginDest = 170;
				obj_control.justifyLoop = -1;
				scr_justifyWords();
			}
			else
			{
				scr_searchForWord();
			}
		}
	}

	draw_sprite_ext(spr_search, 0, iconX, iconY, 1, 1, 0, c_white, 1);


}
