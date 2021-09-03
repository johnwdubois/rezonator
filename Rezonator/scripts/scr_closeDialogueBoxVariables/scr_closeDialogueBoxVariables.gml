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
			changeAuthor = false;
			changeZero = false;
			newCustomTagToken = false;
			newCustomFieldToken = false;
			newCustomTagUnit = false;
			newCustomFieldUnit = false;
			newCustomTagEntry = false;
			newCustomTagChain = false;
			newCustomFieldEntry = false;
			newCustomFieldChain = false;
			newCustomFieldChunk = false;
			newCustomFieldLink = false;
			newCustomTagChunk = false;
			newCustomTagLink = false;
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
		removeTagLink = false;
		removeFieldToken = false;
		removeFieldUnit = false;
		removeFieldEntry = false;
		removeFieldChain = false;
		removeFieldChunk = false;
		removeFieldLink = false;
		stringToBeRemoved = "";
		removeSearch = false;
		searchToBeRemoved = "";
	
		with (obj_control) {
			stackMerged = false;
			combineChainsFocused = "";
			combineChainsSelected = "";
		}
		
		with (obj_stacker) confirmStackCreate = false;
	}
	if (alertWindowActive) {
		with (obj_control) {
			noResultsFound = false;
		}
	}
}