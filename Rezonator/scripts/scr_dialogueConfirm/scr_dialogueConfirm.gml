// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dialogueConfirm(){
	
	// check if they are trying to download newest version of rezonator
	if (instance_exists(obj_openingScreen)) {
		if (obj_openingScreen.downloadDialogue) {
			url_open("https://rezonator.com/download/");
		}
		scr_closeDialogueBoxVariables();
		instance_destroy();
		exit;
	}
	
	// if this is an alert window, we just need to close out of the dialogue box
	if (alertWindowActive) {
		if (obj_control.noResultsFound) {
			with (obj_alarm2) alarm[5] = 1;
		}
		scr_closeDialogueBoxVariables();
		instance_destroy();
		exit;
	}

	if(inputWindowActive){
		
		var chainSubMap = undefined;
		var chainType = "";
		if (ds_map_exists(global.nodeMap, obj_control.selectedChainID)) {
			chainSubMap = ds_map_find_value(global.nodeMap, obj_control.selectedChainID);
			if (is_numeric(chainSubMap)) {
				if (ds_exists(chainSubMap, ds_type_map)) {
					chainType = ds_map_find_value(chainSubMap, chainType);
				}
			}
		}
	
				
		obj_control.alarm[11] = 60;
		
			
		if (obj_control.fPressed) {

			var searchSelectedBefore = obj_panelPane.functionSearchList_searchSelected;
			
			// creating list of words if user inputed multiple words
			var listOfWordsInput = scr_splitString(obj_control.inputText, "&");
			scr_createNewSearch(listOfWordsInput);
			if (searchSelectedBefore != obj_panelPane.functionSearchList_searchSelected) {
				obj_control.searchGridActive = true;
				scr_renderFilter2();
			}
		}
		


		if (obj_control.gPressed) {
							
			if (obj_panelPane.discoIDSelected) {
				if(obj_control.goToTime){
					scr_jumpToTime(obj_control.inputText);
				}
				else{
					scr_jumpToUnit(obj_panelPane.selectedDiscoID, obj_control.inputText);
				}
			}
			else {
				if(obj_control.goToTime){
					scr_jumpToTime(obj_control.inputText);
				}
				else{
					var strDigits = string_digits(obj_control.inputText);
					if (string_length(strDigits) > 0) {
						var realDigits = real(strDigits);
						scr_jumpToUnit(realDigits);
					}
				}
			}

		}
		
		if (obj_control.newWordCreated) {
				
		
				
			scr_newToken(obj_control.inputText, obj_control.rightClickID);

			
			obj_control.lastAddedWord = obj_control.inputText;
		}
		if (obj_control.changeZero) {
			obj_control.lastAddedWord = obj_control.inputText;
		}
			
			
		if (obj_control.rename) {
			if (is_numeric(chainSubMap)) {
				if (ds_exists(chainSubMap, ds_type_map)) {
					ds_map_replace(chainSubMap, "name", obj_control.inputText);
				}
			}
		}
		if (obj_control.newCustomFieldToken) {
			scr_dialogueBoxNewCustomFieldToken();
		}
		if (obj_control.newCustomFieldUnit) {
			scr_dialogueBoxNewCustomFieldUnit();
		}
		if (obj_control.newCustomTagUnit) {
			scr_dialogueBoxNewCustomTagUnit();
		}
		if (obj_control.newCustomTagToken) {
			scr_dialogueBoxNewCustomTagToken();
		}
		if (obj_control.newCustomTagEntry) {
			scr_dialogueBoxNewCustomTagEntry();
		}
		if (obj_control.newCustomFieldEntry) {
			scr_dialogueBoxNewCustomFieldEntry();
		}
		if (obj_control.newCustomTagChain) {
			scr_dialogueBoxNewCustomTagChain();
		}
		if (obj_control.newCustomFieldChain) {
			scr_dialogueBoxNewCustomFieldChain();
		}
		if (obj_control.newCustomTagChunk) {
			scr_dialogueBoxNewCustomTagToken();
		}
		if (obj_control.newCustomTagLink) {
			scr_dialogueBoxNewCustomTagLink();
		}
		if (obj_control.newCustomFieldChunk) {
			obj_control.selectFieldChunk = true;
			scr_dialogueBoxNewCustomFieldToken();
			obj_control.selectFieldChunk = false;
		}
		if (obj_control.newCustomFieldLink) {
			scr_dialogueBoxNewCustomFieldLink();
		}
		

		if (obj_control.recolor) {

			if (string_digits(obj_control.inputText) == "") {
				show_message(scr_get_translation("msg_numbers_only"));
			}
			else {
				if (chainType == "resonance" || chainType == "trail") {
					var listOfWordIDSize = ds_list_size(listOfWordID);
					for (var i = 0; i < listOfWordIDSize; i++) {
						var currentWordID = ds_list_find_value(listOfWordID, i);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentWordID - 1, real(string_digits(obj_control.inputText)));
					}
				}
					
				if (is_numeric(chainSubMap)) {
					if (ds_exists(chainSubMap, ds_type_map)) {
						ds_map_replace(chainSubMap, "chainColor", real(string_digits(obj_control.inputText)));
					}
				}
					
			}
		}
		
		if (obj_control.caption){
			if (is_numeric(chainSubMap)) {
				if (ds_exists(chainSubMap, ds_type_map)) {
					ds_map_replace(chainSubMap, "caption", obj_control.inputText);
				}
			}
		}
		
		if (obj_control.replace) {
			scr_dialogueBoxReplace();
		}
		

		
		if (obj_control.changeAuthor) {
			global.userName = obj_control.inputText;
		}
			
		
		with (obj_panelPane) {
			obj_control.discoIDSelected = false;
		}
			
		scr_closeDialogueBoxVariables();
		instance_destroy();

	
	}
	if(questionWindowActive){
		
		obj_control.alarm[11] = 60;

		if (clearAllStacks || clearAllLinks) {
				
			// delete all stack chains!
			show_debug_message("scr_dialogueConfirm() ... clearAllStacks");
			scr_deleteAllChains(global.nodeMap[? "stackList"]);
		}
		if (clearAllRez || clearAllLinks) {
				
			// delete all rez chains!!
			show_debug_message("scr_dialogueConfirm() ... clearAllRez");
			scr_deleteAllChains(global.nodeMap[? "resonanceList"]);
		}
		if (clearAllTracks || clearAllLinks) {
				
			// delete all track chains!!
			scr_deleteAllChains(global.nodeMap[? "trailList"]);
		}
		
		
		if (removeTagToken) scr_removeFromTagSetOptions(string(stringToBeRemoved), "token");
		if (removeTagUnit) scr_removeFromTagSetOptions(string(stringToBeRemoved), "unit");
		if (removeTagEntry) scr_removeFromTagSetOptions(string(stringToBeRemoved), "entry");
		if (removeTagChain) scr_removeFromTagSetOptions(string(stringToBeRemoved), "chain");
		if (removeTagChunk) scr_removeFromTagSetOptions(string(stringToBeRemoved), "chunk");
		if (removeTagLink) scr_removeFromTagSetOptions(string(stringToBeRemoved), "link");
		
		if (removeFieldToken || removeFieldUnit || removeFieldEntry || removeFieldChain || removeFieldChunk || removeFieldLink) {
			// delete the field
			scr_deleteField(stringToBeRemoved);
				
			// deselect fields
			if (removeFieldToken) with (obj_panelPane) functionField_tokenFieldSelected = "";
			if (removeFieldEntry) with (obj_panelPane) functionField_entryFieldSelected = "";
			if (removeFieldUnit) with (obj_panelPane) functionField_unitFieldSelected = "";
			if (removeFieldChain) with (obj_panelPane) functionField_chainFieldSelected = "";
			if (removeFieldChunk) with (obj_panelPane) functionField_chunkFieldSelected = "";
			if (removeFieldLink) with (obj_panelPane) functionField_linkFieldSelected = "";
		}
		
		
			
		

		if (clearChain) {
			scr_deleteChain(obj_control.selectedChainID);
		}
		if (clearShow) {
			scr_deleteShow(obj_control.selectedChainID);
		}
		if (removeSearch) {
			scr_removeSearch(searchToBeRemoved);
		}
		if (removeTree) {
			scr_deleteTree(stringToBeRemoved);
		}
		
			
		if(layerLink) {
			
			// Take the saved wordID & click on it
			obj_control.layerLinkAllow = true;
			with(obj_chain) {
				alarm[8] = 2;	
			}
		}
		
		if(combineChains){
			scr_combineChains(obj_control.combineChainsFocused, obj_control.combineChainsSelected);
		}
		
		if (instance_exists(obj_stacker)) {
			if (obj_stacker.confirmStackCreate) {
				scr_deleteAllChains(global.nodeMap[? "stackList"]);
				scr_stackerBranch();
			}
		}
		
		scr_closeQuestionBoxVariables();
		instance_destroy();
	}
}