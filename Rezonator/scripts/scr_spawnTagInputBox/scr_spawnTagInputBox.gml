function scr_spawnTagInputBox(ID, field, defStr){
	
	with (obj_inputBox) {
		if (navWindowTagging) {
			if (obj_control.navWindowTaggingField != field || obj_control.navWindowTaggingID != ID) {
				instance_destroy();
			}
		}
	}
	global.inputBoxDefStr = defStr;
	var inst = instance_create_layer(0,0,"InstancesInput", obj_inputBox);
	inst.navWindowTagging = true;
	obj_control.navWindowTaggingField = field;
	obj_control.navWindowTaggingID = ID;
	
}