// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawNodeData(){
	

	scr_adaptFont("0", "M");
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var strHeight = string_height("0");
	
	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	x = camWidth * 0.3;
	y = 180 + (strHeight * 4);
	windowWidth = camWidth - x - (camWidth * 0.1);
	windowHeight = camHeight - windowY - 100;
	
	// draw window border
	draw_set_color(global.colorThemeText);
	draw_rectangle(windowX, windowY, windowX + windowWidth, windowY + windowHeight, true);
	
	draw_text(windowX, windowY - strHeight, "selectedNode: " + string(nodeShow));
	
	scr_surfaceStart();
	
	// get submap for node to show
	var subMapSize = 0;
	var subMap = global.nodeMap[? nodeShow];
	
	if (scr_isNumericAndExists(subMap, ds_type_map)) {
		subMapSize = ds_map_size(subMap);
		var subMapKey = ds_map_find_first(subMap);
		for (var i = 0; i < subMapSize; i++) {
			
			// get value and determine how to display it
			var subMapVal = subMap[? subMapKey];
			var subMapValStr = "";
			if (is_string(subMapVal)) {
				subMapValStr = "\"" + subMapVal + "\"";
			}
			else {
				subMapValStr = string(subMapVal);
			}

			// check if this value is a list
			var isList = (subMapKey == "goalLinkList" || subMapKey == "linkIDList" || subMapKey == "vizSetIDList"
							|| subMapKey == "setIDList"  || subMapKey == "inChainsList" || subMapKey == "tokenList");
			if (isList && scr_isNumericAndExists(subMapVal, ds_type_list)) {
				subMapValStr = scr_getStringOfList(subMapVal);
			}
			
			// draw out the values!
			var textX = x + string_width("  ");
			var textY = y + (i * strHeight) + scrollPlusY;
			draw_set_color((subMapKey == "type") ? c_green : global.colorThemeText);
			draw_set_alpha(1);
			draw_text(textX - clipX, textY - clipY, string(subMapKey) + ":    " + subMapValStr);
			subMapKey = ds_map_find_next(subMap, subMapKey);
	
		}
	}
	
	
	scr_scrollBar(subMapSize, -1, strHeight, 0,
		c_white, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scr_surfaceEnd();

}