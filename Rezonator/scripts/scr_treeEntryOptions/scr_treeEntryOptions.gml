// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_treeEntryOptions(optionSelected){
	
	if(optionSelected == "Delete Branch"){
		scr_deleteTreeBranch()
	}
	
	with (obj_dropDown) instance_destroy();
}