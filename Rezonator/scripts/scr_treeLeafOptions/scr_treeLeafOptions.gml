// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_treeLeafOptions(optionSelected){
	
	if(optionSelected == "option_separate-chunk"){
		scr_separateChunk();
	}
	
	with (obj_dropDown) instance_destroy();
}