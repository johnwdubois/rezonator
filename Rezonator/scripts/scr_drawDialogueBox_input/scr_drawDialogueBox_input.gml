function scr_drawDialogueBox_input() {

	// draw title text
	if (!instance_exists(obj_inputBox)) {
		instance_create_layer(0,0,"InstancesInput", obj_inputBox);
	}
	with (obj_inputBox) {
		textBoxX = floor(obj_dialogueBox.boxRectX1 + (obj_dialogueBox.boxWidth * 0.1));
		
		if (obj_dialogueBox.descriptionText != "") {
			textBoxY = floor(obj_dialogueBox.boxRectY1 + (obj_dialogueBox.boxHeight * 0.42));
		}
		else {
			textBoxY = floor(obj_dialogueBox.boxRectY1 + (obj_dialogueBox.boxHeight * 0.22));
		}
		windowWidth = obj_dialogueBox.boxWidth * 0.8;
		
	}
	obj_control.inputText = obj_inputBox.str;
	
	var largestPixelY = 0;
	
	
	// UI for search control
	var dropDownHeight = string_height("0");
	var dropDownXBuffer = 10;
	var checkboxSize = dropDownHeight * 0.7;
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	if (obj_control.fPressed) {
		
		// description text
		if (instance_exists(obj_inputBox)) {
			var strLen = string_length(obj_inputBox.str);
			if (strLen < 1) {
				var descTextX = obj_inputBox.textBoxX + (dropDownXBuffer * 2);
				var descTextY = floor(mean(obj_inputBox.textBoxY, obj_inputBox.textBoxY + obj_inputBox.windowHeight));
				var descText = scr_get_translation("search_dialogue_word");
				draw_set_color(global.colorThemeSelected2);
				draw_set_halign(fa_left);
				scr_adaptFont(descText, "S", false);
				draw_set_alpha(1);
				draw_text(descTextX, descTextY, descText);
			}
		}
		
		// field rect
		var fieldRectX1 = boxRectX1 + (boxWidth * 0.25);
		var fieldRectY1 = obj_inputBox.textBoxY + obj_inputBox.windowHeight + dropDownXBuffer;
		var fieldRectX2 = boxRectX1 + (boxWidth * 0.75);
		var fieldRectY2 = fieldRectY1 + dropDownHeight;
		var mouseoverFieldRect = point_in_rectangle(mouse_x, mouse_y, fieldRectX1, fieldRectY1, fieldRectX2, fieldRectY2) && !instance_exists(obj_dropDown);
		draw_set_color(mouseoverFieldRect ? global.colorThemeSelected1 : global.colorThemeBG);
		draw_rectangle(fieldRectX1, fieldRectY1, fieldRectX2, fieldRectY2, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(fieldRectX1, fieldRectY1, fieldRectX2, fieldRectY2, true);
		
		// click field dropdown
		if (mouseoverFieldRect && mouse_check_button_released(mb_left)) {
			var tokenFieldListCopy = ds_list_create();
			ds_list_copy(tokenFieldListCopy, obj_control.tokenFieldList);
			scr_createDropDown(fieldRectX1, fieldRectY2, tokenFieldListCopy, global.optionListTypeSearchField);
		}
		if (string_length(obj_control.searchField) < 1) {
			obj_control.searchField = global.displayTokenField;
		}
		
		// field text
		draw_set_color(global.colorThemeText);
		scr_adaptFont(obj_control.searchField, "S", false);
		draw_set_halign(fa_left);
		scr_adaptFont(obj_control.searchField, "S", false);
		draw_text(floor(fieldRectX1 + dropDownXBuffer), floor(mean(fieldRectY1, fieldRectY2)), obj_control.searchField);
		draw_set_halign(fa_right);
		scr_adaptFont(scr_get_translation("option_field"), "S", false);
		draw_text(floor(fieldRectX1 - dropDownXBuffer), floor(mean(fieldRectY1, fieldRectY2)), scr_get_translation("option_field")+": ");
		
		// range rect
		var rangeRectX1 = boxRectX1 + (boxWidth * 0.25);
		var rangeRectY1 = fieldRectY2 + dropDownXBuffer;
		var rangeRectX2 = boxRectX1 + (boxWidth * 0.75);
		var rangeRectY2 = rangeRectY1 + dropDownHeight;
		var mouseoverRangeRect = point_in_rectangle(mouse_x, mouse_y, rangeRectX1, rangeRectY1, rangeRectX2, rangeRectY2) && !instance_exists(obj_dropDown);
		draw_set_color(mouseoverRangeRect ? global.colorThemeSelected1 : global.colorThemeBG);
		draw_rectangle(rangeRectX1, rangeRectY1, rangeRectX2, rangeRectY2, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(rangeRectX1, rangeRectY1, rangeRectX2, rangeRectY2, true);
		
		// click range dropdown
		if (mouseoverRangeRect && mouse_check_button_released(mb_left)) {
			var availableRanges = ds_list_create();
			ds_list_add(availableRanges, "option_doc", "option_current-chain", "option_trails", "menu_rez_chains_pl", "menu_stacks_pl");
			scr_createDropDown(rangeRectX1, rangeRectY2, availableRanges, global.optionListTypeSearchRange);
		}
		
		// range text
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_left);
		scr_adaptFont(scr_get_translation(obj_control.searchRange), "S", false);
		draw_text(floor(rangeRectX1 + dropDownXBuffer), floor(mean(rangeRectY1, rangeRectY2)), scr_get_translation(obj_control.searchRange));
		draw_set_halign(fa_right);
		scr_adaptFont(scr_get_translation("option_range"), "S", false);
		draw_text(floor(rangeRectX1 - dropDownXBuffer), floor(mean(rangeRectY1, rangeRectY2)), scr_get_translation("option_range")+": ");
		
		
		// regex checkbox
		/*
		var regexCheckboxX1 = obj_inputBox.textBoxX;
		var regexCheckboxY1 = rangeRectY2 + dropDownXBuffer;
		var regexCheckboxX2 = regexCheckboxX1 + checkboxSize;
		var regexCheckboxY2 = regexCheckboxY1 + checkboxSize;
		var mouseoverRegexCheckbox = point_in_rectangle(mouse_x, mouse_y, regexCheckboxX1, regexCheckboxY1, regexCheckboxX2, regexCheckboxY2) && !instance_exists(obj_dropDown);
		if (mouseoverRegexCheckbox && mouse_check_button_released(mb_left)) obj_control.regExCheck = !obj_control.regExCheck;
		if (obj_control.regExCheck) draw_sprite_ext(spr_checkmark, 0, mean(regexCheckboxX1, regexCheckboxX2), mean(regexCheckboxY1, regexCheckboxY2), 1, 1, 0, global.colorThemeText, 1);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(regexCheckboxX1, regexCheckboxY1, regexCheckboxX2, regexCheckboxY2, true);
		largestPixelY = regexCheckboxY2;
		
		// regex text
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_left);
		scr_adaptFont(scr_get_translation("search_dialogue_regEx"), "M");
		draw_text(floor(regexCheckboxX2 + checkboxSize), floor(mean(regexCheckboxY1, regexCheckboxY2)), scr_get_translation("search_dialogue_regEx"));
		*/

		
		if (!obj_control.regExCheck) {
			// case-sensitive checkbox
			var caseCheckboxX1 = obj_inputBox.textBoxX;
			var caseCheckboxY1 = rangeRectY2 + dropDownXBuffer;
			var caseCheckboxX2 = caseCheckboxX1 + checkboxSize;
			var caseCheckboxY2 = caseCheckboxY1 + checkboxSize;
			var mouseoverCaseCheckbox = point_in_rectangle(mouse_x, mouse_y, caseCheckboxX1, caseCheckboxY1, caseCheckboxX2, caseCheckboxY2) && !instance_exists(obj_dropDown);
			if (mouseoverCaseCheckbox && mouse_check_button_released(mb_left)) obj_control.caseSensitive = !obj_control.caseSensitive;
			if (obj_control.caseSensitive) draw_sprite_ext(spr_checkmark, 0, mean(caseCheckboxX1, caseCheckboxX2), mean(caseCheckboxY1, caseCheckboxY2), 1, 1, 0, global.colorThemeText, 1);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(caseCheckboxX1, caseCheckboxY1, caseCheckboxX2, caseCheckboxY2, true);
			largestPixelY = caseCheckboxY2;
		
			// case-sensitive text
			draw_set_color(global.colorThemeText);
			draw_set_halign(fa_left);
			scr_adaptFont(scr_get_translation("search_dialogue_case"), "M");
			draw_text(floor(caseCheckboxX2 + checkboxSize), floor(mean(caseCheckboxY1, caseCheckboxY2)), scr_get_translation("search_dialogue_case"));
		}
		
		draw_set_valign(fa_top);
		var explanationText = "Use & to search multiple terms";
		draw_text(floor(caseCheckboxX2 + checkboxSize), largestPixelY, explanationText);
	}
	
	if (obj_control.newWordCreated) {
			
		var insertBeforeBoxRectX1 = obj_inputBox.textBoxX;
		var insertBeforeBoxRectY1 = obj_inputBox.textBoxY + obj_inputBox.windowHeight + dropDownXBuffer;
		var insertBeforeBoxRectX2 = insertBeforeBoxRectX1 + checkboxSize;
		var insertBeforeBoxRectY2 = insertBeforeBoxRectY1 + checkboxSize;
	
		var insertBeforeBoleanTextX = floor(insertBeforeBoxRectX2 + checkboxSize);
		var insertBeforeBoleanTextY = floor(mean(insertBeforeBoxRectY1,insertBeforeBoxRectY2));
	
		// draw boolean option check boxes
		draw_set_colour(global.colorThemeText);
		draw_set_halign(fa_left);
		scr_adaptFont(scr_get_translation("msg_insert_before"), "S");
		draw_text(insertBeforeBoleanTextX, insertBeforeBoleanTextY , scr_get_translation("msg_insert_before"));
		
		draw_rectangle(insertBeforeBoxRectX1, insertBeforeBoxRectY1, insertBeforeBoxRectX2, insertBeforeBoxRectY2, true);
		if (obj_control.before) {
			draw_sprite_ext(spr_checkmark, 0, mean(insertBeforeBoxRectX1, insertBeforeBoxRectX2), mean(insertBeforeBoxRectY1, insertBeforeBoxRectY2), 1, 1, 0, global.colorThemeText, 1);
		}
		
		// insert before boolean switch
		if (point_in_rectangle(mouse_x, mouse_y, insertBeforeBoxRectX1, insertBeforeBoxRectY1, insertBeforeBoxRectX2, insertBeforeBoxRectY2)) {
			if (mouse_check_button_pressed(mb_left)) {
				obj_control.before = !obj_control.before;
			}
		}
	
	}
	
	
	if (instance_exists(obj_control)) {
		if (obj_control.splitToken) {
			
			// field rect
			var fieldRectX1 = boxRectX1 + (boxWidth * 0.25);
			var fieldRectY1 = obj_inputBox.textBoxY + obj_inputBox.windowHeight + dropDownXBuffer;
			var fieldRectX2 = boxRectX1 + (boxWidth * 0.75);
			var fieldRectY2 = fieldRectY1 + dropDownHeight;
			var mouseoverFieldRect = point_in_rectangle(mouse_x, mouse_y, fieldRectX1, fieldRectY1, fieldRectX2, fieldRectY2) && !instance_exists(obj_dropDown);
			draw_set_color(mouseoverFieldRect ? global.colorThemeSelected1 : global.colorThemeBG);
			draw_rectangle(fieldRectX1, fieldRectY1, fieldRectX2, fieldRectY2, false);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(fieldRectX1, fieldRectY1, fieldRectX2, fieldRectY2, true);
		
			// click field dropdown
			if (mouseoverFieldRect && mouse_check_button_released(mb_left)) {
				var tokenFieldListCopy = ds_list_create();
				ds_list_copy(tokenFieldListCopy, obj_control.tokenFieldList);
				scr_createDropDown(fieldRectX1, fieldRectY2, tokenFieldListCopy, global.optionListTypeSplitTokenField);
			}
			
			// field text
			draw_set_color(global.colorThemeText);
			scr_adaptFont(obj_control.splitTokenField, "S", false);
			draw_set_halign(fa_left);
			scr_adaptFont(obj_control.splitTokenField, "S", false);
			draw_text(floor(fieldRectX1 + dropDownXBuffer), floor(mean(fieldRectY1, fieldRectY2)), obj_control.splitTokenField);
			draw_set_halign(fa_right);
			scr_adaptFont(scr_get_translation("option_field"), "S", false);
			draw_text(floor(fieldRectX1 - dropDownXBuffer), floor(mean(fieldRectY1, fieldRectY2)), scr_get_translation("option_field")+": ");
			
			
			
			// copy tags checkbox
			var copyTagsCheckboxX1 = obj_inputBox.textBoxX;
			var copyTagsCheckboxY1 = fieldRectY2 + dropDownXBuffer;
			var copyTagsCheckboxX2 = copyTagsCheckboxX1 + checkboxSize;
			var copyTagsCheckboxY2 = copyTagsCheckboxY1 + checkboxSize;
			var mouseoverCopyTagsCheckbox = point_in_rectangle(mouse_x, mouse_y, copyTagsCheckboxX1, copyTagsCheckboxY1, copyTagsCheckboxX2, copyTagsCheckboxY2) && !instance_exists(obj_dropDown);
			if (mouseoverCopyTagsCheckbox && mouse_check_button_released(mb_left)) obj_control.splitTokenCopyTags = !obj_control.splitTokenCopyTags;
			if (obj_control.splitTokenCopyTags) draw_sprite_ext(spr_checkmark, 0, mean(copyTagsCheckboxX1, copyTagsCheckboxX2), mean(copyTagsCheckboxY1, copyTagsCheckboxY2), 1, 1, 0, global.colorThemeText, 1);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(copyTagsCheckboxX1, copyTagsCheckboxY1, copyTagsCheckboxX2, copyTagsCheckboxY2, true);
			largestPixelY = copyTagsCheckboxY2;
		
			// copy tags text
			draw_set_color(global.colorThemeText);
			draw_set_halign(fa_left);
			scr_adaptFont("Copy tags: ", "M"); // localize
			draw_text(floor(copyTagsCheckboxX2 + checkboxSize), floor(mean(copyTagsCheckboxY1, copyTagsCheckboxY2)), "Copy tags"); // localize
		}
	}



}