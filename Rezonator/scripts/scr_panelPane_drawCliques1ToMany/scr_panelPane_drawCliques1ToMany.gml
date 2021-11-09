// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawCliques1ToMany(){
	
	var headerHeight = functionTabs_tabHeight;
	var textBuffer = 8;
	var textPlusY = 0;
	var textAdjustY = 0;
	var strHeight = string_height("0") * 1.5;
	
	
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var textColX = numColX + numColWidth;
	var textColWidth = windowWidth * 0.3;
	var chainOrderColX = textColX + textColWidth;
	
	var mouseoverScrollBar = point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight);
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	
	if (!scr_isNumericAndExists(global.cliqueMap, ds_type_map)) exit;

	
	// get the clique list & make sure it exists
	var cliqueSubMap = global.cliqueMap[? obj_panelPane.functionClique_cliqueSelected];
	if (scr_isNumericAndExists(cliqueSubMap, ds_type_map)) {

		scr_surfaceStart();
	
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_alpha(1);
		
		var list = cliqueSubMap[? (cliquePaneSwitchButton == "option_chain") ? "chainList" : "unitList"];
		if (scr_isNumericAndExists(list, ds_type_list)) {
			var listSize = ds_list_size(list);
			
			// loop over chains in clique
			for (var i = 0; i < listSize; i++) {
				
				// don't bother drawing this stuff if it won't be on screen
				if (y + headerHeight + scrollPlusY + textPlusY < y - strHeight
				or y + headerHeight + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
					textPlusY += strHeight;
					continue;
				}
				
				// get data for currentSearch
				var currentItem = list[| i];
				var currentItemNum = "";
				var currentItemText = "";
				var currentChainOrderListNames = ds_list_create();
				var currentItemSubMap = global.nodeMap[? currentItem];
				var rectColor = global.colorThemeBG;
				if (scr_isNumericAndExists(currentItemSubMap, ds_type_map)) {
					if (cliquePaneSwitchButton == "option_chain") {
						currentItemNum = string(i + 1);
						currentItemText = string(currentItemSubMap[? "name"]);
						rectColor = currentItemSubMap[? "chainColor"];
						var currentChainOrderList = cliqueSubMap[? currentItem];
						var currentChainOrderListSize = ds_list_size(currentChainOrderList);
						for (var j = 0; j < currentChainOrderListSize; j++) {
							var currentChain = currentChainOrderList[| j];
							var currentChainSubMap = global.nodeMap[? currentChain];
							ds_list_add(currentChainOrderListNames, currentChainSubMap[? "name"]);
						}
					}
					else {
						currentItemNum = string(currentItemSubMap[? "unitSeq"]);
						currentItemText = scr_getUnitText(currentItemSubMap);
					}
				}
				
				
				
				// Get dimensions of rectangle around search name
				var cliqueRectX1 = x;
				var cliqueRectY1 = y + headerHeight + scrollPlusY + textPlusY - (strHeight / 2);
				var cliqueRectX2 = x + windowWidth;
				var cliqueRectY2 = cliqueRectY1 + strHeight;
				var mouseoverSearchRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cliqueRectX1, cliqueRectY1, cliqueRectX2, cliqueRectY2) && !mouseoverScrollBar && !scrollBarHolding && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeaderRegion;
				var highlight = (mouseoverSearchRect);
				var textY = floor(mean(cliqueRectY1, cliqueRectY2));
				
				// draw rect
				var textColor = global.colorThemeText;
				if (cliquePaneSwitchButton == "option_chain") rectColor = merge_color(rectColor, global.colorThemeBG, highlight ? 0.6 : 0.8);
				else rectColor = merge_color(global.colorThemeBG, global.colorThemeSelected1, highlight ? 0.8 : 0.4);
				draw_set_color(rectColor);
				draw_rectangle(cliqueRectX1 - clipX, cliqueRectY1 - clipY, cliqueRectX2 - clipX, cliqueRectY2 - clipY, false);
				
				// # column
				draw_set_color(textColor);
				draw_text(numColX + textBuffer - clipX, textY - clipY, currentItemNum);
				
				// text column
				scr_adaptFont(currentItemText, "M");
				draw_text(textColX + textBuffer - clipX, textY - clipY, currentItemText);
				
				// chain order column
				var chainOrderListStr = scr_getStringOfList(currentChainOrderListNames);
				scr_adaptFont(chainOrderListStr, "M");
				draw_text(chainOrderColX + textBuffer - clipX, textY - clipY, chainOrderListStr);
				ds_list_destroy(currentChainOrderListNames);
				
				// increment plusY
				textPlusY += strHeight;
			}
		}
		
		scr_scrollBar(listSize, -1, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
		scr_scrollMouseControls(strHeight);
		scr_surfaceEnd();
		
	}
	
	
	
	var headerPlusX = 0;
	var colAmount = 3;
	draw_set_halign(fa_left);
	for (var i = 0; i < colAmount; i++) {
		var colWidth = 0;
		var colName = "";
		// get coordinates for header rect
		if(i == 0){
			colWidth = numColWidth;
			colName = "#";
		}
		else if (i == 1) {
			colWidth = textColWidth;
			colName = (cliquePaneSwitchButton == "option_chain") ? "option_chain" : "tag_text";
		}
		else if (i == 2) {
			colWidth = x + windowWidth - chainOrderColX;
			colName = (cliquePaneSwitchButton == "option_chain") ? "Chain Order" : "";
		}
		colName = scr_get_translation(colName);
		
		var headerRectX1 = x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
			
		// get coordinates for header text
		var headerTextX = floor(headerRectX1 + textBuffer);
		var headerTextY = floor(y + (headerHeight / 2));
	

		// make headers not overlap with each other
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		
		
		// draw header name
		draw_set_color(global.colorThemeText);
		draw_set_valign(fa_middle);


		scr_adaptFont(colName, "M");
		draw_text(headerTextX, headerTextY, colName);

		draw_set_color(global.colorThemeBorders);
		if(i != 0) draw_line_width(headerRectX1, y, headerRectX1, y + windowHeight, 1);
		
		headerPlusX += colWidth;
	}
	
	
	// draw horizontal line between headers and contents
	draw_set_color(global.colorThemeBorders);
	draw_line(x, y + headerHeight, x + windowWidth, y + headerHeight);

}