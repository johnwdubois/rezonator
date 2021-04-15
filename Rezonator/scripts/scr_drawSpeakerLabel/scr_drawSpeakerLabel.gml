/*
	
	Purpose: draws the speaker labels to the left of the units in the discourse
	
*/
function scr_drawSpeakerLabel(unitSubMap, pixelY) {

	
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
		
		// draw rectangle
		draw_set_color(i == 0 ? c_blue : c_red);
		draw_rectangle(sectionRectX1, sectionRectY1, sectionRectX2, sectionRectY2, false);
		
		// get section text
		var sectionText = "";
		if (i == 0) sectionText = string(unitSubMap[? "unitSeq"]);
		else if (i == 1) sectionText = string(tagMap[? "~Participant"]);
		
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
		draw_set_color(global.colorThemeText);
		draw_text(floor(sectionRectX1 + spaceWidth), floor(pixelY), sectionText);
		
		// if this is the last section, let's draw a horizontal line to divide units
		if (i == speakerLabelColXListSize - 1) {
			draw_set_color(global.colorThemeBG);
			draw_line(0, sectionRectY2 - 2, sectionRectX2, sectionRectY2 - 2);
		}
		
		plusX += sectionRectX2;
	}
	
	

	
	

	
	
	
	
	/*
	participantColor = (is_undefined(participantColor)) ? c_gray : participantColor;
	discoColor = global.colorThemeSelected1;


	// draw speaker label parts
	for (var i = 0; i < 3; i++) {
		if (!obj_control.showLineNumber and i != 2) {
			continue;
		}
		if (!obj_control.showSpeakerName and i == 2) {
			continue;
		}
		
		var speakerLabelCurrentColX1 = ds_list_find_value(obj_control.speakerLabelColXList, i);
		var speakerLabelCurrentColY1 = speakerRectY1;
		var speakerLabelCurrentColX2 = ds_list_find_value(obj_control.speakerLabelColXList, i + 1);
		var speakerLabelCurrentColY2 = speakerRectY2;
		
		
		draw_set_color((i == 2) ? participantColor: discoColor);
		draw_rectangle(speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2, false);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2, true);
		
		var speakerLabelCurrentColStr = "";
		if (i == 0 and currentDiscoID != undefined) {
			speakerLabelCurrentColStr = (ds_grid_height(global.fileLineRipGrid) < 2) ? "" : string(currentDiscoID);
		}
		else if (i == 1 and currentLineNumberLabel != undefined) {
			speakerLabelCurrentColStr = "  " + string(currentLineNumberLabel);
		}
		
		if (i == 2 and participantName != undefined) {
			speakerLabelCurrentColStr = "  " + string(participantName);
		
			var speakerNameColWidth = ds_list_find_value(obj_control.speakerLabelColXList, 3) - ds_list_find_value(obj_control.speakerLabelColXList, 2);
			var cutoffs = 0;
			while (string_width(speakerLabelCurrentColStr + "... ") > speakerNameColWidth and cutoffs < 100) {
				speakerLabelCurrentColStr = string_delete(speakerLabelCurrentColStr, string_length(speakerLabelCurrentColStr), 1);
				cutoffs++;
			}
			if (cutoffs > 0) {
				speakerLabelCurrentColStr += "... ";
			}
		}
		
		if (point_in_rectangle(mouse_x, mouse_y,speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2)
		and not instance_exists(obj_dialogueBox)  and not instance_exists(obj_dropDown) and !obj_control.mouseoverPanelPane) {
			obj_control.mouseoverSpeakerLabel = true;
			
			if(mouse_check_button_pressed(mb_right)) {
				//show_message("clicked here" + string(drawLineLoop));
				
				var dropDownOptionList = ds_list_create();
			
				obj_control.swapLinePos1 = unitID;
				if(obj_control.searchGridActive or obj_control.filterGridActive or obj_toolPane.currentMode == obj_toolPane.modeRead){
					obj_control.ableToCreateDropDown = false;
				}
				else{
					ds_list_add(dropDownOptionList, "Swap", "Shuffle", "Reset Order");
				}

				if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
					scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeSpeakerLabel);
				}
			}
			
		}
		draw_set_color(global.colorThemeText);
		speakerLabelCurrentColStr = scr_adaptFont(speakerLabelCurrentColStr,"M");
		
		
		// get position of column text
		var halign = fa_left;
		var speakerLabelTextX = speakerLabelCurrentColX1 + speakerLabelTextBuffer;
		var speakerLabelTextY = mean(speakerLabelCurrentColY1, speakerLabelCurrentColY2);
		if (i == 2 and participantName != undefined) {
			if (obj_control.drawLineState == obj_control.lineState_rtl) {
				speakerLabelTextX = speakerLabelCurrentColX2 - speakerLabelTextBuffer;
				halign = fa_right;
			}
		}
		
		// draw text
		draw_set_halign(halign);
		draw_text(speakerLabelTextX, speakerLabelTextY, speakerLabelCurrentColStr);
		
	}
	*/

}
