/*
	
	Purpose: draws the speaker labels to the left of the units in the discourse
	
*/
function scr_drawSpeakerLabel(unitID, unitSubMap, pixelY) {
	
	
	// get y coordinates for this speaker label
	var sectionRectY1 = pixelY - (gridSpaceVertical * 0.5);
	var sectionRectY2 = sectionRectY1 + gridSpaceVertical;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	var spaceWidth = string_width("  ");
	
	// get tag map for this unit
	var tagMap = unitSubMap[? "tagMap"];
	if (!scr_isNumericAndExists(tagMap, ds_type_map)) exit;
	
	// draw each section of speaker label
	var plusX = 0;
	var speakerLabelColXListSize = ds_list_size(speakerLabelColXList);
	for (var i = 0; i < speakerLabelColXListSize; i++) {
		
		// get x coordinates for this speaker label
		var sectionRectX1 = plusX;
		var sectionRectX2 = speakerLabelColXList[| i];
		
		// get rectangle color
		var sectionColor = global.colorThemeSelected1;
		if (i == 1) sectionColor = unitSubMap[? "speakerColor"];
		
		// draw rectangle
		draw_set_color(sectionColor);
		draw_rectangle(sectionRectX1, sectionRectY1, sectionRectX2, sectionRectY2, false);
		
		// get section text
		var sectionText = "";
		if (i == 0) sectionText = string(unitSubMap[? "unitSeq"]);
		else if (i == 1) sectionText = string(tagMap[? global.speakerField]);
		
		// cut off section text if its too long
		var cutoffs = 0;
		while (string_width(sectionText + "... ") + spaceWidth > (sectionRectX2 - sectionRectX1) and cutoffs < 100) {
			sectionText = string_delete(sectionText, string_length(sectionText), 1);
			cutoffs++;
		}
		if (cutoffs > 0) {
			sectionText += "... ";
		}
		
		
		// draw section text
		sectionText = scr_adaptFont(sectionText, "M");
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_left);
		if(obj_control.drawLineState == obj_control.lineState_ltr){
			draw_text(floor(sectionRectX1 + spaceWidth), floor(pixelY), sectionText);
		}
		else{
			draw_set_halign(fa_right);
			draw_text(floor(sectionRectX2 - spaceWidth - string_length(sectionText)), floor(pixelY), sectionText);
			
		}
		draw_set_halign(fa_left);
		// if this is the last section, let's draw a horizontal line to divide units
		if (i == speakerLabelColXListSize - 1) {
			draw_set_color(global.colorThemeBG);
			draw_line(0, sectionRectY2 - 2, sectionRectX2, sectionRectY2 - 2);
		}
		

		
		plusX += sectionRectX2;
		
	}
	
	
	var mouseOverCurrentSpeakerLabel = (point_in_rectangle(mouse_x,mouse_y,0,sectionRectY1,wordLeftMargin,sectionRectY2));
	if (mouseOverCurrentSpeakerLabel) {
		obj_control.mouseoverSpeakerLabel = true;
		obj_control.hoverUnitID = unitID;
	}


	
	// click on speaker label
	if (device_mouse_check_button_released(0, mb_left) and mouseOverCurrentSpeakerLabel and
	touchReleaseCheck and !obj_control.speakerLabelHoldingDelay and ds_list_size(inRectUnitIDList) <= 1 and 
	!obj_control.mouseoverPanelPane and !instance_exists(obj_dialogueBox)) {
		if (obj_control.ctrlHold) {
			// combine chains
			var inChainsList = unitSubMap[?"inChainsList"];
			scr_combineChainsDrawLine(inChainsList);
		}
		else {
			
			// if there is a focused chain that is not a stack, deselect it
			var focusedChainIDSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
			if (scr_isNumericAndExists(focusedChainIDSubMap, ds_type_map)) {
				var focusedChainType = focusedChainIDSubMap[? "type"];
				if (focusedChainType != "stackChain") {
					scr_chainDeselect();
				}
			}
			
			with (obj_chain) {
				scr_unitClicked(unitID);
			}
		}
	}
	
		// Check for rightMouseClick
	if (device_mouse_check_button_released(0, mb_right) and mouseOverCurrentSpeakerLabel and !instance_exists(obj_dialogueBox)) {
				
		obj_control.rightClickID = unitID;
	
		// wait 1 frame and then show the right click dropdown
		with (obj_alarm) {
			alarm[11] = 2;
		}

	}
	
	
}
