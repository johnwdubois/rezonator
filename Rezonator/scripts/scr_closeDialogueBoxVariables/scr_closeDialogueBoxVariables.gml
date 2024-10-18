function scr_closeDialogueBoxVariables() {
	
	show_debug_message("scr_closeDialogueBoxVariables, obj_selectControl.dialogBoxType: " + string(obj_selectControl.dialogBoxType));
	with (obj_selectControl) dialogBoxType = "";
	
	if (inputWindowActive) {
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
			splitTokenField = "";
			splitTokenCopyTags = true;
			setChainName = false;
			createNewLayer = "";
		}
		with (obj_stacker) {
			confirmStackName = false;
		}
	}
	if (questionWindowActive) {
		
		questionWindowActive = false;
		clearAllStacks = false;
		clearAllTracks = false;
		clearAllChunks = false;
		clearAllRez = false;
		clearAllLinks = false;
		clearChain = false;
		clearChainMulti = false;
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
		swapUnitUp = false;
		swapUnitDown = false;
		confirmSideLink = false;
		stackingToActivate = "";
	
		with (obj_control) {
			mergeChainType = "";
			combineChainsFocused = "";
			combineChainsSelected = "";
			saveBeforeImporting = false;
			saveBeforeAiChat = false;
			saveBeforeOpening = false;
			saveBeforeExiting = false;
			saveBeforeGameEnd = false;
			mergeToken = false;
			sideLinkTokenID = "";
			deleteRez = false;
			deleteStack = false;
			deleteTrack = false;
			downloadDialogue = false;
			deleteChunk = "";
			inactiveChainsThatTokenIsIn = -1;
		}
		with (obj_chain) {
			mergeStackID = "";
		}
		
		with (obj_stacker) {
			stackerMode = "";
			confirmStackName = false;
		}
	}
	if (alertWindowActive) {
		with (obj_control) {
			noResultsFound = false;
			noTurnFound = false;
			noPsentFound = false;
			insertAnyNumber = false;
			mergeUnitDifferingParticipants = false;
			versionUpToDate = false;
		}
		mergeStack = false;
		chunkAlreadyExists = false;
	}
	global.inputBoxDefStr = "";
}