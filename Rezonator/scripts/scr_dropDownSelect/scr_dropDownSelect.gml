/*
	Purpose: draw custom drop down menu with multiple options
*/
function scr_dropDownSelect(optionSelected) {


	if (optionListType == global.optionListTypeChainList) {
	    scr_chainListOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeChainRecolor) {
	    scr_chainRecolorOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSpeakerLabel) {
	    scr_speakerLabelOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeFile) {
	    scr_fileOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeAdvanced) {
	    scr_advancedOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeView) {
	    scr_viewOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSearch) {
	    scr_searchOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == global.optionListTypeRightClickWord) {
	    scr_rightClickWordOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeNewWord) {
	    scr_newTokenOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeMappingTag) {
	    scr_mappingTagOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeZoom) {
	    scr_zoomOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypePane) {
	    scr_paneOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeJustify) {
	    scr_justifyOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeProse) {
	    scr_proseOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeHide) {
	    scr_hideOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeContext) {
	    scr_contextOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSettings) {
	    scr_settingsOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTools) {
	    scr_toolsOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeHelp) {
	    scr_helpOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == global.optionListTypeDelete) {
	    scr_deleteOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == global.optionListTypeTokenSelection) {
	    scr_tokenSelection(optionSelected);
	    with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeStack) {
	    scr_stackOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeCreateStack) {
	    scr_createStackOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeUnitSelection) {
	    scr_unitSelection(optionSelected);
	    with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeSpecialFields) {
		scr_specialFieldsOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeFilter) {
	    scr_filterOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeAddToFilter) {
	    scr_addToFilterOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == global.optionListTypeTokenTagMap) {
	    scr_tokenTagMapOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == global.optionListTypeUnitTagMap) {
	    scr_unitTagMapOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == global.optionListTypeAutosave) {
	    scr_autosaveOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeEdit) {
	    scr_editOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeNav) {
	    scr_navOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeLanguage) {
	    scr_languageOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeImportGrid) {
	    scr_importGridOptions(optionSelected);
		obj_fieldSummaryWindow.clickedIn = false;
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1ToManyField) {
	    scr_chain1ToManyFieldOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1ToManyTag) {
	    scr_chain1ToManyTagOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeTextDirection) {
	    scr_textDirectionOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeChain1To1Field) {
	    scr_chain1To1FieldOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1To1Tag) {
	    scr_chain1To1TagOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeAddToShow) {
	    scr_addToShowOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeShowList) {
	    scr_showListOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeToolButton) {
		scr_toolButtonOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeJustifyProse) {
		scr_justifyProseOptions(optionSelected);
	}
	else if (optionListType == global.optionListType1to1) {
		scr_1to1Options(optionSelected);
	}
	else if (optionListType == global.optionListTypeTranslation) {
		scr_translationOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeFieldUnits1ToMany) {
		scr_fieldUnits1ToManyOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeRemoveFromTagSetUnits1ToMany) {
		scr_removeFieldTagQuestionPrompt("tag", "unit", "1toMany", optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeFieldUnits1To1) {
		scr_fieldUnits1To1Options(optionSelected);
	}
	else if (optionListType == global.optionListTypeRemoveFromTagSetUnits1To1) {
		scr_removeFieldTagQuestionPrompt("tag", "unit", "1to1", optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeFieldChains1ToMany) {
		scr_fieldChains1ToManyOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeRemoveFromTagSetChains1ToMany) {
		scr_removeFieldTagQuestionPrompt("tag", "chain", "1toMany", optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeFieldChains1To1) {
		scr_fieldChains1To1Options(optionSelected);
	}
	else if (optionListType == global.optionListTypeRemoveFromTagSetChains1To1) {
		scr_removeFieldTagQuestionPrompt("tag", "chain", "1to1", optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeChunk1To1Tag) {
	    scr_chunk1To1TagOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeSearchField) {
		scr_searchFieldOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeSearchRange) {
		scr_searchRangeOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeLinkFields) {
		scr_linkClickOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeLinkTag) {
		scr_linkTagOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTreeEntry) {
		scr_treeEntryOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTreeLeaf) {
		scr_treeLeafOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeArrows) {
		scr_arrowOptions(optionSelected);	
	}
	else if (optionListType == global.optionListTypeTag) {
		scr_tagOptions(optionSelected);	
	}
	else if (optionListType == global.optionListTypeTokenFields) {
		scr_fieldOptions(optionSelected,"Token");	
	}
	else if (optionListType == global.optionListTypeChainFields) {
		scr_fieldOptions(optionSelected,"Chain");	
	}
	else if (optionListType == global.optionListTypeEntryFields) {
		scr_fieldOptions(optionSelected,"Entry");	
	}
	else if (optionListType == global.optionListTypeUnitFields) {
		scr_fieldOptions(optionSelected,"Unit");	
	}
	else if (optionListType == global.optionListTypeChunkFields) {
		scr_fieldOptions(optionSelected,"Chunk");	
	}
	else if (optionListType == global.optionListTypeChainTagMap) {
		scr_chainTagMapOptions(optionSelected);	
	}
	else if (optionListType == global.optionListTypeEntryTagMap) {
		scr_entryTagMapOptions(optionSelected);	
	}
	else if (optionListType == global.optionListTypeSelectShow) {
		scr_selectShowOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeChainListMulti) {
	    scr_chainListMultiOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSearchChain) {
	    scr_searchChainOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTagSchema) {
	    scr_tagSchemaOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTreeRightClick) {
		scr_treeRightClickOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSearchPane) {
		scr_searchPaneOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeTagPane) {
		scr_tagPaneOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeInsertCol) {
		scr_insertColOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypeSplitTokenField) {
		scr_splitTokenFieldOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeAddEndnote) {
		scr_newTokenOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeTurnStacker) {
		scr_turnStackerOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeHTML5REZFile) {
		scr_html5RezFileOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeStacking) {
		scr_changeActiveStacking(optionSelected);
		with (obj_dropDown) instance_destroy();
	}
	else if (optionListType == global.optionListTypeCliqueRightClick) {
		scr_cliqueRightClickOptions(optionSelected);
		with (obj_dropDown) instance_destroy();
	}

}
