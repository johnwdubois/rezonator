// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_mapViewerDrawNodeData(){

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
	var scrollBarSize = 0;
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
							|| subMapKey == "entryList"|| subMapKey == "unitList" || subMapKey == "displayUnitList"
							|| subMapKey == "inChunkList"|| subMapKey == "tagSet" || subMapKey == "targetList"
							|| subMapKey == "docList" ||subMapKey == "tokenList" || subMapKey == "customSetIDList"
							|| subMapKey == "inEntryList" ||  subMapKey =="1" ||  subMapKey =="2" ||  subMapKey =="3"
							|| subMapKey =="4" ||  subMapKey =="5" ||  subMapKey =="6" ||  subMapKey =="7");
			if (isList && scr_isNumericAndExists(subMapVal, ds_type_list)) {
				subMapValStr = scr_getStringOfList(subMapVal);
			}
			
			
			// check if this value is a map
			var isMap = (subMapKey == "tagMap" or nodeShow == "tokenTagMap" or nodeShow == "unitTagMap" or nodeShow == "searchMap" or nodeShow == "cliqueMap"
				or nodeShow == "treeMap" or nodeShow == "chainTagMap" or nodeShow == "entryTagMap" or nodeShow == "linkTagMap" or nodeShow == "participantMap" || nodeShow == "chainShowMap" or nodeShow == "entityMap");
			//show_debug_message("Is map... " + string(isMap));
			//show_debug_message("Entry is list... " + string(scr_isNumericAndExists(subMapVal, ds_type_map)));
			//show_debug_message(string(subMapVal));
			if (isMap && scr_isNumericAndExists(subMapVal, ds_type_map)) {
				subMapValStr = "";
				plusY += strHeight;
				scrollBarSize ++;
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
										|| (subMapKey == "tagMap" && global.participantField == subsubMapKey));
					
					var isList = (subsubMapKey == "tagSet" || subsubMapKey == "searchTermList" || subsubMapKey == "displayUnitList" 
									|| subsubMapKey == "displayTokenList"|| subsubMapKey == "targetList"|| subsubMapKey == "unitList"|| subsubMapKey == "chainList"
									|| subsubMapKey == "linkIDList" || subsubMapKey == "setIDList" ||subsubMapKey == "goalLinkList"||subsubMapKey == "shortcutSet"
									||subsubMapKey == "tokenList" || subsubMapKey == "entryList" || nodeShow == "entityMap");
		
					if (isList && scr_isNumericAndExists(subsubMapVal, ds_type_list)) {
						subsubMapValStr = scr_getStringOfList(subsubMapVal);
					}
					
					
					draw_set_color(specialField ? c_blue : global.colorThemeSelected2);
					draw_text(subTextX - clipX, subTextY - clipY, subsubMapKey + ":    " + subsubMapValStr);
					
					var subsubMapKey = ds_map_find_next(subMapVal, subsubMapKey);
					if (j < subsubMapSize - 1){
						plusY += strHeight;
						scrollBarSize ++;
					}
				}
			}
			else if(isMap && scr_isNumericAndExists(subMapVal, ds_type_list)){
				subMapValStr = "";
				plusY += strHeight;
				scrollBarSize ++;
				// if this is a map, loop over it and display its contents
				var subListSize = ds_list_size(subMapVal);
				for (var j = 0; j < subListSize; j++) {
					
					// get str for subsubmap
					var subListVal = subMapVal[|j];
					var subListStr = "";

					subListStr = string_replace_all(subListStr, "\r", "");
					subListStr = string_replace_all(subListStr, "\n", "");
					
					// get coordinates of submap text
					var subTextX = textX + string_width(subMapKey + ":    ");
					var subTextY = y + plusY + scrollPlusY;
					
					// check whether this field should be in a special color
					
					var isList = (nodeShow == "entityMap");
					//show_debug_message(string(isList));
					if (isList && scr_isNumericAndExists(subListVal, ds_type_list)) {
						subListStr = scr_getStringOfList(subListVal);
					}
					
					
					draw_set_color(global.colorThemeSelected2);
					draw_text(subTextX - clipX, subTextY - clipY, subMapKey + ":    " + subListStr);
					
					if (j < subListSize - 1){
						plusY += strHeight;
						scrollBarSize ++;
					}
				}
			}
			
			
			
			
			// draw out the values!
			draw_set_color((subMapKey == "type") ? c_green : global.colorThemeText);
			draw_set_alpha(1);
			draw_text(textX - clipX, textY - clipY, string(subMapKey) + ":    " + subMapValStr,);
			subMapKey = ds_map_find_next(subMap, subMapKey);
			
			plusY += strHeight;
			scrollBarSize ++;
		}
	}
	
	
	scr_scrollBar(scrollBarSize, -1, strHeight, 0,
		c_white, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scr_surfaceEnd();

}