function scr_panelPane_drawClique() {
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

	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_searchPaneBold);

	draw_line(x, y + textMarginTop + 12, x + windowWidth, y + textMarginTop + 12);
	draw_text(x + textMarginLeft, y + textMarginTop, "Clique");

	draw_set_font(fnt_searchPane);

	var textPlusY = 0;
	var cliqueGridHeight = ds_grid_height(obj_chain.cliqueGrid);
	for (var i = 0; i < cliqueGridHeight; i++)
	{
		var textX = x + textMarginLeft;
		var textY = y + (textMarginTop * 2) + textPlusY;
	
		var cliqueName = string(ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colName, i));
	

		textPlusY += string_height(cliqueName);
	
		var textRectX1 = textX;
		var textRectY1 = textY - (string_height(cliqueName) / 2);
		var textRectX2 = textX + string_width(cliqueName);
		var textRectY2 = textRectY1 + string_height(cliqueName);
	
		if (point_in_rectangle(mouse_x, mouse_y, textRectX1, textRectY1, textRectX2, textRectY2))
		{
			draw_set_alpha(1);
			draw_set_color(c_ltgray);
			draw_rectangle(textRectX1, textRectY1, textRectX2, textRectY2, false);
		}
	
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_text(textX, textY, cliqueName);
	}


}
