
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
if (optionListType == 0)
{
    scr_sortOptions(optionSelected);
    instance_destroy();
}
//chainListEdit
else if (optionListType == 1)
{
    scr_chainListOptions(optionSelected);
}
//chainRecolor
else if (optionListType == 2)
{
    scr_chainRecolorOptions(optionSelected);
    instance_destroy();
}
//speakerLabelEdit
else if (optionListType == 3)
{
    scr_speakerLabelOptions(optionSelected);
}
//fileOptions
else if (optionListType == 4)
{
    scr_fileOptions(optionSelected);
    instance_destroy();
}
// advancedOptions
else if (optionListType == 5)
{
    scr_advancedOptions(optionSelected);
  //  instance_destroy();
}

//viewOptions
else if (optionListType == 6)
{
    scr_viewOptions(optionSelected);
}
//searchOptions
else if (optionListType == 7)
{
    scr_searchOptions(optionSelected);
    instance_destroy();
}
//right click on word options
else if (optionListType == 8)
{
    scr_rightClickWordOptions(optionSelected);
}
//wordTags
else if (optionListType == 9)
{
    scr_wordTagsOptions(optionSelected);
}
//gameSelection
else if (optionListType == 10)
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
else if (optionListType == 11)
{
    scr_newWordOptions(optionSelected);
}

//mappingTagOptions
else if (optionListType == 12)
{
    scr_mappingTagOptions(optionSelected);
}

//zoomOptions
else if (optionListType == 13)
{
    scr_zoomOptions(optionSelected);
    instance_destroy();
}

//paneOptions
else if (optionListType == 14)
{
    scr_paneOptions(optionSelected);
    instance_destroy();
}

//wordOptions
else if (optionListType == 15)
{
    scr_wordOptions(optionSelected);
    instance_destroy();
}

//justifyOptions
else if (optionListType == 16)
{
    scr_justifyOptions(optionSelected);
    instance_destroy();
}

//proseOptions
else if (optionListType == 17)
{
    scr_proseOptions(optionSelected);
    instance_destroy();
}

//hideOptions
else if (optionListType == 18)
{
    scr_hideOptions(optionSelected);
    instance_destroy();
}

//contextOptions
else if (optionListType == 19)
{
    scr_contextOptions(optionSelected);
    instance_destroy();
}

//clearOptions
else if (optionListType == 20)
{
    scr_clearOptions(optionSelected);
    instance_destroy();
}

//settingsOptions
else if (optionListType == 21)
{
    scr_settingsOptions(optionSelected);
}

//toolsOptions
else if (optionListType == 22)
{
    scr_toolsOptions(optionSelected);
}

//helpOptions
else if (optionListType == 23)
{
    scr_helpOptions(optionSelected);
    instance_destroy();
}

//toolSortOptions
else if (optionListType == 24)
{
    scr_toolsSortOptions(optionSelected);
    instance_destroy();
}

//stackshowOptions
else if (optionListType == 25)
{
    scr_stackshowOptions(optionSelected);
    instance_destroy();
}

//deleteOptions
else if (optionListType == 26)
{
    scr_deleteOptions(optionSelected);
    instance_destroy();
}

//token selection
else if (optionListType == 27)
{
    scr_tokenSelection(optionSelected);
    instance_destroy();
}
//stack selection
else if (optionListType == 28)
{
    scr_stackOptions(optionSelected);
    //instance_destroy();
}
//createStack selection
else if (optionListType == 29)
{
    scr_createStackOptions(optionSelected);
    instance_destroy();
}
//showStack selection
else if (optionListType == 30)
{
    scr_showStackOptions(optionSelected);
    instance_destroy();
}
//token selection
else if (optionListType == 31)
{
    scr_unitSelection(optionSelected);
    instance_destroy();
}
//import special fields selection
else if (optionListType == 32)
{
	scr_specialFieldsOptions(optionSelected);
	instance_destroy();
}
else if (optionListType == 33)
{
    scr_filterOptions(optionSelected);
}
//adding to filter options
else if (optionListType == 34)
{
    scr_addToFilterOptions(optionSelected);
    instance_destroy();
}
//adding to Token Tag Map options
else if (optionListType == 35)
{
    scr_tokenTagMapOptions(optionSelected);
    instance_destroy();
}
//add Marker options
else if (optionListType == 36)
{
    scr_tokenMarkerOptions(optionSelected);
    instance_destroy();
}

