///@description Stack Show
/*
	obj_control: Key Press - Tab
	
	Last Updated: 2018-02-05
	
	Purpose: Cycle through main screen and navWindows using the Tab key
	
	Mechanism: Loop through panelpane instances to find the chainList and chainContents windows, then 3-way toggle through booleans
	
	Author: Terry DuBois, Georgio Klironomos
*/


var panelPaneChainListID = -1;
var panelPaneChainContentsID = -1;

// Loop through instances of panelPane.
for (var i = 0; i < instance_number(obj_panelPane); i++) {
	var currentPanelPane = instance_find(obj_panelPane, i);
	
	// Find both chainList and chainContents
	if (currentPanelPane.currentFunction == obj_panelPane.functionChainList) {
		panelPaneChainListID = currentPanelPane;
	}
	else if (currentPanelPane.currentFunction == obj_panelPane.functionChainContents) {
		panelPaneChainContentsID = currentPanelPane;
	}
}

// Safety check
if (!instance_exists(panelPaneChainListID) or !instance_exists(panelPaneChainContentsID)) {
	exit;
}

// Toggle through booleans to cycle selected windows.
if (panelPaneChainListID.clickedIn) {
	panelPaneChainListID.clickedIn = false;
	panelPaneChainContentsID.clickedIn = true;
}
else if (panelPaneChainContentsID.clickedIn) {
	panelPaneChainListID.clickedIn = false;
	panelPaneChainContentsID.clickedIn = false;
}
else {
	panelPaneChainListID.clickedIn = true;
	panelPaneChainContentsID.clickedIn = false;
}

/* StackShow Prototype
	-At some point, A list of all the current Stacks will be created
		-When will this list be created? Maybe now...
	-Once TAb is pressed for the frst time, The first Stack in this list will be filtered
		-How will we keep track of which Stack we're on? obj_control.currentStackShowListPosition
	-From there on, TAB will switch the user to the next Stack, switching the filter
	-ONce on the last Stack, TAB will exit StackShow, turning off the filter and showing the Main Screen
	
*/
//show_message(string(currentStackShowListPosition));
//show_message(scr_getStringOfList(stackShowList));




//obj_control.stackShowWindowActive = true;

/*

// If we have not started the stackShow yet
if(currentStackShowListPosition == -1) {
	//Create the list
	//set currentStackShowListPosition to 0

	
	obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
	// Instantiate the screen for users to select which stacks go in the stackShow

	if (!instance_exists(obj_stackShow)) {
		instance_create_layer(x, y, "InstancesAudio", obj_stackShow);
	}
		obj_control.stackShowWindowActive = true;
}
// If the stackShow is in progress
else {
	// Let the stackShow move on to the next stack
	scr_stackShow();	
}
/*
if(ds_list_size(stackShowList) > 0 && currentStackShowListPosition != (ds_list_size(stackShowList))) {
	// Filter on ds_list_get_value(stackShowList, currentStackShowListPosition);
	
	if(currentStackShowListPosition > 0) {
		var prevStackID = ds_list_find_value(stackShowList, currentStackShowListPosition - 1);
		var prevStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), prevStackID);
		ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, prevStackRow, false);
	}
	
	var currentStackID = ds_list_find_value(stackShowList, currentStackShowListPosition);
	var currentStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentStackID);
	ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, currentStackRow, true);
			
	// Render the filter in the mainscreen
	//if (filterGridActive) {
		scr_renderFilter();
	//}
	currentStackShowListPosition++;
}
else if(currentStackShowListPosition == (ds_list_size(stackShowList))) {
	//Set currentStackShowListPosition to -1
	currentStackShowListPosition = -1;
	//Clear stackShowList
	ds_list_clear(stackShowList);
	// Exit the filter
	ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
	// Switch to active grid
	obj_control.filterGridActive = false;
	obj_control.currentActiveLineGrid = obj_control.lineGrid;
}*/

/*
if (!instance_exists(obj_dialogueBox)) {
	instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
}*/