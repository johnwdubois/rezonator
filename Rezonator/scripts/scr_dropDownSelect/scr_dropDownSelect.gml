/*
	Purpose: draw custom drop down menu with multiple options
*/
function scr_dropDownSelect(optionSelected) {

	//optionListType == 0 --> switch sorting columns for sort pane

	// Sort
	if (optionListType == global.optionListTypeSort)// 0
	{
	    scr_sortOptions(optionSelected);
	    instance_destroy();
	}
	//chainListEdit
	else if (optionListType == global.optionListTypeChainList) //1
	{
	    scr_chainListOptions(optionSelected);
	}
	//chainRecolor
	else if (optionListType == global.optionListTypeChainRecolor) //2
	{
	    scr_chainRecolorOptions(optionSelected);
	    instance_destroy();
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
	    instance_destroy();
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
	//wordTags
	else if (optionListType == global.optionListTypeWordTags) //9
	{
	    scr_wordTagsOptions(optionSelected);
	}
	//gameSelection
	else if (optionListType == global.optionListTypeGame) //10
	{

	    switch (optionSelected)
	    {
	        case "Present":
	            obj_stackShow.currentGame = "Present";
	            break;
	        case "Where's Elmo":
	            obj_stackShow.currentGame = "Where's Elmo";
	            break;
	        case "Rezzles":    
	            obj_stackShow.currentGame = "Rezzles";
	            break;
	        case "SpotBot":
	            obj_stackShow.currentGame = "SpotBot";
	            break;
	        default:
	            break;
	    }
	    with(obj_dropDown){
	        instance_destroy();
	    }
	}
	//newWordOptions
	else if (optionListType == global.optionListTypeNewWord) //11
	{
	    scr_newWordOptions(optionSelected);
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
	    instance_destroy();
	}

	//paneOptions
	else if (optionListType == global.optionListTypePane) //14
	{
	    scr_paneOptions(optionSelected);
	}

	//wordOptions
	else if (optionListType == global.optionListTypeWord) //15
	{
	    scr_wordOptions(optionSelected);
	    instance_destroy();
	}

	//justifyOptions
	else if (optionListType == global.optionListTypeJustify) //16
	{
	    scr_justifyOptions(optionSelected);
	    if (object_index == obj_dropDown) instance_destroy();
	}

	//proseOptions
	else if (optionListType == global.optionListTypeProse) //17
	{
	    scr_proseOptions(optionSelected);
	    if (object_index == obj_dropDown) instance_destroy();
	}

	//hideOptions
	else if (optionListType == global.optionListTypeHide) //18
	{
	    scr_hideOptions(optionSelected);
	    instance_destroy();
	}

	//contextOptions
	else if (optionListType == global.optionListTypeContext) //19
	{
	    scr_contextOptions(optionSelected);
	    if (object_index == obj_dropDown) instance_destroy();
	}

	//clearOptions
	else if (optionListType == global.optionListTypeClear) //20
	{
	    scr_clearOptions(optionSelected);
	    instance_destroy();
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

	//toolSortOptions
	else if (optionListType == global.optionListTypeToolsSort) //24
	{
	    scr_toolsSortOptions(optionSelected);
	    instance_destroy();
	}

	//stackshowOptions
	else if (optionListType == global.optionListTypeStackShow) //25
	{
	    scr_stackshowOptions(optionSelected);
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
	    instance_destroy();
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
	    instance_destroy();
	}
	//showStack selection
	else if (optionListType == global.optionListTypeShowStack) //30
	{
	    scr_showStackOptions(optionSelected);
	    instance_destroy();
	}
	//token selection
	else if (optionListType == global.optionListTypeUnitSelection) //31
	{
	    scr_unitSelection(optionSelected);
	    instance_destroy();
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
	//Token Marker options
	else if (optionListType == global.optionListTypeTokenMarker) //36
	{
	    scr_tokenMarkerOptions(optionSelected);
	    instance_destroy();
	}
	//Unit Marker options
	else if (optionListType == global.optionListTypeUnitMarker) //37
	{
	    scr_unitMarkerOptions(optionSelected);
	    instance_destroy();
	}
	//adding to Unit Tag Map options
	else if (optionListType == global.optionListTypeUnitTagMap) //38
	{
	    scr_unitTagMapOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == global.optionListTypeGridViewerSelectGrid) //39
	{
	    scr_gridViewerSelectGridOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == global.optionListTypeAutosave) //40
	{
	    scr_autosaveOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == global.optionListTypeStackTag) //41
	{
	    scr_stackTagOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == global.optionListTypeEdit) //42
	{
	    scr_editOptions(optionSelected);
	}
	else if (optionListType == global.optionListTypePlayAndLearn) //43
	{
	    scr_playandLearnOptions(optionSelected);
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
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1ToManyField) //47
	{
	    scr_chain1ToManyFieldOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1ToManyTag) //48
	{
	    scr_chain1ToManyTagOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeTextDirection) //49
	{
	    scr_textDirectionOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1ToManyHeaderRightClick) //50
	{
	    scr_chain1ToManyHeaderRightClickOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1To1Field) //51
	{
	    scr_chain1To1FieldOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1To1Tag) //52
	{
	    scr_chain1To1TagOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == global.optionListTypeChain1To1HeaderRightClick) //53
	{
	    scr_chain1To1HeaderRightClickOptions(optionSelected);
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

}
