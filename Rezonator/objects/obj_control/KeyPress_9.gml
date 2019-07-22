///@description Nav/Main Focuser
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