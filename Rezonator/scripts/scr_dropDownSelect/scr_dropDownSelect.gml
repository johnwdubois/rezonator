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
	if (optionListType == obj_control.optionListTypeSort)// 0
	{
	    scr_sortOptions(optionSelected);
	    instance_destroy();
	}
	//chainListEdit
	else if (optionListType == obj_control.optionListTypeChainList) //1
	{
	    scr_chainListOptions(optionSelected);
	}
	//chainRecolor
	else if (optionListType == obj_control.optionListTypeChainRecolor) //2
	{
	    scr_chainRecolorOptions(optionSelected);
	    instance_destroy();
	}
	//speakerLabelEdit
	else if (optionListType == obj_control.optionListTypeSpeakerLabel) //3
	{
	    scr_speakerLabelOptions(optionSelected);
	}
	//fileOptions
	else if (optionListType == obj_control.optionListTypeFile) //4
	{
	    scr_fileOptions(optionSelected);
	    instance_destroy();
	}
	// advancedOptions
	else if (optionListType == obj_control.optionListTypeAdvanced) //5
	{
	    scr_advancedOptions(optionSelected);
	  //  instance_destroy();
	}

	//viewOptions
	else if (optionListType == obj_control.optionListTypeView) //6
	{
	    scr_viewOptions(optionSelected);
	}
	//searchOptions
	else if (optionListType == obj_control.optionListTypeSearch) //7
	{
	    scr_searchOptions(optionSelected);
	    instance_destroy();
	}
	//right click on word options
	else if (optionListType == obj_control.optionListTypeRightClickWord) //8
	{
	    scr_rightClickWordOptions(optionSelected);
	}
	//wordTags
	else if (optionListType == obj_control.optionListTypeWordTags) //9
	{
	    scr_wordTagsOptions(optionSelected);
	}
	//gameSelection
	else if (optionListType == obj_control.optionListTypeGame) //10
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
	else if (optionListType == obj_control.optionListTypeNewWord) //11
	{
	    scr_newWordOptions(optionSelected);
	}

	//mappingTagOptions
	else if (optionListType == obj_control.optionListTypeMappingTag) //12
	{
	    scr_mappingTagOptions(optionSelected);
	}

	//zoomOptions
	else if (optionListType == obj_control.optionListTypeZoom) //13
	{
	    scr_zoomOptions(optionSelected);
	    instance_destroy();
	}

	//paneOptions
	else if (optionListType == obj_control.optionListTypePane) //14
	{
	    scr_paneOptions(optionSelected);
	}

	//wordOptions
	else if (optionListType == obj_control.optionListTypeWord) //15
	{
	    scr_wordOptions(optionSelected);
	    instance_destroy();
	}

	//justifyOptions
	else if (optionListType == obj_control.optionListTypeJustify) //16
	{
	    scr_justifyOptions(optionSelected);
	    instance_destroy();
	}

	//proseOptions
	else if (optionListType == obj_control.optionListTypeProse) //17
	{
	    scr_proseOptions(optionSelected);
	    instance_destroy();
	}

	//hideOptions
	else if (optionListType == obj_control.optionListTypeHide) //18
	{
	    scr_hideOptions(optionSelected);
	    instance_destroy();
	}

	//contextOptions
	else if (optionListType == obj_control.optionListTypeContext) //19
	{
	    scr_contextOptions(optionSelected);
	    instance_destroy();
	}

	//clearOptions
	else if (optionListType == obj_control.optionListTypeClear) //20
	{
	    scr_clearOptions(optionSelected);
	    instance_destroy();
	}

	//settingsOptions
	else if (optionListType == obj_control.optionListTypeSettings) //21
	{
	    scr_settingsOptions(optionSelected);
	}

	//toolsOptions
	else if (optionListType == obj_control.optionListTypeTools) //22
	{
	    scr_toolsOptions(optionSelected);
	}

	//helpOptions
	else if (optionListType == obj_control.optionListTypeHelp) //23
	{
	    scr_helpOptions(optionSelected);
	    instance_destroy();
	}

	//toolSortOptions
	else if (optionListType == obj_control.optionListTypeToolsSort) //24
	{
	    scr_toolsSortOptions(optionSelected);
	    instance_destroy();
	}

	//stackshowOptions
	else if (optionListType == obj_control.optionListTypeStackShow) //25
	{
	    scr_stackshowOptions(optionSelected);
	    instance_destroy();
	}

	//deleteOptions
	else if (optionListType == obj_control.optionListTypeDelete) //26
	{
	    scr_deleteOptions(optionSelected);
	    instance_destroy();
	}

	//token selection
	else if (optionListType == obj_control.optionListTypeTokenSelection) //27
	{
	    scr_tokenSelection(optionSelected);
	    instance_destroy();
	}
	//stack selection
	else if (optionListType == obj_control.optionListTypeStack) //28
	{
	    scr_stackOptions(optionSelected);
	    //instance_destroy();
	}
	//createStack selection
	else if (optionListType == obj_control.optionListTypeCreateStack) //29
	{
	    scr_createStackOptions(optionSelected);
	    instance_destroy();
	}
	//showStack selection
	else if (optionListType == obj_control.optionListTypeShowStack) //30
	{
	    scr_showStackOptions(optionSelected);
	    instance_destroy();
	}
	//token selection
	else if (optionListType == obj_control.optionListTypeUnitSelection) //31
	{
	    scr_unitSelection(optionSelected);
	    instance_destroy();
	}
	//import special fields selection
	else if (optionListType == obj_control.optionListTypeSpecialFields) //32
	{
		scr_specialFieldsOptions(optionSelected);
		instance_destroy();
	}
	else if (optionListType == obj_control.optionListTypeFilter) //33
	{
	    scr_filterOptions(optionSelected);
	}
	//adding to filter options
	else if (optionListType == obj_control.optionListTypeAddToFilter) //34
	{
	    scr_addToFilterOptions(optionSelected);
	    instance_destroy();
	}
	//adding to Token Tag Map options
	else if (optionListType == obj_control.optionListTypeTokenTagMap) //35
	{
	    scr_tokenTagMapOptions(optionSelected);
	    instance_destroy();
	}
	//Token Marker options
	else if (optionListType == obj_control.optionListTypeTokenMarker) //36
	{
	    scr_tokenMarkerOptions(optionSelected);
	    instance_destroy();
	}
	//Unit Marker options
	else if (optionListType == obj_control.optionListTypeUnitMarker) //37
	{
	    scr_unitMarkerOptions(optionSelected);
	    instance_destroy();
	}
	//adding to Unit Tag Map options
	else if (optionListType == obj_control.optionListTypeUnitTagMap) //38
	{
	    scr_unitTagMapOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == obj_control.optionListTypeGridViewerSelectGrid) //39
	{
	    scr_gridViewerSelectGridOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == obj_control.optionListTypeAutosave) //40
	{
	    scr_autosaveOptions(optionSelected);
	    instance_destroy();
	}

	else if (optionListType == obj_control.optionListTypeStackTag) //41
	{
	    scr_stackTagOptions(optionSelected);
	    instance_destroy();
	}
	else if (optionListType == obj_control.optionListTypeEdit) //42
	{
	    scr_editOptions(optionSelected);
	}
	else if (optionListType == obj_control.optionListTypePlayAndLearn) //43
	{
	    scr_playandLearnOptions(optionSelected);
	}
	else if (optionListType == obj_control.optionListTypeNav) //44
	{
	    scr_navOptions(optionSelected);
		instance_destroy();
	}

}
