/*
	scr_stackShow();
	
	Last Updated: 2019-07-24
	
	Called from: obj_dialogueBox
	
	Purpose: Cycle through showing off user selected stacks one at a time.
	
	Mechanism: loop through the stackShowList, filtering on one stack only, 
				and hop back to the main screen once we reach the end of the list.
	
	Author: Georgio Klironomos
*/

	// Increment our position in the list
	if(obj_control.currentStackShowListPosition > 0 and obj_control.stackShowBackwards){
		obj_control.currentStackShowListPosition--;
	}
	else{
		obj_control.currentStackShowListPosition++;
	}
	


// If we are still within the bounds of the list
if(ds_list_size(obj_control.stackShowList) > 0 && obj_control.currentStackShowListPosition != (ds_list_size(obj_control.stackShowList))) {
	obj_control.stackShowActive = true;
	// If we are not on the first element of the list, then unfilter the previous stack
	if(obj_control.currentStackShowListPosition > -1) {
		var prevStackID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition - 1);
		if( obj_control.stackShowBackwards ){
			prevStackID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition + 1);
		}
		var prevStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), prevStackID);
		ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, prevStackRow, false);
	}
	
	// Filter the current stack
	var currentStackID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition);
	var currentStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentStackID);
	ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, currentStackRow, true);
			
	// Render the filter in the mainscreen
	with (obj_control) {
		scr_renderFilter();
	}
	

	
}
// If we are at the end of the list, then hop out of the filter
else if(obj_control.currentStackShowListPosition == (ds_list_size(obj_control.stackShowList))) {
	if(obj_toolPane.tracksOnlyStackShow) {
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
	
		obj_dialogueBox.elmoActive = true;	
	}
	// I'll need to refactor this into scr_endStackShow();
	
	obj_control.stackShowActive = false;
	obj_toolPane.tracksOnlyStackShow = false;
	obj_toolPane.rezOnlyStackShow = false;
	
	with(obj_panelPane){
		alarm[5] = -1;
	}
	obj_panelPane.timerMins = 0;
	obj_panelPane.timerSecs = 0;
	//Set currentStackShowListPosition to -1
	obj_control.currentStackShowListPosition = -1;
	
	//Clear stackShowList
	ds_list_clear(obj_control.stackShowList);
	
	// Exit the filter
	ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
	
	// Switch to active grid
	//obj_dialogueBox.stackShowWindowActive = false;
	obj_control.filterGridActive = false;
	obj_control.currentActiveLineGrid = obj_control.lineGrid;
	obj_control.scrollPlusYDest = obj_control.prevCenterDisplayRow;
	
	// If the transcriptView was active before the stackShow, switch it back
	if(obj_control.stackShowSwitchedWordView == true) {
		obj_control.stackShowSwitchedWordView = false;
		if(obj_control.wordTranscriptView) {
			
			obj_control.wordTranscriptView = !obj_control.wordTranscriptView;

			for (var i = 0; i < ds_grid_height(obj_control.dynamicWordGrid); i++) {
				var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i);
				var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, i);
				var currentReplaceWord = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, i);
	
				if (string_length(currentReplaceWord) > 0) {
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentReplaceWord);
				}
				else {
					if (obj_control.wordTranscriptView) {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordToken);
					}
					else {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordTranscript);
					}
				}
			}
		}
	}
	if(obj_control.stackShowSwitchedTextShape) {
		obj_control.shape = obj_control.shapeBlock;
		obj_control.stackShowSwitchedTextShape = false;
	}
	
	//var currentUser = ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colAuthor, obj_chain.currentFocusedChainIndex);
	//if(string_lower(currentUser) == "player") {
		// Show the ending screen
		//var scoreString = "Good Job! Total Score: ";
		//for(var scoreLoop = 0; scoreLoop < ds_grid_height(obj_chain.goldStandardGrid); scoreLoop++) {
		//	scoreString += " " + string(ds_grid_get(obj_chain.goldStandardGrid, obj_chain.goldStandardGrid_colScore, scoreLoop)) + ",";
		//}
		//show_message(scoreString);
	//}
	
	
	
}