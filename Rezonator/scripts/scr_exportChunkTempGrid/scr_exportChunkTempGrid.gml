// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportChunkTempGrid(){
	
	var chunkList = global.nodeMap[?"chunkList"];
	var sizeOfChunkList = ds_list_size(chunkList);
	var chunkGrid = ds_grid_create(3,sizeOfChunkList);
	
	
	for(var i = 0; i < sizeOfChunkList; i++){
		var chunkID =  chunkList[|i];
		ds_grid_set(chunkGrid,0,i,chunkID);
		var chunkSubMap = global.nodeMap[?chunkID];
		if(scr_isNumericAndExists(chunkSubMap,ds_type_map)){
			var tokenList = chunkSubMap[?"tokenList"];
			ds_grid_set(chunkGrid,1,i,scr_getStringOfList(tokenList));
			ds_grid_set(chunkGrid,2,i,scr_getChunkText(chunkID, global.tokenImportDisplayTokenColName));		
		}
	}
	
	return chunkGrid;
}