// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawTree1ToMany(){
	

	
	// get tree submap, make sure it exists
	var treeSubMap = global.treeMap[? functionTree_treeSelected];
	if (!scr_isNumericAndExists(treeSubMap, ds_type_map)) exit;
	var setIDList = treeSubMap[? "setIDList"];
	if (!scr_isNumericAndExists(setIDList, ds_type_list)) exit;
	
	
	// draw rectangle dividing numbers from text
	var spaceWidth = string_width(" ");
	var plusX = string_width("Leaf") + (spaceWidth * 5);
	draw_set_color(global.colorThemeSelected2);
	draw_rectangle(x, y, x + plusX, y + windowHeight, false);

	// draw line for leaf level
	var strHeight = string_height("0") * 1.5;
	var headerHeight = functionTabs_tabHeight;
	var leafY = floor(y + windowHeight - strHeight);
	var leafTextY = floor(mean(leafY, y + windowHeight));
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_line(x, leafY, x + windowWidth, leafY);
	draw_line(x, y, x, y + headerHeight);
	
	// draw "Leaf" text
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeBG);
	draw_text(floor(x + spaceWidth), leafTextY, "Leaf");
	


	
	// draw leaf row
	var setIDListSize = ds_list_size(setIDList);
	for (var i = 0; i < setIDListSize; i++) {
		
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = treeSubMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
		var currentDisplayToken = string(currentTokenTagMap[? global.displayTokenField]);
		
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_text(floor(x + plusX + spaceWidth), leafTextY, currentDisplayToken);
		
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(0.5);
		draw_line(x + plusX, y, x + plusX, y + windowHeight);
		
		plusX += string_width(currentDisplayToken) + (spaceWidth * 4);
	}

}