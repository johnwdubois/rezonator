var optionSelected = argument0;

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
				
	case "Save":
		
		draw_set_alpha(1);
		draw_set_color(obj_toolPane.progressBarFrontColor);
		draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
		draw_set_color(c_white);
		draw_set_font(obj_toolPane.progressBarFont);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), "Saving...");
		draw_set_font(fnt_dropDown);
		
		obj_fileLoader.ableToHotkey = false;
			
		with(obj_fileLoader){
			alarm[0] = 1;
		}
			
		//show_message("BUH 2");
		break;
	case "Import":
	//room_instance_clear(rm_mainScreen);
		
	// destroy grid
		
	// get file name + extension
		
	// distinguish between rez or xml
		
	//room_restart();
		
		show_message("Coming Soon");
		break;
	case "Export":
			
		draw_set_alpha(1);
		draw_set_color(obj_toolPane.progressBarFrontColor);
		draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
		draw_set_color(c_white);
		draw_set_font(obj_toolPane.progressBarFont);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), "Exporting...");
		draw_set_font(fnt_dropDown);
		
		obj_fileLoader.ableToHotkey = false;
			
		with(obj_fileLoader){
			alarm[5] = 1;
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
	case "Media":

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
	case "Exit":
		
		
		audio_stop_all();
	
		scr_userSettingsIniFile();
	
	
		if (!obj_control.allSaved and ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
		
			if (os_type == os_macosx) {

				with (obj_fileLoader) {
					scr_saveREZ(false);
				}
		
			}
			else {
				if (show_question("Would you like to save before exiting?")) {
					with (obj_fileLoader) {
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