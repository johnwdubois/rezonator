

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
			setRezMap = false;
			dialogueBoxActive = false;
			renameTree = false;
			splitToken = false;
			mergeToken = false;
		}
	}
	if(questionWindowActive){
		questionWindowActive = false;
		clearAllStacks = false;
		clearAllTracks = false;
		clearAllChunks = false;
		clearAllRez = false;
		clearAllLinks = false;
		clearChain = false;
		clearChainMulti = false;
		layerLink = false;
		combineChains = false;
		removeTags = false;
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
		mergeUnit = false;
		splitUnit = false;
		stringToBeRemoved = "";
		removeSearch = false;
		searchToBeRemoved = "";
	
		with (obj_control) {
			stackMerged = false;
			combineChainsFocused = "";
			combineChainsSelected = "";
			saveBeforeImporting = false;
			saveBeforeExiting = false;
			saveBeforeGameEnd = false;
		}
		
		with (obj_stacker) {
			confirmStackCreate = false;
			createStacksRandom = false;
			createStacksTurn = false;
			createStacksSentence = false;
			createStacksClique = false;
			createStacksPsent = false;
		}
	}
	if (alertWindowActive) {
		with (obj_control) {
			noResultsFound = false;
			noTurnFound = false;
			noPsentFound = false;
			insertAnyNumber = false;
			mergeUnitDifferingParticipants = false;
		}
	}
	if (instance_exists(obj_openingScreen)) {
		with (obj_openingScreen) {
			downloadDialogue = false;
		}
	}
	global.inputBoxDefStr = "";
}