/*
	scr_renderFilter();
	
	Last Updated: 2018-09-11
	
	Called from: obj_control
	
	Purpose: clear and then populate filterGrid with necessary units
	
	Mechanism: check all chains to see if they are flagged with the filter option, and if they are
				then add a row to the filterGrid
	
	Author: Terry DuBois
*/

ds_grid_destroy(filterGrid);
filterGrid = ds_grid_create(lineGridWidth, 0);

var grid;

for (var i = 0; i < 3; i++)
{
	switch (i)
	{
		case 0:
			grid = obj_chain.rezChainGrid;
			break;
		case 1:
			grid = obj_chain.trackChainGrid;
			break;
		case 2:
			grid = obj_chain.stackChainGrid;
			break;
		default:
			break;
	}
	
	for (var j = 0; j < ds_grid_height(grid); j++)
	{
		if (not ds_grid_get(grid, obj_chain.chainGrid_colInFilter, j))
		{
			continue;
		}
		
		var currentIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, j);
		
		ds_list_sort(currentIDList, true);
		
		for (var k = 0; k < ds_list_size(currentIDList); k++)
		{
			if (i == 2)
			{
				var currentUnitID = ds_list_find_value(currentIDList, k);
			}
			else
			{
				var currentWordID = ds_list_find_value(currentIDList, k);
				var currentUnitID = ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1);
			}
			
			if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID))
			{
				continue;
			}
			
			
			var currentWordIDListUnitGrid = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
			var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
			var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
			
			ds_grid_resize(filterGrid, lineGridWidth, ds_grid_height(filterGrid) + 1);
			var currentRowFilterGrid = ds_grid_height(filterGrid) - 1;
			
			ds_grid_set(filterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
			ds_grid_set(filterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
			ds_grid_set(filterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
			ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, room_height + gridSpaceVertical);
			ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
			ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
			ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDListUnitGrid);
		}
	}
}

ds_grid_sort(filterGrid, lineGrid_colUnitID, true);
for (var i = 0; i < ds_grid_height(filterGrid); i++)
{
	ds_grid_set(filterGrid, lineGrid_colDisplayRow, i, i);
}

var firstUnit = ds_grid_get(filterGrid, lineGrid_colUnitID, 0);
var lastUnit = ds_grid_get(filterGrid, lineGrid_colUnitID, ds_grid_height(filterGrid) - 1);

if (firstUnit == undefined or lastUnit == undefined)
{
	exit;
}

if (obj_panelPane.functionFilter_peek[0] == 1) //Prior Context
{
	
	for (var i = 0; i < firstUnit - 1; i++)
	{
		if (i < 0 or i > ds_grid_height(unitGrid))
		{
			continue;
		}
		
		var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
		if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID))
		{
			continue;
		}
		
		var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
		var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
		var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
		ds_grid_resize(filterGrid, lineGridWidth, ds_grid_height(filterGrid) + 1); 
		var currentRowFilterGrid = ds_grid_height(filterGrid) - 1;
		
		ds_grid_set(filterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
		ds_grid_set(filterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
		ds_grid_set(filterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
		ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, room_height + gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
		ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
		ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
	}
	
	for(var i = 0; i < ds_list_size(obj_chain.chainIDModifyList); i++) {
		var currentChainID = ds_list_find_value(obj_chain.chainIDModifyList, i);
		var relevantGrid = obj_chain.rezChainGrid;
		var relevantRow = -1;
		relevantRow = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), currentChainID);
		if (relevantRow < 0) {
			relevantRow = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), currentChainID);
			if (relevantRow < 0) {
				relevantRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentChainID);
				if (relevantRow >= 0) {
					relevantGrid = obj_chain.stackChainGrid;
				}
			} else {
				relevantGrid = obj_chain.trackChainGrid;
			}
		}
		
		if (relevantRow >= 0 and relevantRow < ds_grid_height(relevantGrid)) {
			if (ds_grid_get(relevantGrid, obj_chain.chainGrid_colInFilter, relevantRow)) {
				if(relevantGrid == obj_chain.stackChainGrid) {//for Stacks
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					obj_chain.unitIDOfFirstWord = ds_list_find_value(IDList, 0);
					obj_chain.unitIDOfLastWord = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
				} else {//for Rez/Tracks
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					var firstWordOfChain = ds_list_find_value(IDList, 0);
					var lastWordOfChain = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
					obj_chain.unitIDOfFirstWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, firstWordOfChain - 1);
					obj_chain.unitIDOfLastWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, lastWordOfChain - 1);
				}
				
				with (obj_chain) {
					focusPrior = true;
					alarm[5] = 3;
				}
				
				break;
			}
		}	
	}
	
}

