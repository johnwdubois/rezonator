function scr_cellEdit(ID, field, mouseoverCell, mouseoverDropDown, x1, y1, x2, y2, str, type){
	var isDragging = false;
	with(obj_inputBox){
		isDragging = dragging;
	}
	
	// create input box for tagging if user clicks on cell
	if(mouseoverCell){
		obj_control.hoverTextCopy = str;
		obj_control.mouseoverTagCell = true;

		if (mouse_check_button_released(mb_left) && !mouseoverDropDown && !isDragging) {
			
			var onIDandField = (obj_control.navWindowTaggingID == ID && obj_control.navWindowTaggingField == field);
			if ((!onIDandField || (onIDandField && !instance_exists(obj_inputBox))) && obj_control.doubleClickTimer == -1) {
				obj_control.doubleClickTimer = 0;
			}
			
			
			with (obj_control) {
				navWindowTaggingID = ID;
				navWindowTaggingField = field;
			}
			if (x1 < x) {
				scrollHorPlusXDest += abs(x1 - x);
			}
			else if (x2 > x + windowWidth) {
				scrollHorPlusXDest -= abs(x2 - (x + windowWidth));
			}
			if(obj_control.doubleClickTimer > 0){
				obj_control.navWindowTaggingFocusHeavy = true;
					
				var nodeMapKey = "";
				var optionListType = -1;
				if (type == "token") {
					nodeMapKey = "tokenTagMap";
					optionListType = global.optionListTypeTokenTagMap;
				}
				else if (type == "unit") {
					nodeMapKey = "unitTagMap";
					optionListType = global.optionListTypeUnitTagMap;
				}
				else if (type == "entry") {
					nodeMapKey = "entryTagMap";
					optionListType = global.optionListTypeEntryTagMap;
				}
				else if (type == "chain") {
					nodeMapKey = "chainTagMap";
					optionListType = global.optionListTypeChainTagMap;
				}
				else if (type == "chunk") {
					nodeMapKey = "tokenTagMap";
					optionListType = global.optionListTypeChunk1To1Tag;
				}
				
				if (nodeMapKey != "" && optionListType != -1) {
					
					// get submap for this field
					var tagMap = global.nodeMap[? nodeMapKey];
					var fieldSubMap = tagMap[? field];
					var fieldHasTagSet = scr_checkForTagSet(fieldSubMap);
					var readOnly =  fieldSubMap[?"readOnly"];
					if(fieldHasTagSet && !readOnly){
						// get the tagSet for this field
						var tagSet = fieldSubMap[? "tagSet"];
						// create dropdown
						var dropDownOptionList = ds_list_create();
						ds_list_copy(dropDownOptionList, tagSet);


						scr_spawnTagInputBox(ID, field, type, str, self.id, dropDownOptionList, optionListType);
					}
				}
			}
		}
	}
		
	scr_tagInputBoxSetPos(ID, field, x1, y1, x2, y2);
			

}