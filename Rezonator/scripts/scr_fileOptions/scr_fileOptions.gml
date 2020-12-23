function scr_fileOptions(optionSelected) {

	switch (optionSelected)
	{
		case "Open":
		//room_instance_clear(rm_mainScreen);
		
		// destroy grid
		
		// get file name + extension
		
		// distinguish between rez or xml
		
		//room_restart();
		
			show_message("Coming Soon");
			break;
				
		case "menu_save":
			var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
			instLoading.loadSprite = spr_saving;
		
			draw_set_alpha(1);
			draw_set_color(obj_toolPane.progressBarFrontColor);
			draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
			draw_set_color(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			scr_adaptFont( scr_get_translation("save_saving"),"S");
			draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), scr_get_translation("save_saving"));
		
			obj_fileLoader.ableToHotkey = false;
			with(obj_fileLoader){
				alarm[0] = 3;
			}
			break;
		case "menu_save-as":
			var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
			instLoading.loadSprite = spr_saving;
		
			draw_set_alpha(1);
			draw_set_color(obj_toolPane.progressBarFrontColor);
			draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
			draw_set_color(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			scr_adaptFont( scr_get_translation("save_saving"),"S");
			draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), scr_get_translation("save_saving"));
			
			obj_fileLoader.ableToHotkey = false;
			global.fileSaveName = ""; // reset fileSaveName so they can save as whatever
			with(obj_fileLoader){
				alarm[0] = 3;
			}
			break;
		case "menu_import":
			
			audio_stop_all();
	

			scr_saveINI();
	
			if (!obj_control.allSaved and ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
		
				if (os_type == os_macosx) {

					with (obj_fileLoader) {
						scr_saveREZ(false);
					}
		
				}
				else {
					scr_adaptFont(scr_get_translation("question_save_before_import"), "M");
					if (show_question(scr_get_translation("question_save_before_import"))) {
						with (obj_fileLoader) {
							scr_saveREZ(false);
						}
					}
				}
			}
			
			global.skipToImportScreen = true;
			room_goto(rm_openingScreen);
			
			break;
		case "menu_export":
			
		
			obj_fileLoader.ableToHotkey = false;
			
			with(obj_fileLoader){
				alarm[5] = 2;
			}
			
			break;
		case "Clip":
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.ePressed = true;
			}

			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			//show_message("BUH 3");
			break;
		case "menu_media":

			with( obj_audioUI ){
			
				var getAudioFile = get_open_filename_ext("ogg file|*.ogg", "", working_directory, "Open a discourse ogg OGG file");
					if (getAudioFile != "" and file_exists(getAudioFile)) {
						audioFile = getAudioFile;
						audioStream = audio_create_stream(audioFile);
						audioSound = audio_play_sound(audioStream, 100, false);
						visible = true;
					}
			
			}

			//show_message("Coming Soon");
			break;	
		case "menu_exit":
		
		
			audio_stop_all();
	
			scr_saveINI();
	
	
			if (!obj_control.allSaved and ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
		
				if (os_type == os_macosx) {

				
					with(obj_fileLoader){
						scr_saveREZ(false);
					}
		
				}
				else {
					scr_adaptFont(scr_get_translation("question_save_before_exit"), "M");
					if (show_question(scr_get_translation("question_save_before_exit"))) {
						with(obj_fileLoader){
							scr_saveREZ(false);
						}
					}
				}
			}

			keyboard_string = "";
			room_goto(rm_openingScreen);
		
			//show_message("BUH 5");
			break;
		default:
			break;
	}


}
