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
		
		scr_closeQuestionBoxVariables();
		instance_destroy();
	}

}