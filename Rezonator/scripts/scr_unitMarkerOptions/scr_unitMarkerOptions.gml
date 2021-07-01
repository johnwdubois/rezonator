function scr_unitMarkerOptions(optionSelected) {

	if (optionSelected == "Create new field") {

		// prompt user for name of new unit field/marker

		obj_control.newCustomFieldUnit = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	
	}
	else if (optionSelected == "Add to tag set") {
		scr_unitTagMapOptions("Add to tag set");
	}
	else if(optionSelected == "Show in translation tab"){
		scr_addToListOnce(global.translationList, obj_control.unitFieldToChange);
		global.currentTranslation = obj_control.unitFieldToChange;
		with (obj_dropDown) instance_destroy();
		scr_addToListOnce(obj_control.panelPaneTabList, obj_panelPane.functionChainList_tabTranslations);
	}


}
