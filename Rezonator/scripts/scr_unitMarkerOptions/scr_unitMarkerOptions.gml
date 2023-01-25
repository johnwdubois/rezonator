function scr_unitMarkerOptions(optionSelected) {

	if (optionSelected == "option_create-new-field") {

		// prompt user for name of new unit field/marker

		obj_control.newCustomFieldUnit = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	
	}
	else if (optionSelected == "option_add-to-tag-set") {
		scr_unitTagMapOptions("option_add-to-tag-set");
	}
	else if (optionSelected == "Show in translation tab") {
		scr_addToListOnce(global.translationList, obj_control.unitFieldToChange);
		global.currentTranslation = obj_control.unitFieldToChange;
		with (obj_dropDown) instance_destroy();
		var indexOfTranslation = ds_list_find_index(obj_control.panelPaneTabList, obj_panelPane.functionChainList_tabTranslations);
		if (indexOfTranslation < 0) {
			ds_list_insert(obj_control.panelPaneTabList, 2, obj_panelPane.functionChainList_tabTranslations);
		}
	}


}
