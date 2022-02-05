function scr_tagInputBoxSetPos(ID, field, x1, y1, x2, y2){

	if (obj_control.navWindowTaggingField == field && obj_control.navWindowTaggingID == ID) {
		if (instance_exists(obj_inputBox)) {
			with (obj_inputBox) {
				if (navWindowTagging) {
					textBoxX = x1;
					textBoxY = y1;
					windowWidth = x2 - x1;
					windowHeight = y2 - y1;
					
					var paneInst = obj_control.navWindowTaggingPaneInst;
					if (instance_exists(paneInst)) {
						if (textBoxY < paneInst.y + paneInst.functionTabs_tabHeight - 5
						|| textBoxY + windowHeight > paneInst.y + paneInst.windowHeight) {
							show_debug_message("WE KILLIN IT HERE WUUUUUHHHHH????");
							instance_destroy();
						}
					}
				}
			}
		}
		
		with (obj_control) {
			navWindowTaggingCellX1 = x1;
			navWindowTaggingCellY1 = y1;
			navWindowTaggingCellX2 = x2;
			navWindowTaggingCellY2 = y2;
		}
		
		if (obj_control.navWindowTaggingUpdateScroll) {
			if (x1 < x) {
				scrollHorPlusXDest += abs(x1 - x);
			}
			else if (x2 > x + windowWidth) {
				scrollHorPlusXDest -= abs(x2 - (x + windowWidth));
			}
			
			var yAdjust = y + functionTabs_tabHeight;
			if (y1 < yAdjust) {
				scrollPlusYDest += abs(y1 - yAdjust);
			}
			else if (y2 > y + windowHeight - scrollBarHorHeight) {
				scrollPlusYDest -= abs(y2 - (y + windowHeight - scrollBarHorHeight));
			}
			obj_control.navWindowTaggingUpdateScroll = false;
		}
		
		
		with(obj_dropDown){
			x = x1;
			y = y2;
		}
	}
	

	

}