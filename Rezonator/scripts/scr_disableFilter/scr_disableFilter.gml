// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_disableFilter(){

	with (obj_control) {
		searchGridActive = false;
		filterGridActive = false;
		quickFilterGridActive = false;
		quickPickedChainID = "";
		currentActiveLineGrid = lineGrid;
		wordLeftMarginDest = 170; // Make sure the margin is placed correctly


	}
	
	if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabRezBrush) obj_control.filterActiveRez = false;
	else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTrackBrush) obj_control.filterActiveTrack = false;
	else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush) obj_control.filterActiveStack = false;

	// set the displayUnitList to be the filterUnitList
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	var drawRangeUnit = displayUnitList[|0];
	var drawRangeUnitSubMap = global.nodeMap[?drawRangeUnit];
	var drawRangeUnitSeq = drawRangeUnitSubMap[?"unitSeq"];
	var unitList = discourseSubMap[? "unitList"];
	
	
	discourseSubMap[? "displayUnitList"] = unitList;
	scr_jumpToUnit(drawRangeUnit);
	scr_setValueForAllNodesInList(unitList, "active", true);
	

	var unitListSize = ds_list_size(unitList);
	for(var i = 0; i < unitListSize; i ++){
		
		var currentUnit = unitList[|i];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		var unitSeq = currentUnitSubMap[?"unitSeq"];	

		if(unitSeq < drawRangeUnitSeq){
			currentUnitSubMap[? "pixelY"] = -9999;
		}
		else{
			currentUnitSubMap[? "pixelY"] = 9999;
		}	
		
	}
	
	

}