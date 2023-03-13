/*
	Purpose: draw custom drop down menu with multiple options
*/
function scr_dropDownSelect(optionSelected) {

	//optionListType == 0 --> switch sorting columns for sort pane


	//chainListEdit
	if (optionListType == global.optionListTypeChainList) //1
	{
	    scr_chainListOptions(optionSelected);
	}
	//chainRecolor
	else if (optionListType == global.optionListTypeChainRecolor) //2
	{
	    scr_chainRecolorOptions(optionSelected);
	    
	}
	//speakerLabelEdit
	else if (optionListType == global.optionListTypeSpeakerLabel) //3
	{
	    scr_speakerLabelOptions(optionSelected);
	}
	//fileOptions
	else if (optionListType == global.optionListTypeFile) //4
	{
	    scr_fileOptions(optionSelected);
	}
	// advancedOptions
	else if (optionListType == global.optionListTypeAdvanced) //5
	{
	    scr_advancedOptions(optionSelected);
	  //  instance_destroy();
	}

	//viewOptions
	else if (optionListType == global.optionListTypeView) //6
	{
	    scr_viewOptions(optionSelected);
	}
	//searchOptions
	else if (optionListType == global.optionListTypeSearch) //7
	{
	    scr_searchOptions(optionSelected);
	    instance_destroy();
	}
	//right click on word options
	else if (optionListType == global.optionListTypeRightClickWord) //8
	{
	    scr_rightClickWordOptions(optionSelected);
	}
	//newWordOptions
	else if (optionListType == global.optionListTypeNewWord) //11
	{
	    scr_newTokenOptions(optionSelected);
	}

	//mappingTagOptions
	else if (optionListType == global.optionListTypeMappingTag) //12
	{
	    scr_mappingTagOptions(optionSelected);
	}

	//zoomOptions
	else if (optionListType == global.optionListTypeZoom) //13
	{
	    scr_zoomOptions(optionSelected);
	}

	//paneOptions
	else if (optionListType == global.optionListTypePane) //14
	{
	    scr_paneOptions(optionSelected);
	}


	//justifyOptions
	else if (optionListType == global.optionListTypeJustify) //16
	{
	    scr_justifyOptions(optionSelected);
	}

	//proseOptions
	else if (optionListType == global.optionListTypeProse) //17
	{
	    scr_proseOptions(optionSelected);
	}

	//hideOptions
	else if (optionListType == global.optionListTypeHide) //18
	{
	    scr_hideOptions(optionSelected);
	}

	//contextOptions
	else if (optionListType == global.optionListTypeContext) //19
	{
	    scr_contextOptions(optionSelected);
	}


	//settingsOptions
	else if (optionListType == global.optionListTypeSettings) //21
	{
	    scr_settingsOptions(optionSelected);
	}

	//toolsOptions
	else if (optionListType == global.optionListTypeTools) //22
	{
	    scr_toolsOptions(optionSelected);
	}

	//helpOptions
	else if (optionListType == global.optionListTypeHelp) //23
	{
	    scr_helpOptions(optionSelected);
	    instance_destroy();
	}



	//deleteOptions
	else if (optionListType == global.optionListTypeDelete) //26
	{
	    scr_deleteOptions(optionSelected);
	    instance_destroy();
	}

	//token selection
	else if (optionListType == global.optionListTypeTokenSelection) //27
	{
	    scr_tokenSelection(optionSelected);
	    with (obj_dropDown) instance_destroy();
	}
	//stack selection
	else if (optionListType == global.optionListTypeStack) //28
	{
	    scr_stackOptions(optionSelected);
	    //instance_destroy();
	}
	//createStack selection
	else if (optionListType == global.optionListTypeCreateStack) //29
	{
	    scr_createStackOptions(optionSelected);
	}
	//token selection
	else if (optionListType == global.optionListTypeUnitSelection) //31
	{
	    scr_unitSelection(optionSelected);
	    with (obj_dropDown) instance_destroy();
	}
	//import special fields selection
	else if (optionListType == global.optionListTypeSpecialFields) //32
	{
		scr_specialFieldsOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeFilter) //33
	{
	    scr_filterOptions(optionSelected);
	}
	//adding to filter options
	else if (optionListType == global.optionListTypeAddToFilter) //34
	{
	    scr_addToFilterOptions(optionSelected);
	    instance_destroy();
	}
	//adding to Token Tag Map options
	else if (optionListType == global.optionListTypeTokenTagMap) //35
	{
	    scr_tokenTagMapOptions(optionSelected);
	    instance_destroy();
	}

	//adding to Unit Tag Map options
	else if (optionListType == global.optionListTypeUnitTagMap) //38
	{
	    scr_unitTagMapOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == global.optionListTypeAutosave) //40
	{
	    scr_autosaveOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeEdit) //42
	{
	    scr_editOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeNav) //44
	{
	    scr_navOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeLanguage) //45
	{
	    scr_languageOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeImportGrid) //46
	{
	    scr_importGridOptions(optionSelected);
		obj_fieldSummaryWindow.clickedIn = false;
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1ToManyField) //47
	{
	    scr_chain1ToManyFieldOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1ToManyTag) //48
	{
	    scr_chain1ToManyTagOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeTextDirection) //49
	{
	    scr_textDirectionOptions(optionSelected);
	}

	else if (optionListType == global.optionListTypeChain1To1Field) //51
	{
	    scr_chain1To1FieldOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1To1Tag) //52
	{
	    scr_chain1To1TagOptions(optionSelected);
		instance_destroy();
	}

	else if (optionListType == global.optionListTypeAddToShow) //54
	{
	    scr_addToShowOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeShowList) //55
	{
	    scr_showListOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeToolButton) //56
	{
		scr_toolButtonOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeJustifyProse) //57
	{
		scr_justifyProseOptions(optionSelected);
	}
	else if (optionListType == global.optionListType1to1) //58
	{
		scr_1to1Options(optionSelected);
	}
	else if (optionListType == global.optionListTypeTranslation) //59
	{
		scr_translationOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeFieldUnits1ToMany) // 60
	{
		scr_fieldUnits1ToManyOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeRemoveFromTagSetUnits1ToMany) // 61
	{
		scr_removeFieldTagQuestionPrompt("tag", "unit", "1toMany", optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeFieldUnits1To1) // 62
	{
		scr_fieldUnits1To1Options(optionSelected);
	}
	else if (optionListType == global.optionListTypeRemoveFromTagSetUnits1To1) // 63
	{
		scr_removeFieldTagQuestionPrompt("tag", "unit", "1to1", optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeFieldChains1ToMany) // 64
	{
		scr_fieldChains1ToManyOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeRemoveFromTagSetChains1ToMany) // 65
	{
		scr_removeFieldTagQuestionPrompt("tag", "chain", "1toMany", optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeFieldChains1To1) // 66
	{
		scr_fieldChains1To1Options(optionSelected);
	}
	else if (optionListType == global.optionListTypeRemoveFromTagSetChains1To1) // 67
	{
		scr_removeFieldTagQuestionPrompt("tag", "chain", "1to1", optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeChunk1To1Tag) //68
	{
	    scr_chunk1To1TagOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeSearchField) //69
	{
		scr_searchFieldOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeSearchRange) //70
	{
		scr_searchRangeOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeLinkFields) //71
	{
		scr_linkClickOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeLinkTag) //72
	{
		scr_linkTagOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTreeEntry) //73
	{
		scr_treeEntryOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTreeLeaf) //74
	{
		scr_treeLeafOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeArrows) // 75
	{
		scr_arrowOptions(optionSelected);	
	}
	else if (optionListType == global.optionListTypeTag) // 76
	{
		scr_tagOptions(optionSelected);	
	}
	else if (optionListType == global.optionListTypeTokenFields) // 77
	{
		scr_fieldOptions(optionSelected,"Token");	
	}
	else if (optionListType == global.optionListTypeChainFields) // 78
	{
		scr_fieldOptions(optionSelected,"Chain");	
	}
	else if (optionListType == global.optionListTypeEntryFields) // 79
	{
		scr_fieldOptions(optionSelected,"Entry");	
	}
	else if (optionListType == global.optionListTypeUnitFields) // 82
	{
		scr_fieldOptions(optionSelected,"Unit");	
	}
	else if (optionListType == global.optionListTypeChunkFields) // 83
	{
		scr_fieldOptions(optionSelected,"Chunk");	
	}
	else if (optionListType == global.optionListTypeChainTagMap) // 80
	{
		scr_chainTagMapOptions(optionSelected);	
	}
	else if (optionListType == global.optionListTypeEntryTagMap) // 81
	{
		scr_entryTagMapOptions(optionSelected);	
	}
	else if (optionListType == global.optionListTypeSelectShow) // 84
	{
		scr_selectShowOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeChainListMulti) //85
	{
	    scr_chainListMultiOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSearchChain) //86
	{
	    scr_searchChainOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTagSchema) //87
	{
	    scr_tagSchemaOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTreeRightClick) //88
	{
		scr_treeRightClickOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSearchPane) //89
	{
		scr_searchPaneOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTagPane) //90
	{
		scr_tagPaneOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeInsertCol) //91
	{
		scr_insertColOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSplitTokenField) //92
	{
		scr_splitTokenFieldOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeAddEndnote) //93
	{
		scr_newTokenOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeTurnStacker) //94
	{
		scr_turnStackerOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeHTML5REZFile) //95
	{
		scr_html5RezFileOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeStackType) //96
	{
		scr_changeActiveStackType(optionSelected);
		with (obj_dropDown) instance_destroy();
	}

}
