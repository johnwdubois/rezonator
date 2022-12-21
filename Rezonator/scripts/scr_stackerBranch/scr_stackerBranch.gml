function scr_stackerBranch(){
	
	show_debug_message("scr_stackerBranch, stackerMode: " + string(obj_stacker.stackerMode));
	if (instance_exists(obj_dialogueBox) && instance_exists(obj_inputBox)) {
		with (obj_stacker) {
			if (confirmStackName) {
				stackerName = obj_inputBox.str;
				stackerNameNum = 1;
			}
		}
	}
	
	
	if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
		obj_toolPane.currentMode = obj_toolPane.modeTrack;
		if(obj_control.currentView == obj_control.searchView) {
			obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
		}
		else {
			obj_toolPane.setModeMain = obj_toolPane.modeTrack;
		}
	}

	obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabStackBrush;
			
	// unfocus chains of all type
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
		stackerName = "";
		stackerNameNum = 0;
		confirmStackCreate = false;
	}
}