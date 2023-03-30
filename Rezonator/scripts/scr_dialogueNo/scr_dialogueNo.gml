function scr_dialogueNo() {
	
	show_debug_message("scr_dialogueNo");
	
	with (obj_dialogueBox) {
	
		
		if (questionWindowActive) {
		
			if (instance_exists(obj_stacker)) {
				if (obj_stacker.confirmStackCreate) {
					obj_stacker.confirmStackCreate = false;
					with (obj_stacker) alarm[11] = 2;
				}
				else if (obj_stacker.confirmStackName) {
					scr_stackerBranch();
				}
			}
		
			if (instance_exists(obj_control)) {
				if (obj_control.saveBeforeExiting || obj_control.saveBeforeImporting || obj_control.saveBeforeOpening || obj_control.saveBeforeAiChat) {
					global.skipToImportScreen = obj_control.saveBeforeImporting;
					global.skipToOpen = obj_control.saveBeforeOpening;
					global.skipToAiChat = obj_control.saveBeforeAiChat;
					if (global.html5) global.html5RezFile = "";
					show_debug_message("Going to openingScreen, scr_dialogueNo");
					room_goto(rm_openingScreen);
					scr_loadINI();
				}
				if (obj_control.saveBeforeGameEnd) {
					game_end();
				}
			}
			instance_destroy();
		}
	}

}