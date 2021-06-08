function scr_unitMarkerOptions(optionSelected) {

	if (optionSelected == "Create Field") {

		// prompt user for name of new unit field/marker

		obj_control.newCustomFieldUnit = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
	
	}
	else if (optionSelected == "Add new Tag") {
		scr_unitTagMapOptions("Add new Tag");
	}
	else if(optionSelected == "Set as Translation"){
		scr_addToListOnce(global.translationList, obj_control.unitFieldToChange);
		global.currentTranslation = obj_control.unitFieldToChange;
		with (obj_dropDown) instance_destroy();
		scr_addToListOnce(obj_control.panelPaneTabList, obj_panelPane.functionChainList_tabTranslations);
	}


}
