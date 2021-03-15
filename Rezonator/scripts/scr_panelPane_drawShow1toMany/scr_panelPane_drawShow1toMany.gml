// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawShow1toMany(){
	
	// draw BG rect
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x - clipX, y - clipY, x + windowWidth - clipX, y + windowHeight - clipY, false);
	
	// Set text margins
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.7;
	var seqColX = nameColX + nameColWidth;
	var textBuffer = 8;
	var textPlusY = 0;
	var headerHeight = functionTabs_tabHeight;
	var strHeight = string_height("0") * 1.5;
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var stackChainList = ds_map_find_value(global.nodeMap, "stackChainList");
	
	
	// get showID and look it up in nodeMap
	var showID = functionChainContents_showID;
	var showSubMap = ds_map_find_value(global.nodeMap, showID);
	var setList = -1;
	var setListSize = 0;
	
	if (ds_list_size(stackChainList) > 0) {
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
							var chainRectX2 = x + windowWidth;
							var chainRectY2 = chainRectY1 + strHeight;
							var mouseoverChainRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, chainRectX1, chainRectY1, chainRectX2, chainRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
						
							// draw chain option rect
							draw_set_color(merge_color(currentChainColor, global.colorThemeBG, 0.65));
							//draw_set_color(merge_color(global.colorThemeBG, global.colorThemeSelected1, 0.8));
							draw_rectangle(chainRectX1 - clipX, chainRectY1 - clipY, chainRectX2 - clipX, chainRectY2 - clipY, false);
							
							// draw chain #
							draw_set_color(global.colorThemeText);
							draw_text(floor(numColX + textBuffer) - clipX, floor(mean(chainRectY1, chainRectY2)) - clipY, string(i + 1));
						
							// draw chain name
							draw_set_color(global.colorThemeText);
							draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(chainRectY1, chainRectY2)) - clipY, string(currentChainName));
							
							// sequence arrows
							var showSeqUpArrow = (i > 0);
							var showSeqDownArrow = (i < setListSize - 1);
							var seqArrowX = mean(seqColX, x + windowWidth);
							var seqUpArrowY = chainRectY1 + (strHeight * 0.3);
							var seqDownArrowY = chainRectY1 + (strHeight * 0.7);
							var mouseoverSeqUpArrow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, seqColX, chainRectY1, x + windowWidth - global.scrollBarWidth, mean(chainRectY1, chainRectY2)) && showSeqUpArrow && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
							var mouseoverSeqDownArrow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, seqColX, mean(chainRectY1, chainRectY2), x + windowWidth - global.scrollBarWidth, chainRectY2) && showSeqDownArrow && !mouseoverSeqUpArrow && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
							
							// mouseover & click on sequence arrows
							if (mouseoverSeqUpArrow) {
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(seqColX - clipX, chainRectY1 - clipY, x + windowWidth - clipX, mean(chainRectY1, chainRectY2) - clipY, false);
								if (mouse_check_button_released(mb_left)) {
									scr_listSwap(setList, i - 1, i);
								}
							}
							else if (mouseoverSeqDownArrow) {
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(seqColX - clipX, mean(chainRectY1, chainRectY2) - clipY, x + windowWidth - clipX, chainRectY2 - clipY, false);
								if (mouse_check_button_released(mb_left)) {
									scr_listSwap(setList, i, i + 1);
								}
							}
							if (showSeqUpArrow) draw_sprite_ext(spr_ascend, 0, seqArrowX - clipX, seqUpArrowY - clipY, 1, 1, 0, global.colorThemeText, 1);
							if (showSeqDownArrow) draw_sprite_ext(spr_ascend, 0, seqArrowX - clipX, seqDownArrowY - clipY, 1, 1, 180, global.colorThemeText, 1);
							
							// draw horizontal dividing line
							draw_set_color(global.colorThemeBG);
							draw_line(chainRectX1 - clipX, chainRectY2 - 1 - clipY, chainRectX2 - clipX, chainRectY2 - 1 - clipY);
						
							textPlusY += strHeight;
						}
					
					
						if (ds_list_size(stackChainList) > 0) {
					
							// put "Add to Show" option at bottom of list
							var addToShowRectX1 = x;
							var addToShowRectY1 = y + headerHeight + textPlusY - (strHeight / 2) + scrollPlusY;
							var addToShowRectX2 = x + windowWidth;
							var addToShowRectY2 = addToShowRectY1 + strHeight;
							var mouseoverAddToShow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, addToShowRectX1, addToShowRectY1, addToShowRectX2, addToShowRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
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
	}
	else {
		
		// if there's no stacks, show a message to user
		draw_set_color(merge_color(global.colorThemeText, global.colorThemeBG, 0.5));
		var noStackTextY = floor(y + headerHeight + (strHeight / 2));
		draw_text(nameColX + textBuffer - clipX, noStackTextY - clipY, "No stacks to show!");
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
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
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