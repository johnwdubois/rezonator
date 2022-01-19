

function scr_treeLeafOptions(optionSelected){
	
	if(optionSelected == "option_separate-chunk"){
		scr_separateChunk();
	}
	
	with (obj_dropDown) instance_destroy();
}