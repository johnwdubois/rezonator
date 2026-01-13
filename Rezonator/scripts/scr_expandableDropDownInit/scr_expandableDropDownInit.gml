function scr_expandableDropDownInit() {
	
	// this map tells Rezonator what dropdowns expand to further dropdowns
	// so we can look up the strings in this map to know whether or not to draw the expand arrow
	global.expandableDropDownMap = ds_map_create();
	
	var deleteAllList = ds_list_create();
	ds_list_add(deleteAllList, global.optionListTypeEdit);
	ds_map_add_list(global.expandableDropDownMap, "menu_delete-all", deleteAllList);
	
	if (BUILDTYPE == "Web") {
		var openList = ds_list_create();
		ds_list_add(openList, global.optionListTypeFile);
		ds_map_add_list(global.expandableDropDownMap, "help_label_open", openList);
	}
	
	var windowList = ds_list_create();
	ds_list_add(windowList, global.optionListTypeView);
	ds_map_add_list(global.expandableDropDownMap, "menu_window", windowList);
	
	var navList = ds_list_create();
	ds_list_add(navList, global.optionListTypePane);
	ds_map_add_list(global.expandableDropDownMap, "menu_nav", navList);
	
	var justifyList = ds_list_create();
	ds_list_add(justifyList, global.optionListTypeView);
	ds_map_add_list(global.expandableDropDownMap, "menu_justify", justifyList);
	
	var proseList = ds_list_create();
	ds_list_add(proseList, global.optionListTypeView);
	ds_map_add_list(global.expandableDropDownMap, "menu_prose", proseList);
	
	var hideList = ds_list_create();
	ds_list_add(hideList, global.optionListTypeView);
	ds_map_add_list(global.expandableDropDownMap, "menu_hide", hideList);
	
	var pickList = ds_list_create();
	ds_list_add(pickList, global.optionListTypeFilter);
	ds_map_add_list(global.expandableDropDownMap, "menu_pick", pickList);
	
	var filterContextList = ds_list_create();
	ds_list_add(filterContextList, global.optionListTypeFilter);
	ds_map_add_list(global.expandableDropDownMap, "menu_filter-context", filterContextList);
	
	var stackerList = ds_list_create();
	ds_list_add(stackerList, global.optionListTypeTools);
	ds_map_add_list(global.expandableDropDownMap, "menu_stacker", stackerList);
	
	var zoomList = ds_list_create();
	ds_list_add(zoomList, global.optionListTypeSettings);
	ds_map_add_list(global.expandableDropDownMap, "menu_zoom", zoomList);
	
	var autosaveList = ds_list_create();
	ds_list_add(autosaveList, global.optionListTypeSettings);
	ds_map_add_list(global.expandableDropDownMap, "menu_autosave", autosaveList);
	
	var advancedList = ds_list_create();
	ds_list_add(advancedList, global.optionListTypeSettings);
	ds_map_add_list(global.expandableDropDownMap, "menu_advanced", advancedList);
	
	var languageList = ds_list_create();
	ds_list_add(languageList, global.optionListTypeSettings);
	ds_map_add_list(global.expandableDropDownMap, "menu_language", languageList);
	
	var recolorList = ds_list_create();
	ds_list_add(recolorList, global.optionListTypeChainList);
	ds_map_add_list(global.expandableDropDownMap, "option_recolor", recolorList);
	
	var textDirList = ds_list_create();
	ds_list_add(textDirList, global.optionListTypeView);
	ds_map_add_list(global.expandableDropDownMap, "text_dir", textDirList);
	
	var selectFieldList = ds_list_create();
	ds_list_add(selectFieldList, global.optionListTypeFieldUnits1ToMany,global.optionListTypeFieldUnits1To1,global.optionListTypeFieldChains1ToMany,global.optionListTypeFieldChains1To1);
	ds_map_add_list(global.expandableDropDownMap, "option_select-field", selectFieldList);
	
	var removeTagSetList = ds_list_create();
	ds_list_add(removeTagSetList, global.optionListTypeFieldUnits1ToMany,global.optionListTypeFieldUnits1To1,global.optionListTypeFieldChains1ToMany,global.optionListTypeFieldChains1To1);
	ds_map_add_list(global.expandableDropDownMap, "option-remove-tag-set", removeTagSetList);
	
	var arrHeadsList = ds_list_create();
	ds_list_add(arrHeadsList, global.optionListTypeView);
	ds_map_add_list(global.expandableDropDownMap, "arrheads", arrHeadsList);
	
	var tabNameTagList = ds_list_create();
	ds_list_add(tabNameTagList, global.optionListTypeRightClickWord, global.optionListTypeSpeakerLabel);
	ds_map_add_list(global.expandableDropDownMap, "tab_name_tag", tabNameTagList);
	
	var tagTokenList = ds_list_create();
	ds_list_add(tagTokenList, global.optionListTypeTag,global.optionListTypeSearchPane);
	ds_map_add_list(global.expandableDropDownMap, "Tag Token", tagTokenList);
	
	var tagChainList = ds_list_create();
	ds_list_add(tagChainList, global.optionListTypeTag);
	ds_map_add_list(global.expandableDropDownMap, "Tag Chain", tagChainList);
	
	var tagEntryList = ds_list_create();
	ds_list_add(tagEntryList, global.optionListTypeTag);
	ds_map_add_list(global.expandableDropDownMap, "Tag Entry", tagEntryList);
	
	var tagChunkList = ds_list_create();
	ds_list_add(tagChunkList, global.optionListTypeTag);
	ds_map_add_list(global.expandableDropDownMap, "Tag Chunk", tagChunkList);
	
	var tagUnitList = ds_list_create();
	ds_list_add(tagUnitList, global.optionListTypeTag);
	ds_map_add_list(global.expandableDropDownMap, "Tag Unit", tagUnitList);
	
	var newTokenList = ds_list_create();
	ds_list_add(newTokenList, global.optionListTypeRightClickWord);
	ds_map_add_list(global.expandableDropDownMap, "option_new-token", newTokenList);
	
	var addToShowList = ds_list_create();
	ds_list_add(addToShowList, global.optionListTypeChainListMulti,global.optionListTypeChainList);
	ds_map_add_list(global.expandableDropDownMap, "option_add-to-show", addToShowList);
	
	var tagLinkList = ds_list_create();
	ds_list_add(tagLinkList, global.optionListTypeTreeRightClick);
	ds_map_add_list(global.expandableDropDownMap, "Tag Link", tagLinkList);
	
	var addtotrailList = ds_list_create();
	ds_list_add(addtotrailList, global.optionListTypeSearchPane);
	ds_map_add_list(global.expandableDropDownMap, "Add to Trail", addtotrailList);
	
	var addtoRezList = ds_list_create();
	ds_list_add(addtoRezList, global.optionListTypeSearchPane);
	ds_map_add_list(global.expandableDropDownMap, "Add to Resonance", addtoRezList);
	
	var addEndnoteList = ds_list_create();
	ds_list_add(addEndnoteList, global.optionListTypeRightClickWord);
	ds_map_add_list(global.expandableDropDownMap, "Add endnote", addEndnoteList);
	
	// alexluu: https://github.com/johnwdubois/rezonator/issues/1517
	var addCompletionMarkList = ds_list_create();
	ds_list_add(addCompletionMarkList, global.optionListTypeRightClickWord);
	ds_map_add_list(global.expandableDropDownMap, "Add completion mark", addCompletionMarkList);

	var insertColumnList = ds_list_create();
	ds_list_add(insertColumnList, global.optionListTypeFieldUnits1ToMany, global.optionListTypeFieldUnits1To1, global.optionListTypeFieldChains1ToMany, global.optionListTypeFieldChains1To1);
	ds_map_add_list(global.expandableDropDownMap, "Insert column", insertColumnList);
	
	var hideChainsList = ds_list_create();
	ds_list_add(hideChainsList, global.optionListTypeView);
	ds_map_add_list(global.expandableDropDownMap, "menu_chains_pl", hideChainsList);
	
	var editList = ds_list_create();
	// ds_list_add(editList, global.optionListTypeRightClickWord, global.optionListTypeSpeakerLabel);
	// alexluu: https://github.com/johnwdubois/rezonator/issues/1516#issuecomment-3725485004
	ds_list_add(editList, global.optionListTypeSpeakerLabel);
	ds_map_add_list(global.expandableDropDownMap, "menu_edit", editList);
	

}