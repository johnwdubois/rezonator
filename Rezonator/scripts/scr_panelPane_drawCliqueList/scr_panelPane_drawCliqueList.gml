// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawCliqueList(){
	


			
	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	
	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;

	var mouseoverScrollBar = point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight);
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);


	// get the clique list & make sure it exists
	var cliqueList = obj_chain.cliqueList;
	if (!scr_isNumericAndExists(cliqueList, ds_type_list)) {
		show_debug_message("scr_panelPane_drawCliqueList ... cliqueList does not exist");
		exit;
	}
	
	var cliqueListSize = ds_list_size(cliqueList);
	scr_surfaceStart();
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	
	global.cliqueMap = global.nodeMap[? "cliqueMap"];
	if(!scr_isNumericAndExists(global.cliqueMap, ds_type_map)){
		scr_surfaceEnd();
		exit;
	}
	
	// loop over cliques
	for (var i = 0; i < cliqueListSize; i++) {
		
		
		// get data for currentClique
		var currentClique = cliqueList[| i];
		var currentCliqueSubMap = global.cliqueMap[? currentClique];
		if (!scr_isNumericAndExists(currentCliqueSubMap, ds_type_map)) {
			continue;
		}
		

		
		var currentCliqueSelected = (functionClique_cliqueSelected == currentClique);
		
		// Get dimensions of rectangle around clique name
		var cliqueRectX1 = x;
		var cliqueRectY1 = y + headerHeight + scrollPlusY + textPlusY - (strHeight / 2);
		var cliqueRectX2 = x + windowWidth;
		var cliqueRectY2 = cliqueRectY1 + strHeight;
		var mouseoverCliqueRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cliqueRectX1, cliqueRectY1, cliqueRectX2, cliqueRectY2) && !mouseoverScrollBar && !scrollBarHolding && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeaderRegion;
		var highlight = mouseoverCliqueRect;
		var textY = floor(mean(cliqueRectY1, cliqueRectY2));
		
		
		// click on clique name
		if (mouseoverCliqueRect) {
			if (mouse_check_button_released(mb_left) && !instance_exists(obj_dropDown)) {
				with (obj_panelPane) functionClique_cliqueSelected = currentClique;
			}
		}
		
		// draw rect
		var rectColor = (currentCliqueSelected) ? global.colorThemeSelected2 : merge_color(global.colorThemeBG, global.colorThemeSelected1, highlight ? 0.8 : 0.4);
		var textColor = (currentCliqueSelected) ? global.colorThemeBG : global.colorThemeText;
		draw_set_color(rectColor);
		draw_rectangle(cliqueRectX1 - clipX, cliqueRectY1 - clipY, cliqueRectX2 - clipX, cliqueRectY2 - clipY, false);
		
		// # column
		draw_set_color(textColor);
		draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
		// name column
		draw_set_color(textColor);
		draw_text(floor(nameColX + textBuffer) - clipX, textY - clipY, string(currentClique));
		
		
		
		// increment plusY
		textPlusY += strHeight;

	}



	scr_scrollBar(cliqueListSize, -1, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	scr_surfaceEnd();
	


	// draw column headers
	var headerPlusX = 0;
	for (var i = 0; i < 2; i++) {
		
		// get column data
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 1) {
			colWidth = windowWidth - nameColX;
			colText = "Name";
		}
		
		// get header coordinates
		var headerRectX1 = x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// draw header rects
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, true);
		
		// draw header text
		var headerTextX = floor(headerRectX1 + textBuffer);
		var headerTextY = floor(mean(headerRectY1, headerRectY2));
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		draw_text(headerTextX, headerTextY, colText);
		

		
		
		headerPlusX += colWidth;
	}



}