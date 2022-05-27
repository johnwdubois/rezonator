// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_mergeToken(tokenID){
	var docMap = global.nodeMap[?global.discourseNode];
	var tokenList = docMap[?"tokenList"];
	
	var prevTokenID = tokenList[|ds_list_find_index(tokenList, tokenID) - 1]
	
	var mergeTokenSubmap = global.nodeMap[?tokenID]
	var mergeTokenTagmap = mergeTokenSubmap[?"tagMap"]
	var prevTokenSubmap = global.nodeMap[?prevTokenID]
	var prevTokenTagmap = prevTokenSubmap[?"tagMap"]
	
	
	prevTokenTagmap[?global.displayTokenField] += mergeTokenTagmap[?global.displayTokenField]
	
	var mergeTokenChainList = mergeTokenSubmap[?"inChainsList"]
	var prevTokenChainList = prevTokenSubmap[?"inChainsList"]
	
	var mergeTokenHasRez = false;
	var mergeTokenHasTrack = false;
	var prevTokenHasRez = false;
	var prevTokenHasTrack = false;
	
	for(var i = 0; i < ds_list_size(mergeTokenChainList); i++){
		var currentChain = mergeTokenChainList[|i]
		var currentChainMap = global.nodeMap[?currentChain]
		var currentChainType = currentChainMap[?"type"]
		
		if(currentChainType == "resonance"){
			mergeTokenHasRez = true;
			var mergeTokenRez = currentChain;
		}
		if(currentChainType = "trail"){
			mergeTokenHasTrack = true;
			var mergeTokenTrack = currentChain;
		}
		

	}
	
	for(var i = 0; i < ds_list_size(prevTokenChainList); i++){
		var currentChain = prevTokenChainList[|i]
		var currentChainMap = global.nodeMap[?currentChain]
		var currentChainType = currentChainMap[?"type"]
		
		if(currentChainType == "resonance"){
			prevTokenHasRez = true;
			prevTokenRez = currentChain;
		}
		if(currentChainType = "trail"){
			prevTokenHasTrack = true;	
			var prevTokenTrack = currentChain;
		}
		

	}
	
	if(prevTokenHasRez and mergeTokenHasRez){
		obj_chain.currentFocusedChainID = mergeTokenRez;
		scr_deleteFromChain(true)
	}
	if(prevTokenHasTrack and mergeTokenHasTrack){
		obj_chain.currentFocusedChainID = mergeTokenTrack;
		scr_deleteFromChain(true)
	}
	if(not prevTokenHasRez and mergeTokenHasRez){
		obj_chain.currentFocusedChainID = mergeTokenRez;
		scr_newLink(prevTokenID);
	}
	if(not prevTokenHasTrack and mergeTokenHasTrack){
		obj_chain.currentFocusedChainID = mergeTokenTrack;
		scr_newLink(prevTokenID);
	}
	
	
	scr_deleteToken(tokenID);
}