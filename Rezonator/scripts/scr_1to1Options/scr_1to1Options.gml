// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_1to1Options(optionSelected){
	
	if (optionSelected == "One to one") {
		with (obj_panelPane) chainViewOneToMany = false;
	}
	else if (optionSelected == "One to many") {
		with (obj_panelPane) chainViewOneToMany = true;
	}
	
}