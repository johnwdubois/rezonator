// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_closeDialogueBoxVariables(){
	if(inputWindowActive){
		with (obj_control) {
			newWordCreated =false
			fPressed = false;
			gPressed = false;
			ePressed = false;
			transcriptSearch = false;
			inChainBool = false;
			caseSensitive = false;
			regExCheck = false;
			goToTime =  false;
			rename = false;
			recolor = false;
			caption = false;
			replace = false;
			splitWord = false;
			swapLine = false;
			changeAuthor = false;
			changeZero = false;
			newTagCategory = false;
			newCustomTagToken = false;
			newCustomFieldToken = false;
			newCustomTagUnit = false;
			newCustomFieldUnit = false;
			newCustomTagEntry = false;
			newCustomTagChain = false;
			newCustomFieldEntry = false;
			newCustomFieldChain = false;
			newCustomFieldChunk = false;
			newCustomTagChunk = false;
			fromDropDown = false;
			inputText = "";
			cursorPos = 1;
			dialogueBoxActive = false;
		
		}
	}
	if(questionWindowActive){
		questionWindowActive = false;
		clearAllStacks = false;
		clearAllTracks = false;
		clearAllRez = false;
		clearAllLinks = false;
		clearChain = false;
		layerLink = false;
		combineChains = false;
		removeTagToken = false;
		removeTagUnit = false;
		removeTagEntry = false;
		removeTagChain = false;
		removeTagChunk = false;
		removeFieldToken = false;
		removeFieldUnit = false;
		removeFieldEntry = false;
		removeFieldChain = false;
		removeFieldChunk = false;
		stringToBeRemoved = "";
		removeSearch = false;
		searchToBeRemoved = "";
	
		obj_control.stackMerged = false;
		obj_control.combineChainsFocused = "";
		obj_control.combineChainsSelected = "";
		
	}
}