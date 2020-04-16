/*
	scr_renderFilter();
	
	Last Updated: 2018-09-11
	
	Called from: obj_control
	
	Purpose: clear and then populate filterGrid with necessary units
	
	Mechanism: check all chains to see if they are flagged with the filter option, and if they are
				then add a row to the filterGrid
	
	Author: Terry DuBois, Georgio Klironomos
*/

ds_grid_destroy(filterGrid);
filterGrid = ds_grid_create(lineGridWidth, 0);

var grid;

for (var i = 0; i < 4; i++) {
	
	switch (i) {
		case 0:
			grid = obj_chain.rezChainGrid;
			break;
		case 1:
			grid = obj_chain.trackChainGrid;
			break;
		case 2:
			grid = obj_chain.stackChainGrid;
			break;
		case 3:
			grid = obj_chain.cliqueDisplayGrid;
			break;
		default:
			break;
	}
	
	// loop through current chainGrid to include chains marked with filter
	var gridHeight = ds_grid_height(grid);
	for (var j = 0; j < gridHeight; j++) {
		if (not ds_grid_get(grid, obj_chain.chainGrid_colInFilter, j)) {
			if(ds_grid_get(grid, obj_chain.chainGrid_colChainState, j) == obj_chain.chainStateFocus) {
				// Unfocus chains only if we aren't adding a chunk to a chain within the FilterView
				if(obj_toolPane.newWordInFilter == false) {
				scr_unfocusChain(ds_grid_get(grid, obj_chain.chainGrid_colChainID, j));
				}
				else {
					obj_toolPane.newWordInFilter = false;	
				}
			}
			continue;
		}
		
		var currentIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, j);
		
		ds_list_sort(currentIDList, true);
		
		// set information in filterGrid for words in this chain
		var currentIDListSize = ds_list_size(currentIDList);
		for (var k = 0; k < currentIDListSize; k++) {
			if (grid == obj_chain.stackChainGrid or grid == obj_chain.cliqueDisplayGrid) {
				var currentUnitID = ds_list_find_value(currentIDList, k);
			}
			else {
				var currentWordID = ds_list_find_value(currentIDList, k);
				var currentUnitID = ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1);
			}
			
			if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID)) {
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
			ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, (currentRowFilterGrid * obj_control.gridSpaceVertical));
			ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, (currentRowFilterGrid * obj_control.gridSpaceVertical));
			ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
			ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
			ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDListUnitGrid);
		}
	}
}




// sort filterGrid
ds_grid_sort(filterGrid, lineGrid_colUnitID, true);
var filterGridHeight = ds_grid_height(filterGrid);
for (var i = 0; i < filterGridHeight; i++) {
	ds_grid_set(filterGrid, lineGrid_colDisplayRow, i, i);
}

var firstUnit = ds_grid_get(filterGrid, lineGrid_colUnitID, 0);
var lastUnit = ds_grid_get(filterGrid, lineGrid_colUnitID, ds_grid_height(filterGrid) - 1);

if (firstUnit == undefined or lastUnit == undefined) { // If there's no units to be filtered, hop back to the main screen

	// If filter is active, deactivate it
	if (obj_control.filterGridActive) {
		if(obj_control.currentCenterDisplayRow >= 0) { // Make sure the current center display row is within bounds
			// Keep the focus on previous currentCenterDisplayRow
			with (obj_control) {
				alarm[5] = 3;
			}
		}
	}
	// Switch to active grid
	obj_control.filterGridActive = false;
	obj_control.currentActiveLineGrid = obj_control.lineGrid;
	exit;
}

// Set filter to Prior Context (Before)
if (obj_panelPane.functionFilter_peek[0] == 1) {
	
	for (var i = 0; i < firstUnit - 1; i++) {
		if (i < 0 or i > ds_grid_height(unitGrid)) {
			continue;
		}
		
		var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
		if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID)) {
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
		ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
		ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
		ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
	}
	
	var chainIDModifyListSize = ds_list_size(obj_chain.chainIDModifyList);
	for(var i = 0; i < chainIDModifyListSize; i++) {
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
			}
			else {
				relevantGrid = obj_chain.trackChainGrid;
			}
		}
		
		// Mchanism for recording specific lines to keep user's focus
		if (relevantRow >= 0 and relevantRow < ds_grid_height(relevantGrid)) {
			if (ds_grid_get(relevantGrid, obj_chain.chainGrid_colInFilter, relevantRow)) {
				if(relevantGrid == obj_chain.stackChainGrid) {//for Stacks
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					obj_chain.unitIDOfFirstWord = ds_list_find_value(IDList, 0);
					obj_chain.unitIDOfLastWord = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
				}
				else {// Navigate through grids to find first & last lines
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					var firstWordOfChain = ds_list_find_value(IDList, 0);
					var lastWordOfChain = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
					obj_chain.unitIDOfFirstWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, firstWordOfChain - 1);
					obj_chain.unitIDOfLastWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, lastWordOfChain - 1);
				}

				// Alarm for focusing on the correct lines
				with (obj_chain) {
					focusPrior = true;
					alarm[5] = 3;
				}
				
				break;
			}
		}	
	}
	
}


