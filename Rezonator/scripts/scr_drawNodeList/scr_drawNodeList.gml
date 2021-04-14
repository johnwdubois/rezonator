// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawNodeList(){

	
	var nodeList = (string_length(nodeListSearch) > 0) ? subNodeList : global.nodeMap[? "nodeList"];
	if (!scr_isNumericAndExists(nodeList, ds_type_list)) exit;
	var nodeListSize = ds_list_size(nodeList);
	
	scr_adaptFont("0", "M");
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var strHeight = string_height("0");
	
	draw_set_color(c_black);
	draw_text(100, 150, "nodeListSize: " + string(nodeListSize));
	draw_text(100, 150 + strHeight, "rezChainList: " + scr_getStringOfList(global.nodeMap[? "rezChainList"]));
	draw_text(100, 150 + (strHeight * 2), "trackChainList: " + scr_getStringOfList(global.nodeMap[? "trackChainList"]));
	draw_text(100, 150 + (strHeight * 3), "stackChainList: " + scr_getStringOfList(global.nodeMap[? "stackChainList"]));
	draw_text(100, 150 + (strHeight * 4), "showList: " + scr_getStringOfList(global.nodeMap[? "showList"]));
	
	
	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	x = 100;
	y = 180 + (strHeight * 5);
	windowWidth = camWidth * 0.2;
	windowHeight = camHeight - windowY - 100;
	
	draw_set_color(global.colorThemeText);
	draw_rectangle(windowX, windowY, windowX + windowWidth, windowY + windowHeight, true);
	
	scr_surfaceStart();


	
	
	var textPlusY = 0;
	for (var i = 0; i < nodeListSize; i++) {
		
		if (y + scrollPlusY + textPlusY < y - strHeight
		or y + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			continue;
		}
		else if (y + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			break;
		}
		
		var currentNodeStr = string(nodeList[| i]);
		var currentSubMap = global.nodeMap[? currentNodeStr];
		var currentType = "";
		if (scr_isNumericAndExists(currentSubMap, ds_type_map)) currentType = string(currentSubMap[? "type"]);
		
		var textY = y + scrollPlusY + textPlusY;
		var textRectX1 = x;
		var textRectY1 = textY - (strHeight * 0.5);
		var textRectX2 = windowX + windowWidth;
		var textRectY2 = textRectY1 + strHeight;
		
		var mouseoverText = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, textRectX1, textRectY1, textRectX2, textRectY2);
		if (mouseoverText || nodeList[| selectedNodeIndex] == currentNodeStr) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(textRectX1 - clipX, textRectY1 - clipY, textRectX2 - clipX, textRectY2 - clipY, false);
		}
		if (mouseoverText) {	
			if (mouse_check_button_released(mb_left)) {
				selectedNodeIndex = i;
			}
		}
		
		
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_set_halign(fa_left);
		draw_text(x - clipX, textY - clipY, currentNodeStr);
		
		draw_set_alpha(0.7);
		draw_set_halign(fa_right);
		draw_text(x + windowWidth - global.scrollBarWidth - clipX, textY - clipY, currentType);
		
		textPlusY += strHeight;
	}
	
	scr_scrollBar(nodeListSize, -1, strHeight, 0,
		c_white, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
		
	// scroll with arrow keys
	if (nodeListSize > 0) {
		if (keyboard_check_pressed(vk_up)) {
			selectedNodeIndex--;
		}
		if (keyboard_check_pressed(vk_down)) {
			selectedNodeIndex++;
		}
		selectedNodeIndex = clamp(selectedNodeIndex, 0, nodeListSize - 1);
	}
	
	if (mouse_wheel_down()) {
		scrollPlusYDest -= 16;
	}
	if (mouse_wheel_up()) {
		scrollPlusYDest += 16;
	}
	
	scr_surfaceEnd();
	
	with (obj_mapViewerNodeData) {
		if (nodeListSize > 0) {
			nodeShow = nodeList[| obj_mapViewerNodeList.selectedNodeIndex];
		}
	}
	
	// search
	if (keyboard_check(vk_control) && keyboard_check_pressed(ord("F"))) {
		nodeListSearch = get_string("", "");
		if (string_length(nodeListSearch) > 0) {
			ds_list_clear(subNodeList);
			var fullNodeList = global.nodeMap[? "nodeList"];
			var fullNodeListSize = ds_list_size(fullNodeList);
			for (var i = 0; i < fullNodeListSize; i++) {
				var currentNode = string(fullNodeList[| i]);
				if (string_count(string_lower(nodeListSearch), string_lower(currentNode)) > 0) {
					ds_list_add(subNodeList, currentNode);
				}
			}
		}
	}
	

	
}