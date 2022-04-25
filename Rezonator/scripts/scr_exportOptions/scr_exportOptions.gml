// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportOptions(optionSelected){
	if(optionSelected == "CSV Export"){
		obj_fileLoader.alarm[5] = 2;
	}
	else if(optionSelected  == "CONLL-U Export"){
		scr_conlluExport();
	}
	with(obj_dropDown){
		instance_destroy();	
	}
}