// Set filter to Tween Context
if (obj_panelPane.functionFilter_peek[1] == 1) {	
	for (var i = firstUnit; i < lastUnit; i++) {
		var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
		if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID)) {
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
		ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
		ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
		ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
	}
	
	var chainIDModifyListSize = ds_list_size(obj_chain.chainIDModifyList);
	for(var i = 0; i < chainIDModifyListSize; i++) {
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
			}
			else {
				relevantGrid = obj_chain.trackChainGrid;
			}
		}
		// Mechanism for recording specific lines to keep user's focus
		if (relevantRow >= 0 and relevantRow < ds_grid_height(relevantGrid)) {
			if (ds_grid_get(relevantGrid, obj_chain.chainGrid_colInFilter, relevantRow)) {
				if(relevantGrid == obj_chain.stackChainGrid) {
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					obj_chain.unitIDOfFirstWord = ds_list_find_value(IDList, 0);
					obj_chain.unitIDOfLastWord = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
				}
				else {// Navigate through grids to find first & last lines
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					var firstWordOfChain = ds_list_find_value(IDList, 0);
					var lastWordOfChain = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
					obj_chain.unitIDOfFirstWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, firstWordOfChain - 1);
					obj_chain.unitIDOfLastWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, lastWordOfChain - 1);
				}
				
				with (obj_chain) {
					focusTween = true;
					alarm[5] = 3;// Alarm for focusing on the correct lines
				}
				
				break;
			}
		}	
	}
}

// Set filter to Next Context
if (obj_panelPane.functionFilter_peek[2] == 1) {
	var unitGridHeight = ds_grid_height(unitGrid);
	for (var i = lastUnit; i < unitGridHeight; i++) {
		var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
		if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID)) {
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
		ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
		ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
		ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
	}
	var chainIDModifyListSize = ds_list_size(obj_chain.chainIDModifyList);
	for (var i = 0; i < chainIDModifyListSize; i++) {
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
			}
			else {
				relevantGrid = obj_chain.trackChainGrid;
			}
		}
		// Mechanism for recording specific lines to keep user's focus
		if (relevantRow >= 0 and relevantRow < ds_grid_height(relevantGrid)) {
			if (ds_grid_get(relevantGrid, obj_chain.chainGrid_colInFilter, relevantRow)) {
				if(relevantGrid == obj_chain.stackChainGrid) {//for stacks
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					obj_chain.unitIDOfFirstWord = ds_list_find_value(IDList, 0);
					obj_chain.unitIDOfLastWord = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
				}
				else {// Navigate through grids to find first & last lines
					var IDList = ds_grid_get(relevantGrid, obj_chain.chainGrid_colWordIDList, relevantRow);	
					var firstWordOfChain = ds_list_find_value(IDList, 0);
					var lastWordOfChain = ds_list_find_value(IDList, ds_list_size(IDList) - 1);
					obj_chain.unitIDOfFirstWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, firstWordOfChain - 1);
					obj_chain.unitIDOfLastWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, lastWordOfChain - 1);
				}
				with (obj_chain) {
					focusNext = true;
					alarm[5] = 3;// Alarm for focusing on the correct lines
				}
				
				break;
			}
		}	
	}
}

// Sort filterGrid again
ds_grid_sort(filterGrid, lineGrid_colUnitID, true);
var filterGridHeight = ds_grid_height(filterGrid);
for (var i = 0; i < filterGridHeight; i++) {
	ds_grid_set(filterGrid, lineGrid_colDisplayRow, i, i);
	ds_grid_set(filterGrid, lineGrid_colPixelY, i, i * obj_control.gridSpaceVertical);
	ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, i, i * obj_control.gridSpaceVertical);
}




searchGridActive = false;
filterGridActive = true;
currentActiveLineGrid = filterGrid;
wordLeftMarginDest = 170; // Make sure the margin is placed correctly

with (obj_alarm) {
	alarm[1] = 5;
}
