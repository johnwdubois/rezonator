// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportLinkTempGrid(){
	
	var nodeList = global.nodeMap[? "nodeList"];
	if (!scr_isNumericAndExists(nodeList, ds_type_list)) exit;
	
	// initialize grid
	var grid = ds_grid_create(6, 0);
	var grid_colLinkID = 0;
	var grid_colChainID = 1;
	var grid_colSource = 2;
	var grid_colSourceClickTime = 3;
	var grid_colGoal = 4;
	var grid_colGoalClickTime = 5;

	
	var nodeListSize = ds_list_size(nodeList);
	for (var i = 0; i < nodeListSize; i++) {
		// get current node, check if it's a link
		var currentNode = nodeList[| i];
		var currentNodeSubMap = global.nodeMap[? currentNode];
		if (!scr_isNumericAndExists(currentNodeSubMap, ds_type_map)) continue;
		if (currentNodeSubMap[? "type"] != "link") continue;
		
		// if it is a link, grab data needed
		var currentSource = currentNodeSubMap[? "source"];
		var currentSourceClickTime = currentNodeSubMap[? "sourceClickTime"];
		var currentGoal = currentNodeSubMap[? "goal"];
		var currentGoalClickTime = currentNodeSubMap[? "goalClickTime"];
		var currentChain = "";
		var currentSourceSubMap = global.nodeMap[? currentSource];
		if (scr_isNumericAndExists(currentSourceSubMap, ds_type_map)) {
			currentChain = currentSourceSubMap[? "chain"];
		}
		
		// enter data into grid
		ds_grid_resize(grid, ds_grid_width(grid), ds_grid_height(grid) + 1);
		var currentRow = ds_grid_height(grid) - 1;
		grid[# grid_colLinkID, currentRow] = currentNode;
		grid[# grid_colChainID, currentRow] = currentChain;
		grid[# grid_colSource, currentRow] = currentSource;
		grid[# grid_colSourceClickTime, currentRow] = currentSourceClickTime;
		grid[# grid_colGoal, currentRow] = currentGoal;
		grid[# grid_colGoalClickTime, currentRow] = currentGoalClickTime;
	}
	
	
	
	return grid;

}