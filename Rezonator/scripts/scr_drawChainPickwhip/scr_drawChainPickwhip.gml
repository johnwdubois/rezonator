

function scr_drawChainPickwhip(){
	
	var mouseLineX = undefined;
	var mouseLineY = undefined;
	var arrowSize = 0.3 + (0.1 * global.fontSize / 5);
	var justifyLeft = (obj_control.justify == obj_control.justifyLeft);

	if (obj_chain.currentFocusedChainID != "") {	
		if (mouseLineWordID != "") {
				
			var mouseLineTokenSubMap = global.nodeMap[?mouseLineWordID];
			var mouseLineTokenTagSubMap = mouseLineTokenSubMap[?"tagMap"];
			var mouseLineUnitId = mouseLineTokenSubMap[?"unit"];
			var mouseLineUnitSubMap = global.nodeMap[?mouseLineUnitId];
				
				
			var mouseLineWordStringWidth = string_width(string(mouseLineTokenTagSubMap[?global.displayTokenField]));
			var mouseLineWordStringHeight = string_height(string(mouseLineTokenTagSubMap[?global.displayTokenField]));
				
				
			var wordPixelX = mouseLineTokenSubMap[?"pixelX"];
			var wordPixelY = mouseLineUnitSubMap[?"pixelY"];
		
					
			if (is_numeric(wordPixelX) and is_numeric(wordPixelY)) {
				mouseLineX = wordPixelX + (mouseLineWordStringWidth / 2);
				mouseLineY = wordPixelY + (mouseLineWordStringHeight / 2);
				if (!justifyLeft) {
					mouseLineX -= mouseLineWordStringWidth;
				}
			}
		}
	}
	
	
	draw_set_alpha(1);


	// draw pickwhip line to mouse from chain
	var drawPickwhip = (is_numeric(mouseLineX) && is_numeric(mouseLineY) && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)
						&& obj_toolPane.currentMode != obj_toolPane.modeRead && !obj_chain.focusedChainWrongTool);
	
	if (drawPickwhip) {
		if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
			var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
			if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
				var chainType = chainSubMap[? "type"];
				var currentChainColor = chainSubMap[? "chainColor"];
				var currentChainVisible = chainSubMap[? "visible"];
				draw_set_color(currentChainColor);
			
				if (currentChainVisible) {
					if (not mouseLineHide) {
						if (chainType == "resonance") {
							draw_line_width(mouseLineX, mouseLineY, mouse_x, mouse_y, 3);
						}
						else if (chainType == "trail") {
							scr_drawCurvedLine(mouseLineX, mouseLineY, mouse_x, mouse_y, currentChainColor, 3);
						}
						if ((obj_chain.showRezArrows and chainType = "resonance") or (obj_chain.showTrackArrows and chainType = "trail")) {
							var arrowAngle = point_direction(mouseLineX, mouseLineY, mouse_x, mouse_y);
							if (chainType = "trail") arrowAngle = (mouseLineY < mouse_y) ? 270 : 90;
							draw_sprite_ext(spr_linkArrow, 1, mouse_x, mouse_y, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
						}
					}
				}
			}
		}
	}

}