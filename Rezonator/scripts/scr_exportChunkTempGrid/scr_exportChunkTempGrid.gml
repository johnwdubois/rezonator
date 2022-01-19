

function scr_exportChunkTempGrid(){
	
	var chunkList = global.nodeMap[?"chunkList"];
	var sizeOfChunkList = ds_list_size(chunkList);
	
	var chunkFieldList = obj_control.chunkFieldList;
	var chunkFieldListSize = ds_list_size(chunkFieldList);
	
	var chunkGrid = ds_grid_create(3 + chunkFieldListSize, sizeOfChunkList);
	ds_grid_clear(chunkGrid, "");
	
	
	for(var i = 0; i < sizeOfChunkList; i++){
		var chunkID =  chunkList[|i];
		ds_grid_set(chunkGrid,0,i,chunkID);
		var chunkSubMap = global.nodeMap[?chunkID];
		if(scr_isNumericAndExists(chunkSubMap,ds_type_map)){
			var tokenList = chunkSubMap[?"tokenList"];
			ds_grid_set(chunkGrid,1,i,scr_getStringOfList(tokenList));
			ds_grid_set(chunkGrid,2,i,scr_getChunkText(chunkID, global.tokenImportDisplayTokenColName));		
		}
		
		// get chunk tags
		var chunkTagMap = chunkSubMap[? "tagMap"];
		for (var j = 0; j < chunkFieldListSize; j++) {
			var currentChunkField = chunkFieldList[| j];
			if (ds_map_exists(chunkTagMap, currentChunkField)) {
				chunkGrid[# j + 3, i] = chunkTagMap[? currentChunkField];
			}
		}
	}
	
	return chunkGrid;
}