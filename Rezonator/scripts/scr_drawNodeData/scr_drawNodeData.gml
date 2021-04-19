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
		var plusY = 0;
		for (var i = 0; i < subMapSize; i++) {
			
			// get value and determine how to display it
			var subMapVal = subMap[? subMapKey];
			var subMapValStr = "";
			if (is_string(subMapVal)) subMapValStr = "\"" + subMapVal + "\"";
			else subMapValStr = string(subMapVal);
			
			// get textX & textY for this value
			var textX = x + string_width("  ");
			var textY = y + plusY + scrollPlusY;

			// check if this value is a list
			var isList = (subMapKey == "goalLinkList" || subMapKey == "linkIDList" || subMapKey == "vizSetIDList"
							|| subMapKey == "setIDList"  || subMapKey == "inChainsList" || subMapKey == "tokenList"
							|| subMapKey == "entryList"|| subMapKey == "unitList");
			if (isList && scr_isNumericAndExists(subMapVal, ds_type_list)) {
				subMapValStr = scr_getStringOfList(subMapVal);
			}
			
			// check if this value is a map
			var isMap = (subMapKey == "tagMap");
			if (isMap && scr_isNumericAndExists(subMapVal, ds_type_map)) {
				subMapValStr = "";
				plusY += strHeight;
				// if this is a map, loop over it and display its contents
				var subsubMapSize = ds_map_size(subMapVal);
				var subsubMapKey = ds_map_find_first(subMapVal);
				for (var j = 0; j < subsubMapSize; j++) {
					
					// get str for subsubmap
					var subsubMapVal = subMapVal[? subsubMapKey];
					var subsubMapValStr = "";
					if (is_string(subsubMapVal)) subsubMapValStr = "\"" + subsubMapVal + "\"";
					else subsubMapValStr = string(subsubMapVal);
					subsubMapValStr = string_replace_all(subsubMapValStr, "\r", "");
					subsubMapValStr = string_replace_all(subsubMapValStr, "\n", "");
					
					// get coordinates of submap text
					var subTextX = textX + string_width(subMapKey + ":    ");
					var subTextY = y + plusY + scrollPlusY;
					
					// check whether this field should be in a special color
					var specialField = ((subMapKey == "tagMap" && global.displayTokenField == subsubMapKey)
										|| (subMapKey == "tagMap" && global.speakerField == subsubMapKey));
					
					draw_set_color(specialField ? c_blue : global.colorThemeSelected2);
					draw_text(subTextX - clipX, subTextY - clipY, subsubMapKey + ":    " + subsubMapValStr);
					
					var subsubMapKey = ds_map_find_next(subMapVal, subsubMapKey);
					if (j < subsubMapSize - 1) plusY += strHeight;
				}
			}
			
			
			
			
			// draw out the values!
			draw_set_color((subMapKey == "type") ? c_green : global.colorThemeText);
			draw_set_alpha(1);
			draw_text(textX - clipX, textY - clipY, string(subMapKey) + ":    " + subMapValStr,);
			subMapKey = ds_map_find_next(subMap, subMapKey);
			
			plusY += strHeight;
		}
	}
	
	
	scr_scrollBar(subMapSize, -1, strHeight, 0,
		c_white, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scr_surfaceEnd();

}