// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawShow1toMany(){
	
	// Set text margins
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.7;
	var seqColX = nameColX + nameColWidth;
	var textBuffer = 8;
	var textPlusY = 0;
	var headerHeight = functionTabs_tabHeight;
	var strHeight = string_height("0");
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var stackChainList = ds_map_find_value(global.nodeMap, "stackChainList");
	
	
	// get showID and look it up in nodeMap
	var showID = functionChainContents_showID;
	var showSubMap = ds_map_find_value(global.nodeMap, showID);
	var setList = -1;
	var setListSize = 0;
	
	if (is_numeric(showSubMap)) {
		if (ds_exists(showSubMap, ds_type_map)) {
			
			// get setList from show & make sure it exists
			setList = ds_map_find_value(showSubMap, "setList");
			if (is_numeric(setList)) {
				if (ds_exists(setList, ds_type_list)) {
					
					// loop over setList and draw a row for each chain
					setListSize = ds_list_size(setList);
					for (var i = 0; i < setListSize; i++) {
		
						// get currentChain & make sure it exists
						var currentChain = ds_list_find_value(setList, i);
						var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
						if (!is_numeric(currentChainSubMap)) continue;
						if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
						var currentChainName = ds_map_find_value(currentChainSubMap, "chainName");
						var currentChainColor = ds_map_find_value(currentChainSubMap, "chainColor")
						
						// get coordinates of rectangle around chain name
						var chainRectX1 = x;
						var chainRectY1 = y + headerHeight + textPlusY - (strHeight / 2) + scrollPlusY;
						var chainRectX2 = x + windowWidth - global.scrollBarWidth;
						var chainRectY2 = chainRectY1 + strHeight;
						var mouseoverChainRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, chainRectX1, chainRectY1, chainRectX2, chainRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
						
						// draw chain option rect
						draw_set_color(merge_color(currentChainColor, global.colorThemeBG, 0.65));
						draw_rectangle(chainRectX1 - clipX, chainRectY1 - clipY, chainRectX2 - clipX, chainRectY2 - clipY, false);
						
						// draw chain name
						draw_set_color(global.colorThemeText);
						draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(chainRectY1, chainRectY2)) - clipY, string(currentChainName));
						
						textPlusY += strHeight;
					}
					
					
					if (ds_list_size(stackChainList) > 0) {
					
						// put "Add to Show" option at bottom of list
						var addToShowRectX1 = x;
						var addToShowRectY1 = y + headerHeight + textPlusY - (strHeight / 2) + scrollPlusY;
						var addToShowRectX2 = x + windowWidth;
						var addToShowRectY2 = addToShowRectY1 + strHeight;
						var mouseoverAddToShow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, addToShowRectX1, addToShowRectY1, addToShowRectX2, addToShowRectY2);
						draw_set_color(merge_color(c_green, global.colorThemeSelected1, mouseoverAddToShow ? 0.4 : 0.6));
						draw_rectangle(addToShowRectX1 - clipX, addToShowRectY1 - clipY, addToShowRectX2 - clipX, addToShowRectY2 - clipY, false);
						draw_set_color(global.colorThemeText);
						draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(addToShowRectY1, addToShowRectY2)) - clipY, "Add to show...");
	
						// click "add to show" option
						if (mouseoverAddToShow && mouse_check_button_released(mb_left)) {
		
							var addToShowList = ds_list_create();
							ds_list_copy(addToShowList, stackChainList);
							scr_createDropDown(nameColX, addToShowRectY2, addToShowList, global.optionListTypeAddToShow);
						}
					}
				}
			}
		}
	}
	
	

	
	
	
	// scrollbar
	var scrollBarListSize = 0;
	if (is_numeric(setList)) {
		if (ds_exists(setList, ds_type_list)) {
			scrollBarListSize = setListSize + 1;
		}
	}
	scr_scrollBar(scrollBarListSize, -1, strHeight, headerHeight,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);

	
	
	

	
	
	// headers!!!
	for (var i = 0; i < 3; i++) {
		
		// get coordinates for header
		var headerRectX1 = 0;
		var headerRectY1 = y;
		var headerRectX2 = 0;
		var headerRectY2 = headerRectY1 + headerHeight;
		if (i == 0) {
			headerRectX1 = numColX;
			headerRectX2 = numColX + numColWidth;
		}
		else if (i == 1) {
			headerRectX1 = nameColX;
			headerRectX2 = nameColX + nameColWidth;
		}
		else if (i == 2) {
			headerRectX1 = seqColX;
			headerRectX2 = x + windowWidth;
		}
		
		// draw header rect
		draw_set_color(global.colorThemeSelected2);
		draw_rectangle(headerRectX1 - clipX, headerRectY1 - clipY, headerRectX2 - clipX, headerRectY2 - clipY, false);
		
		// header text: # column
		draw_set_color(global.colorThemeBG);
		draw_text(floor(numColX + textBuffer) - clipX, floor(mean(headerRectY1, headerRectY2)) - clipY, "#");
		
		// header text: name column
		draw_set_color(global.colorThemeBG);
		draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(headerRectY1, headerRectY2)) - clipY, "Stack");
		
		// header text: seq column
		draw_set_color(global.colorThemeBG);
		draw_text(floor(seqColX + textBuffer) - clipX, floor(mean(headerRectY1, headerRectY2)) - clipY, "Seq");
		
		// dividing lines
		if (i > 0) {
			draw_set_color(global.colorThemeBG);
			draw_line(headerRectX1 - clipX, y - clipY, headerRectX1 - clipX, y + windowHeight - clipY);
		}
		
	}
	
}