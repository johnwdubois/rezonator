///@description scr_panelPane_sortDefaultSetup();
scr_panelPane_sortDefaultSetup();
for (var i = 0; i < instance_number(obj_panelPane); i++) {
	var currentPane = instance_find(obj_panelPane, i);
	if (currentPane.currentFunction == obj_panelPane.functionChainList) {
		chainListPane = currentPane;
	}
}