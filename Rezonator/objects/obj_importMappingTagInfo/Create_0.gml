fieldSelected = -1;

scr_scrollBarInit();


gridViewing = global.tagInfoGrid;

alarm[0] = 5;
//calculate current tokenThreshold
var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
if(currentMarkerCount != undefined){
	obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
}


// this list contains the ratio widths of the columns in the import fields window... these must add up to be 100%
importFieldsColRatioList = ds_list_create();
ds_list_add(importFieldsColRatioList, 15, 15, 35, 35);