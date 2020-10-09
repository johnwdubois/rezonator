function scr_dropDownSelect(argument0) {

	/*
	    scr_dropDownSelect();
    
	    Last Updated: 2019-08-14
    
	    Called from: obj_dropDown
    
	    Purpose: draw custom drop down menu with multiple options
    
	    Mechanism: draws multiple rectangles and text to represent options to the user.
                
	    Author: Terry Dubois, Brady Moore
	*/



	var optionSelected = argument0;

	//optionListType == 0 --> switch sorting columns for sort pane

	// Sort
	if (optionListType == optionListTypeSort)// 0
	{
	    scr_sortOptions(optionSelected);
	    instance_destroy();
	}
	//chainListEdit
	else if (optionListType == optionListTypeChainList) //1
	{
	    scr_chainListOptions(optionSelected);
	}
	//chainRecolor
	else if (optionListType == optionListTypeChainRecolor) //2
	{
	    scr_chainRecolorOptions(optionSelected);
	    instance_destroy();
	}
	//speakerLabelEdit
	else if (optionListType == optionListTypeSpeakerLabel) //3
	{
	    scr_speakerLabelOptions(optionSelected);
	}
	//fileOptions
	else if (optionListType == optionListTypeFile) //4
	{
	    scr_fileOptions(optionSelected);
	    instance_destroy();
	}
	// advancedOptions
	else if (optionListType == optionListTypeAdvanced) //5
	{
	    scr_advancedOptions(optionSelected);
	  //  instance_destroy();
	}

	//viewOptions
	else if (optionListType == optionListTypeView) //6
	{
	    scr_viewOptions(optionSelected);
	}
	//searchOptions
	else if (optionListType == optionListTypeSearch) //7
	{
	    scr_searchOptions(optionSelected);
	    instance_destroy();
	}
	//right click on word options
	else if (optionListType == optionListTypeRightClickWord) //8
	{
	    scr_rightClickWordOptions(optionSelected);
	}
	//wordTags
	else if (optionListType == optionListTypeWordTags) //9
	{
	    scr_wordTagsOptions(optionSelected);
	}
	//gameSelection
	else if (optionListType == optionListTypeGame) //10
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
	else if (optionListType == optionListTypeNewWord) //11
	{
	    scr_newWordOptions(optionSelected);
	}

	//mappingTagOptions
	else if (optionListType == optionListTypeMappingTag) //12
	{
	    scr_mappingTagOptions(optionSelected);
	}

	//zoomOptions
	else if (optionListType == optionListTypeZoom) //13
	{
	    scr_zoomOptions(optionSelected);
	    instance_destroy();
	}

	//paneOptions
	else if (optionListType == optionListTypePane) //14
	{
	    scr_paneOptions(optionSelected);
	}

	//wordOptions
	else if (optionListType == optionListTypeWord) //15
	{
	    scr_wordOptions(optionSelected);
	    instance_destroy();
	}

	//justifyOptions
	else if (optionListType == optionListTypeJustify) //16
	{
	    scr_justifyOptions(optionSelected);
	    instance_destroy();
	}

	//proseOptions
	else if (optionListType == optionListTypeProse) //17
	{
	    scr_proseOptions(optionSelected);
	    instance_destroy();
	}

	//hideOptions
	else if (optionListType == optionListTypeHide) //18
	{
	    scr_hideOptions(optionSelected);
	    instance_destroy();
	}

	//contextOptions
	else if (optionListType == optionListTypeContext) //19
	{
	    scr_contextOptions(optionSelected);
	    instance_destroy();
	}

	//clearOptions
	else if (optionListType == optionListTypeClear) //20
	{
	    scr_clearOptions(optionSelected);
	    instance_destroy();
	}

	//settingsOptions
	else if (optionListType == optionListTypeSettings) //21
	{
	    scr_settingsOptions(optionSelected);
	}

	//toolsOptions
	else if (optionListType == optionListTypeTools) //22
	{
	    scr_toolsOptions(optionSelected);
	}

	//helpOptions
	else if (optionListType == optionListTypeHelp) //23
	{
	    scr_helpOptions(optionSelected);
	    instance_destroy();
	}

	//toolSortOptions
	else if (optionListType == optionListTypeToolsSort) //24
	{
	    scr_toolsSortOptions(optionSelected);
	    instance_destroy();
	}

	//stackshowOptions
	else if (optionListType == optionListTypeStackShow) //25
	{
	    scr_stackshowOptions(optionSelected);
	    instance_destroy();
	}

	//deleteOptions
	else if (optionListType == optionListTypeDelete) //26
	{
	    scr_deleteOptions(optionSelected);
	    instance_destroy();
	}

	//token selection
	else if (optionListType == optionListTokenSelection) //27
	{
	    scr_tokenSelection(optionSelected);
	    instance_destroy();
	}
	//stack selection
	else if (optionListType == optionListStack) //28
	{
	    scr_stackOptions(optionSelected);
	    //instance_destroy();
	}
	//createStack selection
	else if (optionListType == optionListCreateStack) //29
	{
	    scr_createStackOptions(optionSelected);
	    instance_destroy();
	}
	//showStack selection
	else if (optionListType == optionListTypeShowStack) //30
	{
	    scr_showStackOptions(optionSelected);
	    instance_destroy();
	}
	//token selection
	else if (optionListType == optionListTypeUnitSelection) //31
	{
	    scr_unitSelection(optionSelected);
	    instance_destroy();
	}
	//import special fields selection
	else if (optionListType == optionListTypeSpecialFields) //32
	{
		scr_specialFieldsOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == optionListTypeFilter) //33
	{
	    scr_filterOptions(optionSelected);
	}
	//adding to filter options
	else if (optionListType == optionListTypeAddToFilter) //34
	{
	    scr_addToFilterOptions(optionSelected);
	    instance_destroy();
	}
	//adding to Token Tag Map options
	else if (optionListType == optionListTypeTokenTagMap) //35
	{
	    scr_tokenTagMapOptions(optionSelected);
	    instance_destroy();
	}
	//Token Marker options
	else if (optionListType == optionListTypeTokenMarker) //36
	{
	    scr_tokenMarkerOptions(optionSelected);
	    instance_destroy();
	}
	//Unit Marker options
	else if (optionListType == optionListTypeUnitMarker) //37
	{
	    scr_unitMarkerOptions(optionSelected);
	    instance_destroy();
	}
	//adding to Unit Tag Map options
	else if (optionListType == optionListTypeUnitTagMap) //38
	{
	    scr_unitTagMapOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == optionListTypeGridViewerSelectGrid) //39
	{
	    scr_gridViewerSelectGridOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == optionListTypeAutosave) //40
	{
	    scr_autosaveOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == optionListTypeStackTag) //41
	{
	    scr_stackTagOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == optionListTypeEdit) //42
	{
	    scr_editOptions(optionSelected);
	}
	else if (optionListType == optionListTypePlayAndLearn) //43
	{
	    scr_playandLearnOptions(optionSelected);
	}
	else if (optionListType == optionListTypeNav) //44
	{
	    scr_navOptions(optionSelected);
		instance_destroy();
	}

}
