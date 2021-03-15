scr_scrollBarInit();


gridViewing = global.tagInfoGrid;

alarm[0] = 5;
//calculate current tokenThreshold
var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
if(currentMarkerCount != undefined){
obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
}

