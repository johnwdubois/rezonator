// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_updateCheckMap(optionText){
	with(obj_dropDown){
		if(instance_exists(obj_wordTip)){
			if(optionText == "Word Tip" and obj_wordTip.wordTipDisplay == true){
				global.checkDropdownMap[?optionText] = true;
			}
		}	
		if(instance_exists(obj_control)){
			if(optionListType == global.optionListTypeTextDirection){
				if(optionText == "Right To Left" and obj_control.drawLineState == obj_control.lineState_rtl){
					ds_map_replace(global.checkDropdownMap, "Right To Left", true);
					ds_map_replace(global.checkDropdownMap, "Left To Right", false);
				}
				if(optionText == "Left To Right" and obj_control.drawLineState == obj_control.lineState_ltr){
					ds_map_replace(global.checkDropdownMap, "Right To Left", false);
					ds_map_replace(global.checkDropdownMap, "Left To Right", true);
				}
			}
			if(obj_control.justify == obj_control.justifyRight){
				ds_map_replace(global.checkDropdownMap, "menu_right", true);
				ds_map_replace(global.checkDropdownMap, "menu_left", false);
			}
			if(obj_control.justify == obj_control.justifyLeft){
				ds_map_replace(global.checkDropdownMap, "menu_right", false);
				ds_map_replace(global.checkDropdownMap, "menu_left", true);
			}
			if(obj_control.shape == obj_control.shapeBlock){
				ds_map_replace(global.checkDropdownMap, "menu_grid", true);
				ds_map_replace(global.checkDropdownMap, "menu_prose", false);
			}
			if(obj_control.shape == obj_control.shapeText and optionListType == global.optionListTypeProse){
				ds_map_replace(global.checkDropdownMap, "menu_grid", false);
				ds_map_replace(global.checkDropdownMap, "menu_prose", true);
			}
			
			
		}
		if(instance_exists(obj_chain)){
			if(obj_chain.showTrackArrows and obj_chain.showRezArrows){
				ds_map_replace(global.checkDropdownMap, "All", true);
				ds_map_replace(global.checkDropdownMap, "menu_track-arrows", false);
				ds_map_replace(global.checkDropdownMap, "menu_rez-arrows", false);
			}
			else{
				ds_map_replace(global.checkDropdownMap, "All", false);
				ds_map_replace(global.checkDropdownMap, "menu_track-arrows", obj_chain.showTrackArrows);
				ds_map_replace(global.checkDropdownMap, "menu_rez-arrows", obj_chain.showRezArrows);
			}
		}
		if(optionListType == global.optionListTypeHide and instance_exists(obj_chain)){
			ds_map_replace(global.checkDropdownMap, "menu_track", obj_chain.toggleDrawTrack);
			ds_map_replace(global.checkDropdownMap, "menu_resonance", obj_chain.toggleDrawRez);
			ds_map_replace(global.checkDropdownMap, "menu_stack", obj_chain.toggleDrawStack);
		}
		else if(optionListType == global.optionListTypeTools and instance_exists(obj_toolPane)){
			if(obj_toolPane.currentMode == obj_toolPane.modeRead){
				ds_map_replace(global.checkDropdownMap, "menu_track", false);
				ds_map_replace(global.checkDropdownMap, "menu_resonance", false);
				ds_map_replace(global.checkDropdownMap, "help_label_tag", true);
			}
			if(obj_toolPane.currentMode == obj_toolPane.modeRez){
				ds_map_replace(global.checkDropdownMap, "menu_track", false);
				ds_map_replace(global.checkDropdownMap, "menu_resonance", true);
				ds_map_replace(global.checkDropdownMap, "help_label_tag", false);
			}
			if(obj_toolPane.currentMode == obj_toolPane.modeTrack){
				ds_map_replace(global.checkDropdownMap, "menu_track", true);
				ds_map_replace(global.checkDropdownMap, "menu_resonance", false);
				ds_map_replace(global.checkDropdownMap, "help_label_tag", false);
			}
		}
		switch(global.autosaveTimerFull)
		{
			case -1:
				ds_map_replace(global.checkDropdownMap, "menu_off", true);
				ds_map_replace(global.checkDropdownMap, "menu_5-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_10-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_20-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_30-min", false);
				break;
			case 300:
				ds_map_replace(global.checkDropdownMap, "menu_off", false);
				ds_map_replace(global.checkDropdownMap, "menu_5-min", true);
				ds_map_replace(global.checkDropdownMap, "menu_10-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_20-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_30-min", false);
				break;
			case 600:
				ds_map_replace(global.checkDropdownMap, "menu_off", false);
				ds_map_replace(global.checkDropdownMap, "menu_5-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_10-min", true);
				ds_map_replace(global.checkDropdownMap, "menu_20-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_30-min", false);
				break;
			case 1200:
				ds_map_replace(global.checkDropdownMap, "menu_off", false);
				ds_map_replace(global.checkDropdownMap, "menu_5-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_10-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_20-min", true);
				ds_map_replace(global.checkDropdownMap, "menu_30-min", false);
				break;
			case 1800:
				ds_map_replace(global.checkDropdownMap, "menu_off", false);
				ds_map_replace(global.checkDropdownMap, "menu_5-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_10-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_20-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_30-min", true);
				break;
			default:
				ds_map_replace(global.checkDropdownMap, "menu_off", false);
				ds_map_replace(global.checkDropdownMap, "menu_5-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_10-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_20-min", false);
				ds_map_replace(global.checkDropdownMap, "menu_30-min", false);
				break;
		}
		if(string_pos("menu_language-", optionText) == 1){
			var currentLangCode = string_copy(optionText, 1, string_length(optionText));
			currentLangCode = string_delete(currentLangCode, 1, string_length("menu_language-"));
			if(currentLangCode == global.lang_codes[| global.lang_index]){
				ds_map_replace(global.checkDropdownMap, optionText, true);
			}
			else{
				ds_map_replace(global.checkDropdownMap, optionText, false);
			}
		}
	}
}