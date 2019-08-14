if (mouse_y > y + windowHeight) {
		//if (abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5) {
			if (currentTool != toolTrackBrush) {
				if (not obj_control.mouseRectBeginInWord) {
					tempReturnTool = currentTool;
					currentTool = toolStackBrush;
				}
				
				else {
					tempReturnTool = currentTool;
					currentTool = toolRezBrush;
				}
			}
			else if(obj_control.searchGridActive){
				tempReturnTool = currentTool;
				currentTool = toolTrackBrush;
			}
		//}
	}