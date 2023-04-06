function scr_closeDialogueBoxVariables() {
	
	show_debug_message("scr_closeDialogueBoxVariables");
	
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
			createNewStacking = false;
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
			openURLAbout = false;
			openURLGuide = false;
			deleteStack = false;
			deleteRez = false;
			deleteTrack = false;
			downloadDialogue = false;
			deleteChunk = "";
		}
		with (obj_chain) {
			mergeStackID = "";
		}
		
		with (obj_stacker) {
			stackerMode = "";
			confirmStackName = false;
		}
		with (obj_openingScreen) {
			openURLGuide = false;
			openURLAbout = false;
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
		with (obj_openingScreen) {
			versionUpToDate = false;
		}
		mergeStack = false;
		chunkAlreadyExists = false;
	}
	if (instance_exists(obj_openingScreen)) {
		with (obj_openingScreen) {
			downloadDialogue = false;
		}
	}
	global.inputBoxDefStr = "";
}