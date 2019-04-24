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
draw_text(x + textMarginLeft, y + textMarginTop, "Graph Stats");

draw_set_font(fnt_searchPane);

var textPlusY = 0;
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
