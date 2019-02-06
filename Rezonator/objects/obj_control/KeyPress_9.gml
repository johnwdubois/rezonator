// Cycle between windows using Tab key

var panelPaneChainListID = -1;
var panelPaneChainContentsID = -1;
for (var i = 0; i < instance_number(obj_panelPane); i++) {
	var currentPanelPane = instance_find(obj_panelPane, i);
	
	//show_message(string(object_get_name(currentPanelPane.object_index)));
	
	if (currentPanelPane.currentFunction == obj_panelPane.functionChainList) {
		panelPaneChainListID = currentPanelPane;
	}
	else if (currentPanelPane.currentFunction == obj_panelPane.functionChainContents) {
		panelPaneChainContentsID = currentPanelPane;
	}
}

if (!instance_exists(panelPaneChainListID) or !instance_exists(panelPaneChainContentsID)) {
	exit;
}



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