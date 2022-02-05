function scr_spawnTagInputBox(ID, field, type, defStr, paneInst, dropDownList, dropDownType){
	
	with (obj_inputBox) {
		if (navWindowTagging) {
			if (obj_control.navWindowTaggingField != field || obj_control.navWindowTaggingID != ID) {
				show_debug_message("scr_spawnTagInputBox, destroy inputBox");
				instance_destroy();
			}
		}
	}
	with (obj_dropDown) {
		instance_destroy();
	}
	
	scr_setIDandFieldToChange(ID, field, type);
	
	scr_createDropDown(-400,-200,dropDownList,dropDownType);
	
	global.inputBoxDefStr = defStr;
	keyboard_string = "";
	var inst = instance_create_layer(0,0,"InstancesInput", obj_inputBox);
	inst.navWindowTagging = true;
	obj_control.navWindowTaggingField = field;
	obj_control.navWindowTaggingID = ID;
	obj_control.navWindowTaggingPaneInst = paneInst;
	
	// get old value
	var idSubMap = global.nodeMap[? ID];
	if (scr_isNumericAndExists(idSubMap, ds_type_map)) {
		var idTagMap = idSubMap[? "tagMap"];
		if (scr_isNumericAndExists(idTagMap, ds_type_map)) {
			obj_control.navWindowTaggingOldValue = idTagMap[? field];
		}
	}
	
}