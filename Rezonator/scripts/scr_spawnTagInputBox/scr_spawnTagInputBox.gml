function scr_spawnTagInputBox(ID, field, defStr, paneInst, dropDownList, dropDownType){

	with (obj_inputBox) {
		if (navWindowTagging) {
			if (obj_control.navWindowTaggingField != field || obj_control.navWindowTaggingID != ID) {
				instance_destroy();
			}
		}
	}
	with (obj_dropDown) {
		instance_destroy();
	}
	show_debug_message(scr_getStringOfList(dropDownList));
	scr_createDropDown(-400,-200,dropDownList,dropDownType);
	
	global.inputBoxDefStr = defStr;
	keyboard_string = "";
	var inst = instance_create_layer(0,0,"InstancesInput", obj_inputBox);
	inst.navWindowTagging = true;
	obj_control.navWindowTaggingField = field;
	obj_control.navWindowTaggingID = ID;
	obj_control.navWindowTaggingPaneInst = paneInst;
	
}