// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawTree1ToMany(){
	
	ds_list_clear(obj_control.inRectEntryIDList);

	var mouseOverEntryID = "";
	// get tree submap, make sure it exists
	var treeSubMap = global.treeMap[? functionTree_treeSelected];
	if (!scr_isNumericAndExists(treeSubMap, ds_type_map)) exit;
	var setIDList = treeSubMap[? "setIDList"];
	if (!scr_isNumericAndExists(setIDList, ds_type_list)) exit;
	var setIDListSize = ds_list_size(setIDList);
	
	
	// draw light BG rect
	var strHeight = string_height("0") * 2.5;
	var headerHeight = functionTabs_tabHeight;
	var topBkgColor = merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.4);
	draw_set_color(topBkgColor);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight - strHeight, false);
	



	// draw line for leaf level
	var rootY = floor(mean(y, y + strHeight));
	var leafY = floor(y + windowHeight - strHeight);
	var leafTextY = floor(mean(leafY, y + windowHeight));
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	
	
	// draw rectangle dividing numbers from text
	var spaceWidth = string_width(" ");
	var originalPlusX = string_width("Leaf") + (spaceWidth * 5)
	var plusX = originalPlusX;
	draw_set_color(topBkgColor);
	draw_rectangle(x, y, x + plusX, leafY, false);
	
	draw_set_color(global.colorThemeBorders);
	draw_line(x, y, x, y + headerHeight);

	

	functionTree_treeMouseoverLinkArea = point_in_rectangle(mouse_x, mouse_y, x + originalPlusX, y, x + windowWidth - global.scrollBarWidth, leafY);

	

	scr_surfaceStart();
	
	var currentScrollPlusY = scrollPlusY-16;
	
	var maxLevel = -1;
	if (ds_map_exists(treeSubMap, "maxLevel")) {
		maxLevel = treeSubMap[?"maxLevel"];
	}
		

	draw_set_halign(fa_left);
	

	
	

	
	// loop over entries, draw each entry at its respective row (level)
	for (var i = 0; i < setIDListSize; i++) {
		
		// get current entry and all its goodies
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.treeMap[? currentEntry];
		var tokenList = currentEntrySubMap[? "tokenList"];
		var tokenListSize = ds_list_size(tokenList);
		var currentDisplayToken = "";
		for(var j = 0; j < tokenListSize; j ++){
			var currentToken = tokenList[|j];
			var currentTokenSubMap = global.nodeMap[? currentToken];
			var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
			currentDisplayToken += (" " + string(currentTokenTagMap[? global.displayTokenField]));
		}
		var currentLevel = currentEntrySubMap[? "level"];
		if (currentLevel < 0) {
			plusX += string_width(currentDisplayToken) + (spaceWidth * 8);
			continue;
		}
		maxLevel = max(maxLevel, currentLevel);
		
		
		// draw entry at its level
		var currentEntryY = rootY + (strHeight * currentLevel);
		
		var strWidth = string_width(currentDisplayToken);
		var realStrheight = string_height(currentDisplayToken);
		
		//get entry box demensions
		var boxWidth = string_width(currentDisplayToken) + (spaceWidth * 8);
		var tokenX1 = x + plusX + scrollPlusX;
		var tokenY1 = currentEntryY - realStrheight/1.8 + currentScrollPlusY;
		var tokenX2 = tokenX1 + boxWidth;
		var tokenY2 = currentEntryY + realStrheight/1.8 + currentScrollPlusY;
		
		
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_roundrect_ext(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, 20,20, false);
		if(obj_chain.currentFocusedEntryID == currentEntry){
			draw_set_color(global.colorThemeRezPink);
			scr_drawRectWidth(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, 2,true);
		}
		
		// save pixel values to map for drawing links
		currentEntrySubMap[?"entryX1"] = tokenX1;
		currentEntrySubMap[?"entryY1"] = tokenY1;
		currentEntrySubMap[?"entryX2"] = tokenX2;
		currentEntrySubMap[?"entryY2"] = tokenY2;
		
		//mouse over for entry
		var mouseOverEntry = (point_in_rectangle(mouse_x, mouse_y,tokenX1,tokenY1,tokenX2,tokenY2) && mouseOverEntryID == "") && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		if(mouseOverEntry){
			
			mouseOverEntryID = currentEntry;
			
			draw_set_alpha(1);
			draw_set_color(global.colorThemeSelected1);
			draw_roundrect_ext(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, 20,20,false);
			
			if(obj_chain.currentFocusedEntryID == currentEntry){
				draw_set_color(global.colorThemeRezPink);
				scr_drawRectWidth(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, 2,true);
			}
			
			// click to focus entry
			if(device_mouse_check_button_released(0,mb_left) && !instance_exists(obj_dropDown)){
				var isCycle = false;
				//allow clicking on root level
				if(currentLevel == 0) {
					if(obj_chain.currentFocusedEntryID != ""){
						if(obj_chain.currentFocusedEntryID != currentEntry){
							isCycle = scr_checkTreeCycle(currentEntry);
							if(!isCycle){
								scr_createTreeLink(currentEntry);
								obj_chain.currentFocusedEntryID = currentEntry;
								
								scr_treeRefresh(treeSubMap);
							}
							else{
								obj_chain.currentFocusedEntryID = currentEntry;
							}
						}
						else{
							obj_chain.currentFocusedEntryID = currentEntry;
						}
					}
					else{
						obj_chain.currentFocusedEntryID = currentEntry;
					}
				}
				else{
					obj_chain.currentFocusedEntryID = currentEntry;
				}
				
				draw_set_color(global.colorThemeBorders);
				scr_drawRectWidth(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, 2,true);
				
			}
		}
		
		// draw text of current entry
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_center);
		draw_text(floor(mean(tokenX1,tokenX2)) - clipX, currentEntryY - clipY + currentScrollPlusY, currentDisplayToken);

		plusX += boxWidth;
	}

	scr_drawTreeLinks();
	
		
	if(functionTree_treeLinkMouseover == "" && mouseOverEntryID == "" && functionTree_treeMouseoverLinkArea){
		if(device_mouse_check_button_released(0,mb_left) && !instance_exists(obj_dropDown)){
			obj_chain.currentFocusedEntryID = "";
		}
	}
	
	treeSubMap[?"maxLevel"] = maxLevel;

	// draw horizontal lines for each row
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	for (var i = 0; i <= maxLevel; i++) {
		var levelY = rootY + (strHeight * i);
		var lineY = levelY  - (strHeight / 2) + currentScrollPlusY;
		//draw_line(x - clipX, lineY - clipY, x + windowWidth - clipX, lineY - clipY);
	}
	
	
	draw_set_alpha(1);	
	draw_set_color(topBkgColor);
	draw_rectangle(x - clipX, y - clipY, x + originalPlusX - clipX, y + windowHeight - clipY, false);
	// draw numbers for each level		
	draw_set_halign(fa_center);
	for (var i = 0; i <= maxLevel; i++) {
		
		// draw number text
		var levelY = rootY + (strHeight * i);
		draw_set_color(global.colorThemeText);
		draw_text(floor(mean(x, x + originalPlusX)) - clipX, floor(levelY + currentScrollPlusY) - clipY, string(i));
		
		// draw horizontal line for each row
		draw_set_color(global.colorThemeBG);
		var lineY = levelY  - (strHeight / 2) + currentScrollPlusY;
		//draw_line(x - clipX, lineY - clipY, x + originalPlusX - clipX, lineY - clipY);
	}
	
	
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x- clipX, leafY - clipY, x + originalPlusX- clipX, y + windowHeight - clipY, false);

	// draw leaf row
	plusX = originalPlusX;
	var maxPlusX = plusX;
	for (var i = 0; i < setIDListSize; i++) {
		
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.treeMap[? currentEntry];
		var tokenList = currentEntrySubMap[? "tokenList"];
		var tokenListSize = ds_list_size(tokenList);
		currentDisplayToken = "";
		for(var j = 0; j < tokenListSize; j ++){
			var currentToken = tokenList[|j];
			var currentTokenSubMap = global.nodeMap[? currentToken];
			var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
			currentDisplayToken += (" " + string(currentTokenTagMap[? global.displayTokenField]));
		}
	
		//get entry box demensions
		var boxWidth = string_width(currentDisplayToken) + (spaceWidth * 8);
		
		var tokenX1 = x + plusX + scrollPlusX;
		var tokenY1 = leafY;
		var tokenX2 = tokenX1 + boxWidth;
		var tokenY2 = y + windowHeight;
		
		
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, false);
		

		
		//mouse over for entry
		var mouseOverEntry = (point_in_rectangle(mouse_x, mouse_y,tokenX1,tokenY1,tokenX2,tokenY2) && mouseOverEntryID == "" && currentEntrySubMap[?"level"] == -1)
		
		// check if this entry should be added to entryRectList
		var mouseRectExists = (obj_control.mouseHoldRectX1 >= 10 && obj_control.mouseHoldRectY1 >= 0);
		var inMouseRect = false;
		if (mouseRectExists) {
			inMouseRect = (rectangle_in_rectangle(tokenX1, tokenY1, tokenX2, tokenY2, min(mouse_x, obj_control.mouseHoldRectX1), min(mouse_y, obj_control.mouseHoldRectY1), max(mouse_x, obj_control.mouseHoldRectX1), max(mouse_y, obj_control.mouseHoldRectY1))
			&& (mouse_x > obj_control.mouseHoldRectX1 + 5 || mouse_x < obj_control.mouseHoldRectX1 - 5));
			if (mouseRectExists && inMouseRect) {
				scr_addToListOnce(obj_control.inRectEntryIDList, currentEntry);

			}
		}

		if(mouseOverEntry){
			
			mouseOverEntryID = currentEntry;
			draw_set_alpha(1);
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, false);
			

			
			
			// click on entry
			if(device_mouse_check_button_released(0,mb_left) && !instance_exists(obj_dropDown) && ds_list_size(obj_control.entryRectListCopy) <= 1 && !functionTree_treeMouseoverLinkArea ){
			
				if(obj_chain.currentFocusedEntryID == ""){
					currentEntrySubMap[?"level"] = 0;
				}
				else{
					if(obj_chain.currentFocusedEntryID != currentEntry){
						if(currentEntrySubMap[?"level"] == -1){
							scr_createTreeLink(currentEntry);
							var nextLevelHeight = (currentEntrySubMap[?"level"] - 1) * strHeight;
							
							
							show_debug_message(nextLevelHeight)
							currentScrollPlusY =nextLevelHeight;
							
							show_debug_message("click on leaf ... setting scroll from " + string(scrollPlusYDest) + " to " + string(nextLevelHeight));
							scrollPlusYDest = -nextLevelHeight;
							scrollPlusY = -nextLevelHeight;

							
						}
					}
				}
				obj_chain.currentFocusedEntryID = currentEntry;
			}
		}
		
	
		draw_set_color(global.colorThemeText);
		draw_set_alpha((currentEntrySubMap[?"level"] >= 0) ? 0.5 : 1);
		draw_set_halign(fa_center);
		draw_text(floor(mean(tokenX1, tokenX2)) - clipX, leafTextY - clipY, currentDisplayToken);
		
		// draw vertical line for each column
		draw_set_color(global.colorThemeBG);
		draw_set_alpha(0.5);
		var lineX = x + plusX + scrollPlusX;
		//draw_line(lineX - clipX, y - clipY, lineX - clipX, y + windowHeight - clipY);
		
		plusX += boxWidth;
	}
	maxPlusX = plusX;
	plusX = originalPlusX;


	
	scr_scrollBar(maxLevel + 2, -1, strHeight, 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight - strHeight);
	scr_surfaceEnd();
	

	draw_line(x + originalPlusX + 1, y, x + originalPlusX + 1, leafY);
	// is user releases mousedrag, do something!
	if (mouse_check_button_released(mb_left) && !instance_exists(obj_dialogueBox)) {
		show_debug_message(string(ds_list_size(obj_control.entryRectListCopy))+ "   ON REALEASE");
		if (ds_list_size(obj_control.entryRectListCopy) > 1) {
			scr_combineLeafs(obj_control.entryRectListCopy);
			//scr_createTreeLink(obj_control.entryRectListCopy[|0]);
		}
		
		ds_list_clear(obj_control.entryRectListCopy);
		// reset mouserect variables
		obj_control.mouseHoldRectX1 = -1;
		obj_control.mouseHoldRectY1 = -1;
	}
	
	ds_list_copy(obj_control.entryRectListCopy, obj_control.inRectEntryIDList);
	
	
	// if user clicks, save the position of their mouse
	var canMakeMouseRect = obj_control.mouseoverPanelPane &&  mouse_check_button_pressed(mb_left) && !obj_control.mouseoverScrollBar;
	if (canMakeMouseRect) {
		obj_control.mouseHoldRectX1 = mouse_x;
		obj_control.mouseHoldRectY1 = mouse_y;
	}
	
	// if user is making a mouse rect, let's draw it
	if (obj_control.mouseHoldRectX1 >= 0 && obj_control.mouseHoldRectY1 >= 0) {
		
		// draw mouse rect border
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(0.7);
		scr_drawRectWidth(obj_control.mouseHoldRectX1, obj_control.mouseHoldRectY1, mouse_x, mouse_y, 2, false);
		draw_set_alpha(1);
	}
	
	//draw_set_color(global.colorThemeBorders);
	//draw_line(x, leafY, x + windowWidth, leafY);
	
	// draw "Leaf" text
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeBG);
	//draw_text(floor(x + spaceWidth), leafTextY, "Leaf");
	


	scr_scrollMouseControls(strHeight);
	
	if (clickedIn) {
		if (keyboard_check(vk_left)) {
			scrollPlusX += 8;
		}
		if (keyboard_check(vk_right)) {
			scrollPlusX -= 8;
		}
	}
	scrollPlusX = clamp(scrollPlusX, -maxPlusX + windowWidth, 0);
	

	
	if(keyboard_check_released(vk_escape)){
		obj_chain.currentFocusedEntryID = "";
	}
}