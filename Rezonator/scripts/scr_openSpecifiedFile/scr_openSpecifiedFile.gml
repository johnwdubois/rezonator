// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_openSpecifiedFile(optionSelected){
	if(optionSelected == "SBC001"){
		global.rezString = scr_getJSONStr();
	}
	else if(optionSelected == "SBC002"){
		global.rezString = scr_getJSONStr1();
	}
	else if(optionSelected == "SBC003"){
		global.rezString = scr_getJSONStr2();
	}
	
	global.newProject = false;
	global.openProject = true;
}