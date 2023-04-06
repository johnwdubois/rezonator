function scr_cliqueRightClickOptions(optionSelected){
	
	if (optionSelected == "option_rename-clique") {
		scr_createDialogBox(DIALOG_INPUT_RENAMECLIQUE, true);
		with (obj_dialogueBox) inputWindowActive = true;
	}

}