function scr_stackerBranch() {
	
	show_debug_message("scr_stackerBranch, stackerMode: " + string(obj_stacker.stackerMode));
	var newStackingName = "";
	var newStacksName = "";
	if (instance_exists(obj_dialogueBox) && instance_exists(obj_inputBox)) {
		
		// get strings from both textboxes
		var _inputBoxList = obj_dialogueBox.inputBoxList;
		if (scr_isNumericAndExists(_inputBoxList, ds_type_list)) {
			with (obj_inputBox) {
				if (ds_list_find_index(_inputBoxList, self.id) == 0) newStackingName = str;
				else if (ds_list_find_index(_inputBoxList, self.id) == 1) newStacksName = str;
			}
		}
		
		// set stacking name vars
		with (obj_stacker) {
			if (confirmStackName) {
				stacker_stackingName = newStackingName;
				stacker_stacksName = newStacksName;
			}
		}
	}
	
	
	if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
		obj_toolPane.currentMode = obj_toolPane.modeTrack;
		if (obj_control.currentView == obj_control.searchView) {
			obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
		}
		else {
			obj_toolPane.setModeMain = obj_toolPane.modeTrack;
		}
	}

	obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabStackBrush;
			
	// unfocus chains
	scr_chainDeselect();
	
	with (obj_stacker) {
		if (stackerMode == "menu_random") {
			endLine = ds_grid_height(obj_control.lineGrid) - 1;
			randUnit = -1;
			stackerRandomCurrentUnitList = ds_list_create();
			ds_list_clear(stackerRandomCurrentUnitList);
	
			scr_randomStackerLoop();
		}
		else if (stackerMode == "menu_turn") {
			if (is_string(global.unitImportTurnDelimColName) && global.unitImportTurnDelimColName != "") {
				scr_turnStackerLoop();
			}
		}
		else if (stackerMode == "participant") {
			if (is_string(global.participantField) && global.participantField != "") {
				scr_sentStackerLoop();
			}
		}
		else if (stackerMode == "sentence") {
			scr_sentStackerLoop();
		}
		else if (stackerMode == "menu_clique") {
			scr_cliqueStackerLoop();
		}
		else if (stackerMode == "menu_utterance") {
			scr_psentStackerLoop();
		}
		
		stackerMode = "";
		stacker_stackingName = "";
		confirmStackCreate = false;
	}
}