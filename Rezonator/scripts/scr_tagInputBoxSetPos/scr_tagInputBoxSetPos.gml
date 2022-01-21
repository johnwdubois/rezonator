function scr_tagInputBoxSetPos(ID, field, x1, y1, x2, y2){

	if (instance_exists(obj_inputBox)) {
		if (obj_control.navWindowTaggingField == field && obj_control.navWindowTaggingID == ID) {
			with (obj_inputBox) {
				if (navWindowTagging) {
					textBoxX = x1;
					textBoxY = y1;
					windowWidth = x2 - x1;
					windowHeight = y2 - y1;
					
					var paneInst = obj_control.navWindowTaggingPaneInst;
					if (instance_exists(paneInst)) {
						if (textBoxY < paneInst.y + paneInst.functionTabs_tabHeight
						|| textBoxY + windowHeight > paneInst.y + paneInst.windowHeight) {
							instance_destroy();
						}
					}
				}
			}
		}
	}

}