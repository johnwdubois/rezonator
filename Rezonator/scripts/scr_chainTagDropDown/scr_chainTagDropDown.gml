// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainTagDropDown(fieldMap, field, IDtoChange, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, lastColumn) {
	
	if (mouseoverCell && !instance_exists(obj_dialogueBox)) {
		// dropDown button for editing tags
		var fieldTagSubMap = fieldMap[? field];
		if (scr_isNumericAndExists(fieldTagSubMap, ds_type_map)) {
										
			// check whether this field has a tagSet
			var fieldHasTagSet = ds_map_exists(fieldTagSubMap, "tagSet");
			var fieldHasShortcutSet = ds_map_exists(fieldTagSubMap, "shortcutSet");
	
			// draw dropDown button if this field has a tagSet
			if (fieldHasTagSet) {
			
				// get the tagSet of this field and make sure it exists
				var fieldTagSet = fieldTagSubMap[? "tagSet"];
				if (scr_isNumericAndExists(fieldTagSet, ds_type_list)) {
						
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
						
					draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
								
					// click on dropdown button to create dropdown
					if (mouseoverDropDown) {
						draw_set_color(global.colorThemeBorders);
						draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
						if (mouse_check_button_released(mb_left)) {
							var optionListType = -1;
							if (fieldMap == global.entryFieldMap) {
								obj_control.chain1toManyEntryToChange = IDtoChange;
								obj_control.chain1toManyFieldToChange = field;
								optionListType = global.optionListTypeChain1ToManyTag;
							}
							else if (fieldMap == global.chainFieldMap) {
								obj_control.chain1to1ChainToChange = IDtoChange;
								obj_control.chain1to1FieldToChange = field;
								optionListType = global.optionListTypeChain1To1Tag;
							}
							
							var dropDownOptionList = ds_list_create();
							ds_list_copy(dropDownOptionList, fieldTagSet);
							ds_list_insert(dropDownOptionList, 0, "option_add-to-tag-set");
							
							scr_createDropDown(cellRectX1, cellRectY2, dropDownOptionList, optionListType);
						}
					}
						
					// keyboard shortcut
					if (fieldHasShortcutSet) {
						if (!instance_exists(obj_dropDown)) {
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
							var fieldShortcutSet = fieldTagSubMap[? "shortcutSet"];
							if (scr_isNumericAndExists(fieldShortcutSet, ds_type_list)) {
										
								if (keyboard_check_released(vk_anykey)) {
										
									// loop down through all possible shortcuts and see if any of them are being used
									var fieldShortcutSetSize = ds_list_size(fieldShortcutSet);
									for (var i = 0; i < fieldShortcutSetSize; i++) {
										var currentShortcut = fieldShortcutSet[| i];
										currentShortcut = string_upper(string(currentShortcut));
										if (string_length(currentShortcut) == 1) {
											if (keyboard_check_released(ord(currentShortcut))) {
													
												// set value if keyboard shortcut used
												var optionSelected = fieldTagSet[| i];
												if (fieldMap == global.entryFieldMap) {
													scr_chain1ToManyTagOptions(optionSelected);
												}
												else if (fieldMap == global.chainFieldMap) {
													scr_chain1To1TagOptions(optionSelected);
												}
													
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