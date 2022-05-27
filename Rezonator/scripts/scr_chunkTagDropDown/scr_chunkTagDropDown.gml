function scr_chunkTagDropDown(fieldMap, field, IDtoChange, str, cellRectX1, cellRectY1, cellRectX2, cellRectY2, mouseoverCell, lastColumn) {
	
	var mouseoverDropDown = false;
	var setNavTaggingID = false;
	
	if (mouseoverCell && !instance_exists(obj_dialogueBox)) {
		// dropDown button for editing tags
		var fieldTagSubMap = fieldMap[? field];
		if (scr_isNumericAndExists(fieldTagSubMap, ds_type_map)) {
										
			// check whether this field has a tagSet
			var fieldHasTagSet = ds_map_exists(fieldTagSubMap, "tagSet");
			var fieldReadOnly = fieldTagSubMap[?"readOnly"];
	
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
						draw_set_color(global.colorThemeBorders);
						draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
						if (mouse_check_button_released(mb_left)) {

							obj_control.chunk1to1ChunkToChange = IDtoChange;
							obj_control.chunk1to1FieldToChange = field;
							
							// create dropdown
							var dropDownOptionList = ds_list_create();
							ds_list_copy(dropDownOptionList, fieldTagSet);
							ds_list_add(dropDownOptionList, "option_add-to-tag-set");
							ds_list_add(dropDownOptionList, "menu_clear");

							scr_createDropDown(cellRectX1, cellRectY2, dropDownOptionList, global.optionListTypeChunk1To1Tag);
							setNavTaggingID = true;
						}
					}
				}
			}
		}
	}
	
	scr_cellEdit(IDtoChange, field, mouseoverCell, mouseoverDropDown, cellRectX1, cellRectY1, cellRectX2, cellRectY2, str, "chunk");
	if (setNavTaggingID) {
		obj_control.navWindowTaggingID = IDtoChange;
		obj_control.navWindowTaggingField = field;
	}

}