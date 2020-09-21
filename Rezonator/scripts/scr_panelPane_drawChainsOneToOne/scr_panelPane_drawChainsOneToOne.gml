// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChainsOneToOne(){
	
	scr_surfaceStart();
	
	
	draw_set_font(global.fontChainList);
	var strHeight = string_height("0") * 1.5;

	// Set text margin area
	var filterRectMargin = 8;
	var filterRectSize = (strHeight / 2) + 5;
	var textMarginLeft = filterRectMargin;

	var textMarginTop = functionChainList_tabHeight;
	var textPlusY = 0;
	var chainNameRectMinusY = 4;

	var focusedElementY = -1;
	var focusedLineNameRectY1 = -1;
	var focusedLineNameRectY2 = -1;
	var xbuffer = (windowWidth / 6);

	var drawDropDowns = false;
	if (!instance_exists(obj_dropDown)) {
		chainTagsHighlightRow = -1;
	}
	
	var headerListSize = 3;
	
	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	
	var chainGridHeight = ds_grid_height(obj_chain.stackChainGrid);
	
	for (var j = 0; j < headerListSize; j++) {
		
		textPlusY = 0;
		drawDropDowns = false;
		
		var colRectX1 = x + (j * (windowWidth / 3));
	    var colRectY1 = y;
	    var colRectX2 = colRectX1 + (windowWidth / 3);
	    var colRectY2 = colRectY1 + windowHeight;
		
		
		draw_set_color(global.colorThemeBG);
	    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);
	    draw_set_color(global.colorThemeBorders);
	    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, true);
		
		
	}
	
	// Create the column headers
	for (var i = 0; i < headerListSize; i++) {
		
		var colRectX1 = x + (i * (windowWidth / 3));
	    var colRectY1 = y;
	    var colRectX2 = colRectX1 + (windowWidth / 3);
		var colRectY2 = colRectY1 + windowHeight;
		var colWidth = colRectX2 - colRectX1;
		var colName = "";
		switch (i) {
			case 0:
				colName = "act";
				break;
			case 1:
				colName = "repair";
				break;
			case 2:
				colName = "act sequence";
				break;
			default:
				break;
		}
		
		draw_set_color(global.colorThemeBorders);
	    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + functionChainList_tabHeight - clipY, true);
	    draw_set_color(global.colorThemeText);
	    draw_set_valign(fa_top);
	    draw_set_font(global.fontPanelTab);
	    draw_text(colRectX1 + 4 - clipX, y - clipY, colName);
		
		
	}
	
	scr_surfaceEnd();

}