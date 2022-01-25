function scr_clearNavWindowTagging(){
	if (obj_control.navWindowTaggingField != "" && obj_control.navWindowTaggingID != "") {
		with (obj_inputBox) instance_destroy();
	}
	
	with (obj_control) {
		navWindowTaggingID = "";
		navWindowTaggingField = "";
		navWindowTaggingFocusHeavy = false;
	}
}