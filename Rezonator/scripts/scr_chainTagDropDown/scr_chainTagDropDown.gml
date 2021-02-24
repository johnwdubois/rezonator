// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainTagDropDown(fieldMap, field, IDtoChange, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, lastColumn) {
	
	// dropDown button for editing tags
	var fieldTagSubMap = ds_map_find_value(fieldMap, field);
	if (is_numeric(fieldTagSubMap)) {
		if (ds_exists(fieldTagSubMap, ds_type_map)) {
										
			// check whether this field has a tagSet
			var fieldHasTagSet = ds_map_exists(fieldTagSubMap, "tagSet");
			var fieldHasShortcutSet = ds_map_exists(fieldTagSubMap, "shortcutSet");
	
			// draw dropDown button if this field has a tagSet
			if (fieldHasTagSet) {
			
				// get the tagSet of this field and make sure it exists
				var fieldTagSet = ds_map_find_value(fieldTagSubMap, "tagSet");
				if (is_numeric(fieldTagSet)) {
					if (ds_exists(fieldTagSet, ds_type_list)) {
						
						// dropdown button coordinates
						var dropDownButtonX1 = cellRectX1 + ((cellRectX2 - cellRectX1) * 0.8);
						var dropDownButtonY1 = cellRectY1 + ((cellRectY2 - cellRectY1) * 0.25);
						var dropDownButtonX2 = cellRectX1 + ((cellRectX2 - cellRectX1) * 0.95);
						var dropDownButtonY2 = cellRectY1 + ((cellRectY2 - cellRectY1) * 0.75);
						
						// if this is the last column, we leave room for scrollbar
						if (lastColumn) {
							dropDownButtonX1 -= global.scrollBarWidth;
							dropDownButtonX2 -= global.scrollBarWidth;
						}
						
						var mouseoverDropDown = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
						
						draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, c_white, 1);
								
						// click on dropdown button to create dropdown
						if (mouseoverDropDown) {
							draw_set_color(global.colorThemeBorders);
							draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
							if (mouse_check_button_released(mb_left)) {
								if (fieldMap == global.entryFieldMap) {
									obj_control.chain1toManyEntryToChange = IDtoChange;
									obj_control.chain1toManyFieldToChange = field;
								}
								else if (fieldMap == global.chainFieldMap) {
									obj_control.chain1to1ChainToChange = IDtoChange;
									obj_control.chain1to1FieldToChange = field;
								}
								scr_createDropDown(cellRectX1, cellRectY2, fieldTagSet, global.optionListTypeChainContents1ToManyTag);
							}
						}
						
						// keyboard shortcut
						if (fieldHasShortcutSet) {
							if (mouseoverCell) {
								obj_control.mouseoverTagShortcut = string(field);
								if (fieldMap == global.entryFieldMap) {
									obj_control.chain1toManyEntryToChange = IDtoChange;
									obj_control.chain1toManyFieldToChange = field;
								}
								else if (fieldMap == global.chainFieldMap) {
									obj_control.chain1to1ChainToChange = IDtoChange;
									obj_control.chain1to1FieldToChange = field;
								}
							}
							if (obj_control.mouseoverTagShortcut == string(field)) {
								var fieldShortcutSet = ds_map_find_value(fieldTagSubMap, "shortcutSet");
								if (is_numeric(fieldShortcutSet)) {
									if (ds_exists(fieldShortcutSet, ds_type_list)) {
										var fieldShortcutSetSize = ds_list_size(fieldShortcutSet);
										for (var i = 0; i < fieldShortcutSetSize; i++) {
											var currentShortcut = ds_list_find_value(fieldShortcutSet, i);
											currentShortcut = string_upper(string(currentShortcut));
											if (string_length(currentShortcut) == 1) {
												if (keyboard_check_released(ord(currentShortcut))) {
													var optionSelected = ds_list_find_value(fieldTagSet, i);
													scr_chain1ToManyTagOptions(optionSelected);
													with (obj_dropDown) {
														instance_destroy();
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	

}