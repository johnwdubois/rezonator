function scr_chainTagDropDown(fieldMap, field, IDtoChange, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, lastColumn,cellText) {
	
	var mouseoverDropDown = false;
	var fieldHasTagSet = false;
	var fieldTagSubMap = fieldMap[? field];
	var setNavTaggingID = false;
	if (scr_isNumericAndExists(fieldTagSubMap, ds_type_map)) {
										
		// check whether this field has a tagSet
		var fieldHasTagSet = ds_map_exists(fieldTagSubMap, "tagSet");
		var fieldReadOnly = fieldTagSubMap[? "readOnly"];
		if (mouseoverCell && !instance_exists(obj_dialogueBox)) {
			// dropDown button for editing tags

	
			// draw dropDown button if this field has a tagSet
			if (fieldHasTagSet && !fieldReadOnly) {
			
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
						
					mouseoverDropDown = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
						
					draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, global.colorThemeText, 1);
					
					

					
					
					// click on dropdown button to create dropdown
					if (mouseoverDropDown) {
						scr_createTooltip(mean(dropDownButtonX1, dropDownButtonX2), dropDownButtonY2, scr_get_translation("option-tag"), TOOLTIP_DIR_UP);
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
							ds_list_add(dropDownOptionList, "menu_clear");
							
							scr_createDropDown(cellRectX1, cellRectY2, dropDownOptionList, optionListType);
							setNavTaggingID = true;
						}
					}
				}
			}
		}
	}
	
	var type = "entry"
	if (fieldMap == global.entryFieldMap) {type = "entry";}
	if (fieldMap == global.chainFieldMap) {type = "chain"}
	

	scr_cellEdit(IDtoChange, field, mouseoverCell, mouseoverDropDown, cellRectX1, cellRectY1, cellRectX2, cellRectY2, cellText, type);
	
	if (setNavTaggingID) {
		obj_control.navWindowTaggingID = IDtoChange;
		obj_control.navWindowTaggingField = field;
	}

}