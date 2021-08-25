/*
	scr_randomStackerLoop();
	
	Last Updated: 2020-10-26
	
	Called from: obj_Stacker
	
	Purpose: Loop through random set of lines to create an assortment of stacks spanning the whole discourse
	
	Mechanism: with random start and endlines set, loop through the set of lines, and call wordClicked() with the tool set to the Stack Tool
	
	Author: Terry DuBois, Georgio Klironomos, Brady Moore
*/
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

	
	/*
	var unitList = discourseSubMap[?"unitList"];
	var unitListSize = ds_list_size(unitList);
	var amountOfLines = floor(random(7));
	//Starting at the top of the unitImportGrid
	for (var importLoop = 0; importLoop < unitListSize; importLoop++) {
		var currentUnitID = unitList[|importLoop];
		var currentUnitSubMap = global.nodeMap[?currentUnitID];
		


		
		// Loop through lines until we hit a new turn order
		while ((amountOfLines > 0) and (importLoop < unitListSize)) { 	
			currentUnitID = unitList[|importLoop];
			currentUnitSubMap = global.nodeMap[?currentUnitID];

			if((amountOfLines > 0)){
				ds_list_add(currentUnitList, currentUnitID);
				importLoop++;
			}
			amountOfLines--;

		}
		importLoop--;
		amountOfLines = floor(random(7));

	
		// Create a Stack based on the current Set of Lines
		if (ds_list_size(currentUnitList) > 0) {
			
			var firstUnitID = ds_list_find_value(currentUnitList, 0);
			
			var prevUnitID = -1;
	
			// Loop through lines and click on them with the Stack Tool
			var inRectUnitIDListSize = ds_list_size(currentUnitList);
			for (var quickStackLoop = 0; quickStackLoop < inRectUnitIDListSize; quickStackLoop++) {
				var currentUnitID = ds_list_find_value(currentUnitList, quickStackLoop);
				var currentUnitSubMap = global.nodeMap[?currentUnitID];
					if(currentUnitID != prevUnitID) {
					
					obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
					with (obj_chain) {
						scr_unitClicked(firstUnitID);
						scr_unitClicked(currentUnitID);
					}
				}
				prevUnitID = currentUnitID;
			}
			// Unfocus all links and chains
			scr_unFocusAllChains();


		}
	
		ds_list_clear(currentUnitList);
	}
	
	
	*/
	
	// Unfocus all links and chains
	scr_unFocusAllChains();


	//reset the ransom numbers
	splitSave = false;
}
