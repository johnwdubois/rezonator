// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawTreeLinks(){
	

	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	var linkList = treeSubMap[?"linkIDList"];
	with (obj_panelPane) functionTree_treeLinkMouseover = "";
	var mouseoverLinkColor = c_blue;
	
	var linkListSize = ds_list_size(linkList);
	for(var i = 0; i < linkListSize; i++){
		
		// get the source & goal of this link, make sure both are entries that exist
		var currentLink = linkList[| i];
		var linkSubMap = global.treeMap[? currentLink];
		if(!scr_isNumericAndExists(linkSubMap,ds_type_map)){continue;}
		var source = linkSubMap[?"source"];
		var goal = linkSubMap[?"goal"];
		var sourceSubMap = global.treeMap[? source];
		var goalSubMap = global.treeMap[? goal];
		if (!scr_isNumericAndExists(sourceSubMap,ds_type_map) or !scr_isNumericAndExists(goalSubMap,ds_type_map)) continue;
		var currentLinkSelected = (functionTree_treeLinkSelected == currentLink);

		// get link coordinates
		var arrowX1 = mean(sourceSubMap[? "entryX1"],sourceSubMap[? "entryX2"]);
		var arrowY1 = sourceSubMap[? "entryY2"];
		var arrowX2 = mean(goalSubMap[? "entryX1"], goalSubMap[? "entryX2"]);
		var arrowY2 = goalSubMap[? "entryY1"];
		
		// check mouseover
		if (functionTree_treeLinkMouseover == "" && functionTree_treeMouseoverLinkArea) {
			var topLeftX = min(arrowX1, arrowX2);
			var topLeftY = min(arrowY1, arrowY2);
			var bottomRightX = max(arrowX1, arrowX2);
			var bottomRightY = max(arrowY1, arrowY2);
			if (point_in_rectangle(mouse_x, mouse_y, topLeftX, topLeftY, bottomRightX, bottomRightY)) {			
				var distToLineTop = abs((arrowX2 - arrowX1) * (arrowY1 - mouse_y) - (arrowX1 - mouse_x) * (arrowY2 - arrowY1));
				var distToLineBottom = sqrt(power((arrowX2 - arrowX1), 2) + power((arrowY2 - arrowY1), 2));
				var distToLine = distToLineTop / distToLineBottom;
				if (distToLine < 10) {
					with (obj_panelPane) functionTree_treeLinkMouseover = currentLink;
				}
			}
		}
		var mouseover = (functionTree_treeLinkMouseover == currentLink) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		
		// click on link
		if (mouseover) {
			if(mouse_check_button_released(mb_left)){
				with (obj_panelPane) functionTree_treeLinkSelected = currentLink;
				// set field/tags if in read mode
				if (obj_panelPane.functionField_linkFieldSelected != "" && obj_panelPane.functionField_linkTagSelected != ""
				&& is_string(obj_panelPane.functionField_linkFieldSelected) && is_string(obj_panelPane.functionField_linkTagSelected)) {
					var linkTagMap = linkSubMap[? "tagMap"];
					if (scr_isNumericAndExists(linkTagMap, ds_type_map)) {
						linkTagMap[? obj_panelPane.functionField_linkFieldSelected] = obj_panelPane.functionField_linkTagSelected;
						show_debug_message("scr_tokenClicked ... setting token: " + string(currentLink) + ", field:" + string(obj_panelPane.functionField_linkFieldSelected) + ", tag: " + string(obj_panelPane.functionField_linkTagSelected));
					}
				}
			}
			if (mouse_check_button_released(mb_right)) {
				with (obj_panelPane) functionTree_treeLinkSelected = currentLink;
				var dropDownOptionList = ds_list_create();
				ds_list_copy(dropDownOptionList, global.linkFieldList);
				ds_list_insert(dropDownOptionList, 0, "Delete Link");
				ds_list_insert(dropDownOptionList, 0, "Create new field");
				scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeLinkFields);
			}
		}
		
		// draw line for arrow
		draw_set_alpha(1);
		draw_set_color((mouseover || currentLinkSelected) ? mouseoverLinkColor : global.colorThemeBorders);
		draw_line_width(arrowX1 - clipX, arrowY1 - clipY, arrowX2 - clipX, arrowY2 - clipY, (mouseover || currentLinkSelected) ? 4 : 2);
		
		// draw arrowhead
		var arrowDir = point_direction(arrowX1, arrowY1, arrowX2, arrowY2);
		var arrowScale = (mouseover || currentLinkSelected) ? 0.5 : 0.3;
		draw_sprite_ext(spr_linkArrow, 0, arrowX2 - clipX, arrowY2 - clipY, arrowScale, arrowScale, arrowDir, (mouseover || currentLinkSelected) ? mouseoverLinkColor : global.colorThemeBorders, 1);
	}
	
	// reset selected link
	if (functionTree_treeLinkSelected != "" && !instance_exists(obj_dropDown)) {
		functionTree_treeLinkSelected = "";
	}
	
}