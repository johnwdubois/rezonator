function scr_setDialogueText() {
	
	// this script determines what text will be drawn on a dialog box
	// there are 2 possible texts that can be set: titleText and descriptionText
	
	if (room == rm_openingScreen) {
		if (obj_openingScreen.downloadDialogue) {
			titleText = is_string(global.newVersionStr) ? global.newVersionStr : "";
			descriptionText = scr_get_translation("msg_new-version-available");
			exit;
		}
		else if (obj_openingScreen.versionUpToDate) {
			titleText = global.versionString;
			descriptionText = scr_get_translation("msg_version-up-to-date");
			exit;
		}
	}

	
	if (obj_dialogueBox.questionWindowActive) {
		
		if (instance_exists(obj_control)) {
			if (obj_control.openURLAbout) {
				descriptionText = scr_get_translation("msg_open-url-about");
			}
			if (obj_control.openURLGuide) {
				descriptionText = scr_get_translation("msg_open-url-guide");
			}
			if (obj_control.deleteRez) {
				titleText = scr_get_translation("msg_clear-current-chain");
				descriptionText = scr_get_translation("msg_warning_clear_focused_resonance");
			}
			else if (obj_control.deleteTrack) {
				titleText = scr_get_translation("msg_clear-current-chain");
				descriptionText = scr_get_translation("msg_warning_clear_focused_trail");
			}
			else if (obj_control.deleteStack) {
				titleText = scr_get_translation("msg_clear-current-chain");
				descriptionText = scr_get_translation("msg_warning_clear_focused_stack");
			}
			else if (obj_control.downloadDialogue) {
				titleText = is_string(global.newVersionStr) ? global.newVersionStr : "";
				descriptionText = scr_get_translation("msg_new-version-available");
			}
			else if (obj_control.deleteChunk != "" && is_string(obj_control.deleteChunk)) {
				descriptionText = scr_get_translation("option_delete-chunk-aswell");
			}
		}
		else if (instance_exists(obj_openingScreen)) {
			if (obj_openingScreen.openURLAbout) descriptionText = scr_get_translation("msg_open-url-about");
			else if (obj_openingScreen.openURLGuide) descriptionText = scr_get_translation("msg_open-url-guide");
		}
		
		if (clearAllStacks) {
			titleText = scr_get_translation("Clear Stacks");
			descriptionText = scr_get_translation("msg_warning_clear_stacks");
		}
		if (clearAllRez) {
			titleText = scr_get_translation("Clear Rez Chains");
			descriptionText = scr_get_translation("msg_warning_clear_rez");
		}
		if (clearAllTracks) {
			titleText = scr_get_translation("Clear Track Chains");
			descriptionText =  scr_get_translation("msg_warning_clear_track");
		}
		if (clearAllLinks) {
			titleText = scr_get_translation("Clear All Chains");
			descriptionText = scr_get_translation("msg_warning_clear_chains");
		}
		if (clearAllChunks) {
			titleText = scr_get_translation("Clear All Chunks");
			descriptionText = scr_get_translation("This will remove all chunks created");
		}
		if (clearChain) {
			titleText = scr_get_translation("Clear Current Chain");
			descriptionText = scr_get_translation("msg_warning_clear_focused_chain");
		}
		if (clearChainMulti) {
			titleText = scr_get_translation("Clear Current Chains");
			descriptionText = "You are about to clear these chains.";
		}
		if (confirmSideLink) {
			descriptionText = scr_get_translation("msg_side-link");
		}
		if (mergeUnit) {
			var unitSeq1 = 0;
			var unitSeq2 = 0;
			var mergeUnitPreviewStr = "";
			var mergeUnitListSize = ds_list_size(obj_control.mergeUnitList);
			for (var i = 0; i < mergeUnitListSize; i++) {
				var currentUnitID = obj_control.mergeUnitList[|i];
				var currentUnitSubMap = global.nodeMap[?currentUnitID];
				if (scr_isNumericAndExists(currentUnitSubMap,ds_type_map)) {
					
					if (i == 0) {
						unitSeq1 = currentUnitSubMap[? "unitSeq"];
					}
					else {
						unitSeq2 = currentUnitSubMap[? "unitSeq"];
					}
					
					mergeUnitPreviewStr += string(scr_getUnitText(currentUnitSubMap));
					if (i == 0) mergeUnitPreviewStr += " ";
				}
			}
			
			
			titleText = "Merge units"; // localize
			descriptionText = scr_get_translation("This will merge unit " + string(unitSeq2) + " into unit " + string(unitSeq1) + ":\n" + string(mergeUnitPreviewStr)); // localize
		}
		
		if (swapUnitUp) {
			titleText = scr_get_translation("option_move-unit-up");
			descriptionText =  "Move selected unit to before previous unit?";
		}
		else if (swapUnitDown) {
			titleText = scr_get_translation("option_move-unit-down");
			descriptionText =  "Move selected unit to before previous unit?";
		}
		if (deleteToken) {
			var tokenSubMap = global.nodeMap[? obj_control.rightClickID];
			var tokenTagMap = tokenSubMap[? "tagMap"];
			var displayToken = tokenTagMap[?global.displayTokenField];
			titleText = "Delete selected token?";
			descriptionText = string(displayToken);
		}
		
		if (splitUnit) {
			var unitSeq = 0;
			var splitUnitPreviewStr = "";
			var tokenSubMap = global.nodeMap[? obj_control.rightClickID];
			var unitID = tokenSubMap[? "unit"];
			var tokenTagMap = tokenSubMap[? "tagMap"];
			var displayToken = tokenTagMap[?global.displayTokenField];

			var currentUnitSubMap = global.nodeMap[? unitID];
			if (scr_isNumericAndExists(currentUnitSubMap,ds_type_map)) {
				unitSeq = currentUnitSubMap[? "unitSeq"];
				
				// get preview of split units
				var unitEntryList = currentUnitSubMap[? "entryList"];
				var unitEntryListSize = ds_list_size(unitEntryList);
				for (var i = 0; i < unitEntryListSize; i++) {
					var currentEntry = unitEntryList[| i];
					var currentEntrySubMap = global.nodeMap[? currentEntry];
					var currentToken = currentEntrySubMap[? "token"];
					var currentTokenSubMap = global.nodeMap[? currentToken];
					var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
					if (currentToken == obj_control.rightClickID) splitUnitPreviewStr += "\n";
					splitUnitPreviewStr += currentTokenTagMap[? global.displayTokenField];
					if (i < unitEntryListSize - 1 && currentToken != displayToken) splitUnitPreviewStr += " ";
				}
			
				
			}
			
			
			titleText = scr_get_translation("option_split-unit");
			descriptionText = scr_get_translation("Split unit "+string(unitSeq) +" at \""+ string(displayToken) + "\":\n" + string(splitUnitPreviewStr));
		}

		if (clearShow) {
			titleText = scr_get_translation("help_label_delete_plain")+ " "+ scr_get_translation("menu_show");
			descriptionText =  scr_get_translation("You are about to delete this show");
		}
		if (layerLink) {
			titleText = scr_get_translation("help_label_link");
			descriptionText = scr_get_translation("masg_warning_layer_link");
		}
		if (combineChains) {
			if (obj_control.mergeChainType == "stack") {
				titleText = scr_get_translation("option_merge-stack");
				descriptionText = scr_get_translation("msg_warning_merge_stacks");
			}
			else if (obj_control.mergeChainType == "trail") {
				titleText = scr_get_translation("option_merge-trail");
				descriptionText = scr_get_translation("msg_warning_merge_trails");
			}
			else if (obj_control.mergeChainType == "resonance") {
				titleText = scr_get_translation("option_merge-resonance");
				descriptionText = scr_get_translation("msg_warning_merge_resonances");
			}
		}
		if (removeTagToken || removeTagUnit || removeTagEntry || removeTagChain || removeTagChunk || removeTagLink) {
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("tab_name_tag");
			descriptionText = scr_get_translation("msg_remove-mark-tag") + " " + string(stringToBeRemoved);
		}
		if (removeFieldToken || removeFieldUnit || removeFieldEntry || removeFieldChain || removeFieldChunk || removeFieldLink) {
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("option_field");
			descriptionText =  scr_get_translation("msg_remove-field-tag") + " " + string(stringToBeRemoved);
		}
		if (removeTags) {
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("Tags");
			descriptionText =  "This will permanently remove" + " " + string(ds_list_size(obj_control.selectedTagList)) + " tags from this tag set";
		}
		if (removeSearch) {
			var searchSubMap = global.searchMap[?searchToBeRemoved];
			var searchTermList = searchSubMap[? "searchTermList"];
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("menu_search");
			descriptionText = scr_get_translation("msg_remove-search") + ": " + scr_getStringOfList(searchTermList);
		}
		if (removeTree) {
			var searchSubMap = global.treeMap[?stringToBeRemoved];
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("tab_name_tree");
			descriptionText =  "This will permanently delete the tree:  " + string(searchSubMap[? "name"]); // localize
		}
		if (is_string(stackTypeToActivate) && stackTypeToActivate != "") {
			descriptionText = scr_get_translation("msg_stacktype-not-active");
		}
		
		
		if (instance_exists(obj_stacker)) {
			if (obj_stacker.confirmStackCreate) {
				var stackChainList = global.nodeMap[? "stackList"];
				if (scr_isNumericAndExists(stackChainList, ds_type_list)) {
					var stackChainListSize = ds_list_size(stackChainList);
					descriptionText =  scr_get_translation("msg_stacks_created-1") + " " + string(stackChainListSize) + " " + scr_get_translation("msg_stacks_created-2");
					noButtonActive = true;
				}
			}
		}
		
		if (instance_exists(obj_control)) {
			if (obj_control.saveBeforeExiting) {
				if (is_string(global.fileSaveName) && global.fileSaveName != "undefined") titleText = filename_name(global.fileSaveName);
				descriptionText = scr_get_translation("question_save_before_exit");
			}
			if (obj_control.saveBeforeImporting) {
				if (is_string(global.fileSaveName) && global.fileSaveName != "undefined") titleText = filename_name(global.fileSaveName);
				descriptionText = scr_get_translation("question_save_before_import");
			}
			if (obj_control.saveBeforeOpening) {
				if (is_string(global.fileSaveName) && global.fileSaveName != "undefined") titleText = filename_name(global.fileSaveName);
				descriptionText = scr_get_translation("question_save_before_open");
			}
			if (obj_control.saveBeforeGameEnd) {
				if (is_string(global.fileSaveName) && global.fileSaveName != "undefined") titleText = filename_name(global.fileSaveName);
				descriptionText = scr_get_translation("msg_warning_save-prompt");
			}
			
			
			if (obj_control.mergeToken) {
			
				// get preview of merged tokens
				var previewStr = "";
				var rightClickTokenSubMap = global.nodeMap[? obj_control.rightClickID];
				if (scr_isNumericAndExists(rightClickTokenSubMap, ds_type_map)) {
					var rightClickTokenTagMap = rightClickTokenSubMap[? "tagMap"];
					var rightClickTokenDisplayStr = rightClickTokenTagMap[? global.displayTokenField];
					var docMap = global.nodeMap[?global.discourseNode];
					var tokenList = docMap[? "tokenList"];
					var prevTokenID = tokenList[|ds_list_find_index(tokenList, obj_control.rightClickID) - 1];
					var prevTokenSubMap = global.nodeMap[? prevTokenID];
					var prevTokenTagMap = prevTokenSubMap[? "tagMap"];
					var prevTokenDisplayStr = prevTokenTagMap[? global.displayTokenField];
					if (is_string(prevTokenDisplayStr) && is_string(rightClickTokenDisplayStr)) {
						previewStr = prevTokenDisplayStr + rightClickTokenDisplayStr;
					}
				}
			
				titleText = scr_get_translation("option_merge-token");
				descriptionText = "Would you like to merge this token with the previous token:\n" + previewStr; // localize
			}
		}
	
	}
		
	if (obj_dialogueBox.inputWindowActive) {
		
		
		if (obj_control.changeAuthor) {
			titleText = scr_get_translation("Input New User");
			descriptionText = scr_get_translation("msg_input_creator");
		}
		if (obj_control.changeZero) {
			titleText = scr_get_translation("Input New Zero");
			descriptionText = scr_get_translation("msg_input_new-string");
		}
		if (obj_control.replace) {
			if (obj_control.splitWord) {
				titleText = scr_get_translation("help_label_split-word");
				descriptionText = scr_get_translation("msg_input_split_words");
			}
			else {
				titleText = scr_get_translation("option_new-token");
				descriptionText = scr_get_translation("msg_input_new-word");
			}
		}
		if (obj_control.newWordCreated) {
			titleText = scr_get_translation("option_new-token");
		}
		
		if (obj_control.caption) {
			titleText = scr_get_translation("msg_input_caption");
			descriptionText = scr_get_translation("msg_input_caption");
		}	
		if (obj_control.rename) {
			titleText = scr_get_translation("help_label_rename");
			descriptionText = scr_get_translation("msg_input_chain-name");
		}
		if (obj_control.renameTree) {
			titleText = scr_get_translation("help_label_rename");
		}
		if (obj_control.recolor) {
			titleText = scr_get_translation("option_recolor");
			descriptionText = scr_get_translation("msg_input_chain-color");
		}
		
		if (obj_control.gPressed) {
			if (obj_control.goToTime) {
				titleText = scr_get_translation("msg_time_search");
				descriptionText = scr_get_translation("msg_input_time-jump");
			}
			else {
				titleText = scr_get_translation("msg_specify_line");
				descriptionText = " ";//scr_get_translation("msg_input_line-jump");
			}
		}
		
		if (obj_control.setChainName) {
			titleText = scr_get_translation("option_set-chain-name");
		}
		
		var drawNewFieldText = (obj_control.newCustomFieldToken || obj_control.newCustomFieldUnit || obj_control.newCustomFieldEntry || obj_control.newCustomFieldChain || obj_control.newCustomFieldChunk || obj_control.newCustomFieldLink);
		var drawNewTagText = (obj_control.newCustomTagToken || obj_control.newCustomTagUnit || obj_control.newCustomTagEntry || obj_control.newCustomTagChain || obj_control.newCustomTagChunk || obj_control.newCustomTagLink);
		
		if (drawNewFieldText) {
			titleText = scr_get_translation("option_new-field");
			descriptionText = scr_get_translation("search_custom-field");
		}
		else if (drawNewTagText) {
			titleText = scr_get_translation("msg_create_tag");
			descriptionText = scr_get_translation("search_custom-tag");
		}
		if (obj_control.ePressed) {
			titleText = scr_get_translation("Input Beggining Line");
			descriptionText = scr_get_translation("search_beginning-line");
		}
		
		if (obj_control.fPressed) {
			// draw background text
			if (obj_control.regExCheck) {
				titleText = scr_get_translation("search_dialogue_regEx");
				descriptionText = "";//scr_get_translation("msg_input_regex");
			}
			else {
				titleText = scr_get_translation("search_dialogue_word");
				descriptionText = "";//scr_get_translation("search_dialogue_word");
			}
		}
		
		if (obj_control.setRezMap) {
			titleText = "Set rez map";
			descriptionText = "Type in the amount of actions needed for the resonance chains in this stack";
		}
		if (obj_control.splitToken) {
			titleText = "Pick token split"; // localize
			descriptionText = "Insert a space at the position you would like to split the token"; // localize
		}
		
		if (obj_control.createNewStackType) {
			descriptionText = scr_get_translation("msg_name-new-stacktype");
		}
		
		if (instance_exists(obj_stacker)) {
			if (obj_stacker.confirmStackName) {
				descriptionText = "Set name for new Stacks"; // localize
			}
		}
	}
	
	if (alertWindowActive) {
		if (instance_exists(obj_control)) {
			if (obj_control.noTurnFound) {
				descriptionText = scr_get_translation("msg_order-notfound");
			}
			if (obj_control.noPsentFound) {
				descriptionText = scr_get_translation("No Psent found");
			}
			if (obj_control.insertAnyNumber) {
				descriptionText = scr_get_translation("msg_input_any_number");
			}
			if (obj_control.mergeUnitDifferingParticipants) {
				titleText = "Merge units"; // localize
				descriptionText = "Different participants: Cannot merge units"; // localize
			}
			if (obj_control.versionUpToDate) {
				titleText = global.versionString;
				descriptionText = scr_get_translation("msg_version-up-to-date");
			}
		}
		if (mergeStack) {
			titleText = scr_get_translation("option_merge-stack");
			descriptionText = scr_get_translation("msg_merge-stack");
		}
		if (chunkAlreadyExists) {
			descriptionText = scr_get_translation("msg_duplicate-chunk");
		}
	}
}