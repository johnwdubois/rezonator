

function scr_treeEntryOptions(optionSelected) {
	
	if (optionSelected == "option_delete-branch") {
		scr_deleteTreeBranch()
	}
	if (optionSelected == "option_delete-entry") {
		scr_deleteTreeEntry()
	}
	
	with (obj_dropDown) instance_destroy();
}