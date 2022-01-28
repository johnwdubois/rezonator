function scr_cellEdit(ID, field, mouseoverCell, mouseoverDropDown, x1, y1, x2, y2, str, type){
	
	
	// create input box for tagging if user clicks on cell
	if(mouseoverCell){
		obj_control.hoverTextCopy = str;
		obj_control.mouseoverTagCell = true;

		if (mouse_check_button_released(mb_left) && !mouseoverDropDown) {
				
			if(obj_control.navWindowTaggingID != ID or obj_control.navWindowTaggingField != field){
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
			if(obj_control.doubleClickTimer > 0 ){
				obj_control.navWindowTaggingFocusHeavy = true;
					
				var nodeMapKey = "";
				var optionListType = -1;
				if (type == "token") {
					nodeMapKey = "tokenTagMap";
					optionListType = global.optionListTypeTokenTagMap;
				}
				
				if (nodeMapKey != "" && optionListType != -1) {
					
					// get submap for this field
					var tokenTagMap = global.nodeMap[? nodeMapKey];
					var fieldSubMap = tokenTagMap[? field];
					
					// get the tagSet for this field
					var tagSet = fieldSubMap[? "tagSet"];
					// create dropdown
					var dropDownOptionList = ds_list_create();
					ds_list_copy(dropDownOptionList, tagSet);

					obj_control.tokenToChange = ID;
					obj_control.tokenFieldToChange = field;

					scr_spawnTagInputBox(ID, field, str, self.id,dropDownOptionList, optionListType);
				}
			}
		}
	}
		
	scr_tagInputBoxSetPos(ID, field, x1, y1, x2, y2);
			

}