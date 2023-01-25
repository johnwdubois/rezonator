function scr_updateCheckMap(optionText) {
	with (obj_dropDown) {
		if (instance_exists(obj_wordTip)) {
			if (optionText == "word_tip") {
				global.checkDropdownMap[? optionText] = obj_wordTip.wordTipDisplay;
			}
			else if (optionText == "unit_tip") {
				global.checkDropdownMap[? optionText] = obj_wordTip.unitTipDisplay;
			}
		}	
		if (instance_exists(obj_control)) {
			if (optionListType == global.optionListTypeTextDirection) {
				if (optionText == "menu_right-to-left" and obj_control.drawLineState == obj_control.lineState_rtl) {
					global.checkDropdownMap[? "menu_right-to-left"] = true;
					global.checkDropdownMap[? "menu_left-to-right"] = false;
				}
				if (optionText == "menu_left-to-right" and obj_control.drawLineState == obj_control.lineState_ltr) {
					global.checkDropdownMap[? "menu_right-to-left"] = false;
					global.checkDropdownMap[? "menu_left-to-right"] = true;
				}
			}
			if (obj_control.justify == obj_control.justifyRight) {
				global.checkDropdownMap[? "menu_right"] = true;
				global.checkDropdownMap[? "menu_left"] = false;
			}
			if (obj_control.justify == obj_control.justifyLeft) {
				global.checkDropdownMap[? "menu_right"] = false;
				global.checkDropdownMap[? "menu_left"] = true;
			}
			if (obj_control.shape == obj_control.shapeBlock) {
				global.checkDropdownMap[? "menu_grid"] = true;
				global.checkDropdownMap[? "menu_prose"] = false;
			}
			if (obj_control.shape == obj_control.shapeText and optionListType == global.optionListTypeProse) {
				global.checkDropdownMap[? "menu_grid"] = false;
				global.checkDropdownMap[? "menu_prose"] = true;
			}
			
			if (optionText == "tab_name_chunk") {
				global.checkDropdownMap[? optionText] = !obj_control.hideChunks;
			}
			if (optionListType == global.optionListTypeHide) {
				show_debug_message("here!!!!!!!!");
				if (optionText == "menu_resonance") {
					var resonanceList = global.nodeMap[? "resonanceList"];
					global.checkDropdownMap[? "menu_resonance"] = (ds_list_size(resonanceList) != ds_list_size(obj_control.hiddenRezChainList) || ds_list_size(resonanceList) < 1);
				}
				else if (optionText == "menu_track") {
					var trailList = global.nodeMap[? "trailList"];
					global.checkDropdownMap[? "menu_track"] = (ds_list_size(trailList) != ds_list_size(obj_control.hiddenTrackChainList) || ds_list_size(trailList) < 1);
				}
				else if (optionText == "menu_stack") {
					var stackList = global.nodeMap[? "stackList"];
					global.checkDropdownMap[? "menu_stack"] = (ds_list_size(stackList) != ds_list_size(obj_control.hiddenStackChainList) || ds_list_size(stackList) < 1);
				}
			}
		}
		if (instance_exists(obj_panelPane)) {
			if (optionListType == global.optionListTypeHelp) {
				global.checkDropdownMap[? "menu_help"] = !obj_panelPane.functionHelp_collapsed;
			}
			else if (optionListType == global.optionListTypeView) {
				global.checkDropdownMap[? "menu_navigation"] = obj_panelPane.showNav;
				global.checkDropdownMap[? "menu_toolbar"] = obj_toolPane.showTool;
			}
		}
		
		
		if (instance_exists(obj_chain)) {
			global.checkDropdownMap[? "menu_track-arrows"] = obj_chain.showTrackArrows;
			global.checkDropdownMap[? "menu_rez-arrows"] = obj_chain.showRezArrows;
			
		}
		if (optionListType == global.optionListTypeTools and instance_exists(obj_toolPane)) {

			if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
				global.checkDropdownMap[? "menu_track"] = false;
				global.checkDropdownMap[? "menu_resonance"] = false;
				global.checkDropdownMap[? "help_label_tag"] = true;
			}
			if (obj_toolPane.currentMode == obj_toolPane.modeRez) {
				global.checkDropdownMap[? "menu_track"] = false;
				global.checkDropdownMap[? "menu_resonance"] = true;
				global.checkDropdownMap[? "help_label_tag"] = false;
			}
			if (obj_toolPane.currentMode == obj_toolPane.modeTrack) {
				global.checkDropdownMap[? "menu_track"] = true;
				global.checkDropdownMap[? "menu_resonance"] = false;
				global.checkDropdownMap[? "help_label_tag"] = false;
			}
		}
		switch(global.autosaveTimerFull)
		{
			case -1:
				global.checkDropdownMap[? "menu_off"] = true;
				global.checkDropdownMap[? "menu_5-min"] = false;
				global.checkDropdownMap[? "menu_10-min"] = false;
				global.checkDropdownMap[? "menu_20-min"] = false;
				global.checkDropdownMap[? "menu_30-min"] = false;
				break;
			case 300:
				global.checkDropdownMap[? "menu_off"] = false;
				global.checkDropdownMap[? "menu_5-min"] = true;
				global.checkDropdownMap[? "menu_10-min"] = false;
				global.checkDropdownMap[? "menu_20-min"] = false;
				global.checkDropdownMap[? "menu_30-min"] = false;
				break;
			case 600:
				global.checkDropdownMap[? "menu_off"] = false;
				global.checkDropdownMap[? "menu_5-min"] = false;
				global.checkDropdownMap[? "menu_10-min"] = true;
				global.checkDropdownMap[? "menu_20-min"] = false;
				global.checkDropdownMap[? "menu_30-min"] = false;
				break;
			case 1200:
				global.checkDropdownMap[? "menu_off"] = false;
				global.checkDropdownMap[? "menu_5-min"] = false;
				global.checkDropdownMap[? "menu_10-min"] = false;
				global.checkDropdownMap[? "menu_20-min"] = true;
				global.checkDropdownMap[? "menu_30-min"] = false;
				break;
			case 1800:
				global.checkDropdownMap[? "menu_off"] = false;
				global.checkDropdownMap[? "menu_5-min"] = false;
				global.checkDropdownMap[? "menu_10-min"] = false;
				global.checkDropdownMap[? "menu_20-min"] = false;
				global.checkDropdownMap[? "menu_30-min"] = true;
				break;
			default:
				global.checkDropdownMap[? "menu_off"] = false;
				global.checkDropdownMap[? "menu_5-min"] = false;
				global.checkDropdownMap[? "menu_10-min"] = false;
				global.checkDropdownMap[? "menu_20-min"] = false;
				global.checkDropdownMap[? "menu_30-min"] = false;
				break;
		}
		if (string_pos("menu_language-", optionText) == 1) {
			var currentLangCode = string_copy(optionText, 1, string_length(optionText));
			currentLangCode = string_delete(currentLangCode, 1, string_length("menu_language-"));
			if (currentLangCode == global.lang_codes[| global.lang_index]) {
				global.checkDropdownMap[? optionText] = true;
			}
			else{
				global.checkDropdownMap[? optionText] = false;
			}
		}
	}
}