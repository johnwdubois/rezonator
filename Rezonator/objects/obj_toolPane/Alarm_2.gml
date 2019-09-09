if (mouse_y > y + windowHeight) {
		//if (abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5) {
			if (currentTool != toolTrackBrush) {
				if (obj_control.mouseRectBeginInWord == -1 and obj_control.mouseRectBeginInSpeakerLabel) {
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