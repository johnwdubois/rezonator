

function scr_sortSearchLists(resultsList) {


	var unitList = resultsList[|0];
	var tokenList = resultsList[|1];

	var tokenListSize = ds_list_size(tokenList);

	var tempGrid = ds_grid_create(3,tokenListSize);


	for (var i = 0 ; i < tokenListSize; i++) {

		var currentToken = tokenList[|i];
		var tokenSubMap = global.nodeMap[?currentToken];
	
		var discourseOrder = tokenSubMap[? "docTokenSeq"];

		tempGrid[# 0,i] = unitList[|i];
		tempGrid[# 1,i] = tokenList[|i];
		tempGrid[# 2,i] = discourseOrder;
	
	}

	ds_grid_sort(tempGrid,2,true);

	ds_list_clear(unitList);
	ds_list_clear(tokenList);

	for (var i = 0 ; i < tokenListSize; i++) {

		unitList[|i] = tempGrid[# 0,i];
		tokenList[|i] = tempGrid[# 1,i];
	
	}

	ds_list_clear(resultsList);

	ds_list_add(resultsList,unitList);
	ds_list_add(resultsList,tokenList);

	ds_grid_destroy(tempGrid)


	return resultsList;


}

