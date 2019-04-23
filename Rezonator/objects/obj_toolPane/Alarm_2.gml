if (mouse_y > y + windowHeight) {
		if (abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5) {
			if (currentTool != toolTrackBrush) {
				if (obj_control.hoverWordID < 0) {
					tempReturnTool = currentTool;
					currentTool = toolStackBrush;
				}
				else {
					tempReturnTool = currentTool;
					currentTool = toolRezBrush;
				}
			}
		}
	}