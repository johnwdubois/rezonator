function scr_clearNavWindowTagging(destroyInputBox){
	
	if (destroyInputBox) {
		if (obj_control.navWindowTaggingField != "" && obj_control.navWindowTaggingID != "") {
			show_debug_message("scr_clearNavWindowTagging, destroy inputBox");
			with (obj_inputBox) instance_destroy();
			with (obj_dropDown) instance_destroy();
		}
	}
	
	
	with (obj_control) {
		navWindowTaggingID = "";
		navWindowTaggingField = "";
		navWindowTaggingFocusHeavy = false;
	}
}