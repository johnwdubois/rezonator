function scr_randomChainLoop() {
	obj_chain.quickLinkCreated = true;
	// Set script variables
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var tokenList = discourseSubMap[?"tokenList"];
	var tokenListSize = ds_list_size(tokenList);
	var encounteredTokens = ds_list_create();
	var amountOfTokens = tokenListSize//floor(irandom(15));
	for(var i  = 0 ; i < tokenListSize; i++){
		if(i == tokenListSize-1){
			obj_chain.quickLinkCreated = false;
		}
		var currentToken = tokenList[| i];
		show_debug_message("currentTokenBeing \"clicked\": " + string(i));
		scr_tokenClicked(currentToken);
		//var tokenSubMap = global.nodeMap[? currentToken];
		amountOfTokens--;
		if(amountOfTokens < 0){
			scr_chainDeselect();
			amountOfTokens = floor(irandom(15));
		}
	}
	
	
	
	ds_list_destroy(encounteredTokens);


	
	// Unfocus all links and chains
	scr_chainDeselect();


	//reset the ransom numbers
	splitSave = false;
}
