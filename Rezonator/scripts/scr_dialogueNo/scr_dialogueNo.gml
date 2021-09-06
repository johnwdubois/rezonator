// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dialogueNo(){
	
	show_debug_message("scr_dialogueNo");
	if(questionWindowActive){
		
		
		
		if (instance_exists(obj_stacker)) {
			if (obj_stacker.confirmStackCreate) {
				scr_stackerBranch();
			}
		}
		
		if (instance_exists(obj_control)) {
			if (obj_control.saveBeforeExiting || obj_control.saveBeforeImporting) {
				global.skipToImportScreen = obj_control.saveBeforeImporting;
				show_debug_message("Going to openingScreen, scr_dialogueNo");
				room_goto(rm_openingScreen);
				scr_loadINI();
			}
		}
		
		scr_closeQuestionBoxVariables();
		instance_destroy();
	}

}