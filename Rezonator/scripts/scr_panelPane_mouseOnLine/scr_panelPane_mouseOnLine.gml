function scr_panelPane_mouseOnLine(rectX1, rectY1, rectX2, rectY2, unitID, i, lineColor, mouseoverHeaderRegion, mouseoverScrollBar,currentUnitText) {
	
	
	var mouseoverLineName = (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2) && !mouseoverHeaderRegion && !mouseoverScrollBar
							&& !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox));
	
	if(mouseoverLineName){
		obj_control.hoverTextCopy = currentUnitText;
	}
	
	if (mouseoverLineName and !chainListPane.scrollBarClickLock) {
		
		with (obj_panelPane) {
			functionChainList_highlightUnit = unitID;
		}
		
		if (device_mouse_check_button_released(0, mb_left) and not instance_exists(obj_dialogueBox) and !instance_exists(obj_dropDown) and !instance_exists(obj_dialogueBox)) {
			
			with (obj_panelPane) {
				if (functionChainList_focusedUnitIndex != i) {
					functionChainList_focusedUnitIndex = i;
					functionChainList_focusedUnit = unitID;
					functionChainContents_BGColor = lineColor;
					functionChainContents_lineGridRowFocused = -1;
				}
			}
			scr_jumpToUnitDoubleClick(unitID);
		}
	}
}
