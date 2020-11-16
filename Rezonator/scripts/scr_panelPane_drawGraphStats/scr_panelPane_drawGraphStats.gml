function scr_panelPane_drawGraphStats() {
	/*
		scr_panelPane_drawGraphStats();
	
		Last Updated: 2019-04-23
	
		Called from: obj_panelPane
	
		Purpose: Create and populate the Graph Stats window
	
		Mechanism: 
	
		Author: Georgio Klironomos
	*/


	var textMarginLeft = 10;
	var textMarginTop = 20;

	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_searchPaneBold);

	draw_line(x, y + textMarginTop + 12, x + windowWidth, y + textMarginTop + 12);
	draw_text(x + textMarginLeft, y + textMarginTop, scr_get_translation("label_graph_stats"));

	draw_set_font(fnt_searchPane);

	var textPlusY = 0;

		var textX = x + textMarginLeft;
		var textY = y + (textMarginTop * 2) + textPlusY;
	
		if(obj_control.hoverWordID > 0) {
			var hoveredWordUnitID = obj_control.hoverWordID - 1;
		var hoveredWord = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, hoveredWordUnitID );
		var hoveredWordVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, hoveredWordUnitID );
	
		textPlusY += string_height(hoveredWord);
	
		var textRectX1 = textX;
		var textRectY1 = textY - (string_height(hoveredWord) / 2);
		var textRectX2 = textX + string_width(hoveredWord);
		var textRectY2 = textRectY1 + string_height(hoveredWord);
	
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_text(textX, textY, scr_get_translation("label_word") + hoveredWord);
	
		textX = x + textMarginLeft;
		 textY = y + (textMarginTop * 2) + textPlusY;
	
		textPlusY += string_height(hoveredWord);
	
		 textRectX1 = textX;
		 textRectY1 = textY - (string_height(hoveredWord) / 2);
		 textRectX2 = textX + string_width(hoveredWord);
		 textRectY2 = textRectY1 + string_height(hoveredWord);
	
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_text(textX, textY, scr_get_translation("label_void") + string(hoveredWordVoid));
		}
	
	
	/*for (var i = 0; i < ds_grid_height(obj_chain.cliqueGrid); i++)
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
	}*/



}
