function scr_getDropDownWidth() {
	
	var maxWidth = originalWindowWidth;
	var arrowScale = 0.35;

	// loop through list to get windowWidth
	var optionListSize = ds_list_size(optionList);
	for (var i = 0; i < optionListSize; i++) {
		
		// get width of option string
		var currentOptionRaw = optionList[| i];		
		var currentOptionTranslated = scr_getDropDownOptionStr(currentOptionRaw);
		var currentOptionShortcut = scr_getDropDownShortcutStr(currentOptionRaw);
		var currentOptionTag = scr_getDropDownTagStr(currentOptionRaw);
		
		var currentOptionFull = currentOptionTranslated + "  " + currentOptionShortcut + "  " + currentOptionTag;
		
		scr_adaptFont(currentOptionFull, "M");
		var currentWidth = string_width(currentOptionFull);
		
		// add some width if its expandable
		if (scr_checkExpandable(currentOptionRaw, optionListType)) {
			currentWidth += sprite_get_width(spr_linkArrow) * arrowScale;
		}
		
		// update maxWidth
		maxWidth = max(maxWidth, currentWidth);
	}
	
	return maxWidth;
	
}