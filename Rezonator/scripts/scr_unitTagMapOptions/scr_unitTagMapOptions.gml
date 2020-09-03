var optionSelected = argument[0];

if (optionSelected == "Add new Tag") {


	obj_control.newCustomTagUnit = true;
	obj_control.dialogueBoxActive = true;

	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
	
}
else {
	ds_grid_set(global.unitImportGrid, obj_control.unitImportColToChange, obj_control.unitImportRowToChange, optionSelected);
	
	// update changes in tokenImportGrid
	var unitID = ds_grid_get(global.unitImportGrid, global.unitImport_colUnitID, obj_control.unitImportRowToChange);
	var unitImportColName = ds_list_find_value(global.unitImportColNameList, obj_control.unitImportColToChange);
	var tokenImportColToChange = ds_list_find_index(global.tokenImportColNameList, unitImportColName);
	if (tokenImportColToChange > -1) {
		var tokenImportGridHeight = ds_grid_height(global.tokenImportGrid);
		for (var i = 0; i < tokenImportGridHeight; i++) {
			if (ds_grid_get(global.tokenImportGrid, global.tokenImport_colUnitID, i) == unitID) {
				ds_grid_set(global.tokenImportGrid, tokenImportColToChange, i, optionSelected);
			}
		}
	}
}

if (obj_control.unitView == obj_panelPane.selectedColUnit) {
	scr_toggleUnitMulti(global.unitImportGrid, obj_control.unitImportColToChange);
}