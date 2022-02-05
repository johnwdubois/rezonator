function scr_getDropDownShortcutStr(option){
	
	var shortcutStr = "";
	if(ds_map_exists(global.keyboardShortcutMap, option)){
		shortcutStr = global.keyboardShortcutMap[? option];	
	}
	
	
	if(option == "menu_grid" and optionListType != global.optionListTypePane){
		shortcutStr = "";
	}
	else if(option == "menu_search" and optionListType != global.optionListTypePane){
		shortcutStr = "";
	}
	else if((option == "menu_resonance" or option == "menu_track") and optionListType != global.optionListTypeTools){
		shortcutStr = "";	
	}
	else if(option == "menu_prose" and optionListType != global.optionListTypeView){
		shortcutStr = "";	
	}
	
	return shortcutStr
}