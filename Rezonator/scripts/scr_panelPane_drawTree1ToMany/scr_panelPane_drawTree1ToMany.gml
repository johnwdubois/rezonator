// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawTree1ToMany(){

	var mouseOverEntryID = "";
	// get tree submap, make sure it exists
	var treeSubMap = global.treeMap[? functionTree_treeSelected];
	if (!scr_isNumericAndExists(treeSubMap, ds_type_map)) exit;
	var setIDList = treeSubMap[? "setIDList"];
	if (!scr_isNumericAndExists(setIDList, ds_type_list)) exit;
	var setIDListSize = ds_list_size(setIDList);
	
	
	// draw light BG rect
	var strHeight = string_height("0") * 1.5;
	var headerHeight = functionTabs_tabHeight;
	draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.4));
	draw_rectangle(x, y, x + windowWidth, y + windowHeight - strHeight, false);
	
	// draw rectangle dividing numbers from text
	var spaceWidth = string_width(" ");
	var originalPlusX = string_width("Leaf") + (spaceWidth * 5)
	var plusX = originalPlusX;
	draw_set_color(global.colorThemeSelected2);
	draw_rectangle(x, y, x + plusX, y + windowHeight, false);


	// draw line for leaf level
	var rootY = floor(mean(y, y + strHeight));
	var leafY = floor(y + windowHeight - strHeight);
	var leafTextY = floor(mean(leafY, y + windowHeight));
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);

	draw_line(x, y, x, y + headerHeight);
	

	

	scr_surfaceStart();
	
	// draw "Root" text
	draw_set_color(global.colorThemeBG);
	draw_text(floor(x + spaceWidth) - clipX, rootY - clipY, "Root");
	
	var maxLevel = -1;
	if(ds_map_exists(treeSubMap, "maxLevel")){
		maxLevel = treeSubMap[?"maxLevel"];
	}
		
	// draw numbers for each level
	draw_set_halign(fa_center);
	for (var i = 1; i <= maxLevel; i++) {
		
		var levelY = rootY + (strHeight * i);
		draw_set_color(global.colorThemeBG);
		draw_text(floor(mean(x, x + originalPlusX)) - clipX, levelY - clipY, string(i));
		
		draw_set_color(global.colorThemeBG);
		draw_line(x - clipX, levelY - clipY - (strHeight / 2), x + windowWidth - clipX, levelY - clipY - (strHeight / 2));
	}
	draw_set_halign(fa_left);
	
	scr_drawTreeLinks();
	
	

	
	// loop over entries, draw each entry at its respective row (level)
	for (var i = 0; i < setIDListSize; i++) {
		
		// get current entry and all its goodies
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.treeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
		var currentDisplayToken = string(currentTokenTagMap[? global.displayTokenField]);	
		var currentLevel = currentEntrySubMap[? "level"];
		if (currentLevel < 0) {
			plusX += string_width(currentDisplayToken) + (spaceWidth * 4);
			continue;
		}
		maxLevel = max(maxLevel, currentLevel);
		
		
		// draw entry at its level
		var currentEntryY = rootY + (strHeight * currentLevel);
		
		var strWidth = string_width(currentDisplayToken);
		var realStrheight = string_height(currentDisplayToken);
		
			//get entry box demensions
		var boxWidth = string_width(currentDisplayToken) + (spaceWidth * 4);
		
		var tokenX1 = x + plusX;
		var tokenY1 = currentEntryY - realStrheight/1.8;
		var tokenX2 = x + plusX + boxWidth;
		var tokenY2 = currentEntryY + realStrheight/1.8;
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_roundrect_ext(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, 20,20,false );
		//mouse over for entry
		var mouseOverEntry = (point_in_rectangle(mouse_x, mouse_y,tokenX1,tokenY1,tokenX2,tokenY2) && mouseOverEntryID == "");
		
		currentEntrySubMap[?"entryX1"] = tokenX1;
		currentEntrySubMap[?"entryY1"] = tokenY1;
		currentEntrySubMap[?"entryX2"] = tokenX2;
		currentEntrySubMap[?"entryY2"] = tokenY2;
		
		
		if(mouseOverEntry){
			
			mouseOverEntryID = currentEntry;
			
			draw_set_alpha(1);
			draw_set_color(global.colorThemeSelected1);
			draw_roundrect_ext(tokenX1 - clipX, tokenY1 - clipY, tokenX2 - clipX, tokenY2 - clipY, 20,20,false );
			if(device_mouse_check_button_released(0,mb_left)){
				obj_chain.currentFocusedEntryID = currentEntry;
			}
			
		}
		
		
		draw_set_color(global.colorThemeText);
		draw_text(floor(x + plusX + spaceWidth) - clipX, currentEntryY - clipY, currentDisplayToken);
	

		plusX += boxWidth;
	}

	
	treeSubMap[?"maxLevel"] = maxLevel;

	scr_surfaceEnd();
	
	
	
	// draw leaf row
	plusX = originalPlusX;
	draw_set_halign(fa_left);
	for (var i = 0; i < setIDListSize; i++) {
		
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.treeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
		var currentDisplayToken = string(currentTokenTagMap[? global.displayTokenField]);
	
		//get entry box demensions
		var boxWidth = string_width(currentDisplayToken) + (spaceWidth * 4);
		
		var tokenX1 = x + plusX;
		var tokenY1 = leafY;
		var tokenX2 = x + plusX + boxWidth;
		var tokenY2 = y + windowHeight;
		
		
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(tokenX1,tokenY1,tokenX2,tokenY2,false);
		
		
		//mouse over for entry
		var mouseOverEntry = (point_in_rectangle(mouse_x, mouse_y,tokenX1,tokenY1,tokenX2,tokenY2) && mouseOverEntryID == "")
		
		
		if(mouseOverEntry){
			
			mouseOverEntryID = currentEntry;
			draw_set_alpha(1);
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(tokenX1,tokenY1,tokenX2,tokenY2,false);
			if(device_mouse_check_button_released(0,mb_left)){
			
				if(obj_chain.currentFocusedEntryID == ""){
					currentEntrySubMap[?"level"] = 0;
				}
				else{
					if(obj_chain.currentFocusedEntryID != currentEntry){
						if(currentEntrySubMap[?"level"] == -1){
							scr_createTreeLink(currentEntry);
						}
					}
				}
				
				
			
				obj_chain.currentFocusedEntryID = currentEntry;
			}
		}
		

	
		draw_set_color(global.colorThemeText);
		if(currentEntrySubMap[?"level"] >= 0){
			draw_set_alpha(0.5);
		}
		else{	
			draw_set_alpha(1);
		}
		draw_text(floor(x + plusX + spaceWidth), leafTextY, currentDisplayToken);
		
		draw_set_color(global.colorThemeBG);
		draw_set_alpha(0.5);
		draw_line(x + plusX, y, x + plusX, y + windowHeight);
		
		

		
		
		
		
		plusX += boxWidth;
	}
	plusX = originalPlusX;
	draw_set_alpha(1);
	draw_set_color(global.colorThemeSelected2);
	draw_rectangle(x, leafY, x + plusX, y + windowHeight, false);


	// draw "Leaf" text
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeBG);
	draw_text(floor(x + spaceWidth), leafTextY, "Leaf");
	
	draw_set_color(global.colorThemeBorders);
	draw_line(x, leafY, x + windowWidth, leafY);

	if(keyboard_check_released(vk_escape)){
		obj_chain.currentFocusedEntryID = "";
	}
}