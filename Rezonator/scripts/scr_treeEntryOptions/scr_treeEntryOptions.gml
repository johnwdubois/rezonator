// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_treeEntryOptions(optionSelected){
	
	if(optionSelected == "option_delete-branch"){
		scr_deleteTreeBranch()
	}
	if(optionSelected == "option_delete-entry"){
		scr_deleteTreeEntry()
	}
	
	with (obj_dropDown) instance_destroy();
}