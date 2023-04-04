function scr_windowExit() {
	
	if (BUILDTYPE == "Web") exit;
	
	if (window_command_check(window_command_close)) {
		
		if (room == rm_mainScreen) {
			
			with (obj_dialogueBox) {
				scr_closeDialogueBoxVariables();
				instance_destroy();
			}
		
			if (!instance_exists(obj_dialogueBox)) {
				var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				inst.questionWindowActive = true;
				inst.noButtonActive = true;
				obj_control.saveBeforeGameEnd = true;
				
				// if everything is saved already we can just exit out
				if (obj_control.allSaved) game_end();
			}
		}
		else {
			show_debug_message("scr_windowExit, game end...");
			game_end();
		}
	}

}