if (obj_panelPane.functionFilter_peek[1] == 1) //Tween Context
{	
	for (var i = firstUnit; i < lastUnit; i++)
	{
		var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
		if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID))
		{
			continue;
		}
		
		var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
		var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
		var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
		ds_grid_resize(filterGrid, lineGridWidth, ds_grid_height(filterGrid) + 1);
		var currentRowFilterGrid = ds_grid_height(filterGrid) - 1;
		
		ds_grid_set(filterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
		ds_grid_set(filterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
		ds_grid_set(filterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
		ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, room_height + gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
		ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
		ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
	}
	
	for(var i = 0; i < ds_list_size(obj_chain.chainIDModifyList); i++)  {
		var currentChainID = ds_list_find_value(obj_chain.chainIDModifyList, i);
		var relevantGrid = obj_chain.rezChainGrid;
		var relevantRow = -1;
		relevantRow = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), currentChainID);
		if (relevantRow < 0) {
			relevantRow = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), currentChainID);
			if (relevantRow < 0) {
				relevantRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentChainID);
				if (relevantRow >= 0) {
					relevantGrid = obj_chain.stackChainGrid;
				}
			} else {
				relevantGrid = obj_chain.trackChainGrid;
			}
		}
		
		if (relevantRow >= 0 and relevantRow < ds_grid_height(relevantGrid)) {
			if (ds_grid_get(relevantGrid, obj_chain.chainGrid_colInFilter, relevantRow)) {
				if(relevantGrid == obj_chain.stackChainGrid) {
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					obj_chain.unitIDOfFirstWord = ds_list_find_value(IDList, 0);
					obj_chain.unitIDOfLastWord = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
				} else {
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					var firstWordOfChain = ds_list_find_value(IDList, 0);
					var lastWordOfChain = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
					obj_chain.unitIDOfFirstWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, firstWordOfChain - 1);
					obj_chain.unitIDOfLastWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, lastWordOfChain - 1);
				}
				
				with (obj_chain) {
					focusTween = true;
					alarm[5] = 3;
				}
				
				break;
			}
		}	
	}
}

if (obj_panelPane.functionFilter_peek[2] == 1) //Next Context
{	
	for (var i = lastUnit; i < ds_grid_height(unitGrid); i++)
	{
		var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
		if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID))
		{
			continue;
		}
		
		var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
		var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
		var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
		ds_grid_resize(filterGrid, lineGridWidth, ds_grid_height(filterGrid) + 1);
		var currentRowFilterGrid = ds_grid_height(filterGrid) - 1;
		
		ds_grid_set(filterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
		ds_grid_set(filterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
		ds_grid_set(filterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
		ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, room_height + gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
		ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
		ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
	}
	for(var i = 0; i < ds_list_size(obj_chain.chainIDModifyList); i++) {
		var currentChainID = ds_list_find_value(obj_chain.chainIDModifyList, i);
		var relevantGrid = obj_chain.rezChainGrid;
		var relevantRow = -1;
		relevantRow = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), currentChainID);
		if (relevantRow < 0) {
			relevantRow = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), currentChainID);
			if (relevantRow < 0) {
				relevantRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentChainID);
				if (relevantRow >= 0) {
					relevantGrid = obj_chain.stackChainGrid;
				}
			} else {
				relevantGrid = obj_chain.trackChainGrid;
			}
		}
		
		if (relevantRow >= 0 and relevantRow < ds_grid_height(relevantGrid)) {
			if (ds_grid_get(relevantGrid, obj_chain.chainGrid_colInFilter, relevantRow)) {
				if(relevantGrid == obj_chain.stackChainGrid) {//for stacks
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					obj_chain.unitIDOfFirstWord = ds_list_find_value(IDList, 0);
					obj_chain.unitIDOfLastWord = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
				} else {//for rez/tracks
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					var firstWordOfChain = ds_list_find_value(IDList, 0);
					var lastWordOfChain = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
					obj_chain.unitIDOfFirstWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, firstWordOfChain - 1);
					obj_chain.unitIDOfLastWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, lastWordOfChain - 1);
				}
				with (obj_chain) {
					focusNext = true;
					alarm[5] = 3;
				}
				
				break;
			}
		}	
	}
}


ds_grid_sort(filterGrid, lineGrid_colUnitID, true);
for (var i = 0; i < ds_grid_height(filterGrid); i++)
{
	ds_grid_set(filterGrid, lineGrid_colDisplayRow, i, i);
}

searchGridActive = false;
filterGridActive = true;
currentActiveLineGrid = filterGrid;