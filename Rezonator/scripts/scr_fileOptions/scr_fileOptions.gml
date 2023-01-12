function scr_fileOptions(optionSelected) {
	
	var optionIndex = ds_list_find_index(optionList, optionSelected);

	switch (optionSelected)
	{
		case "Open":
			
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "sbc001.rez", "sbc002.rez", "sbc003.rez", "sbc004.rez", "sbc005.rez", "sbc006.rez", "sbc007.rez", "sbc008.rez", "sbc009.rez", "sbc010.rez");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeOpenFile);
			}
		
			break;
		
		case "help_label_open":
		//room_instance_clear(rm_mainScreen);
		
		// destroy grid
		
		// get file name + extension
		
		// distinguish between rez or xml
		
		//room_restart();
		
			//show_debug_message("Coming Soon");
			break;
				
		case "menu_save":
			
			//var filepath = working_directory + "abc.txt"
			//var file = file_text_open_write(filepath);
			//file_text_write_string(file, "abc");
			//file_text_close(file);
			
			//var fileread = file_text_open_read(filepath);
			//show_message("line: " + file_text_readln(fileread));
			//file_text_close(fileread);
			
			
			//show_message("file: " + string(file));
			//show_message("file exists: " + string(file_exists(filepath)));
			
			//download_file_inbrowser(filepath);
			//var file = get_save_filename_ext("REZ file|*.rez", "", program_directory, "Save REZ");
			//show_debug_message("file: " + string(file));
			//var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
			//instLoading.loadSprite = spr_saving;

			//obj_fileLoader.ableToHotkey = false;
			//with(obj_fileLoader){
			//	alarm[0] = 3;
			//}
			break;
		case "menu_save-as":
			var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
			instLoading.loadSprite = spr_saving;

			obj_fileLoader.ableToHotkey = false;
			global.fileSaveName = ""; // reset fileSaveName so they can save as whatever
			with(obj_fileLoader){
				alarm[0] = 3;
			}
			break;
		case "menu_import":
			
			if(room == rm_mainScreen){

				if (!instance_exists(obj_dialogueBox)) {
					var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					inst.questionWindowActive = true;
					inst.noButtonActive = true;
					obj_control.saveBeforeImporting = true;
					global.skipToImportScreen = true;
					
				
					// if everything is saved already we can just pretend they clicked "no"
					scr_dialogueNo();
				}
				scr_saveINI();
			}
			else {
				global.skipToImportScreen = true;
				show_debug_message("Going to openingScreen, scr_fileOptions 1");
				room_goto(rm_openingScreen);
				scr_loadINI();
			}
			
			instance_destroy();
			break;
			
		case "menu_export":
			
		
			obj_fileLoader.ableToHotkey = false;
			
			with(obj_fileLoader){
				alarm[5] = 2;
			}
			
			
			break;
		case "option_clip":
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.ePressed = true;
			}

			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			obj_dialogueBox.inputWindowActive = true;

			break;
		case "menu_media":

			with( obj_audioUI ){
			
				var getAudioFile = get_open_filename_ext("ogg file|*.ogg", "", working_directory, scr_get_translation("msg_file_audio"));
					if (getAudioFile != "" and file_exists(getAudioFile)) {
						if(global.steamAPI){
							if(!steam_get_achievement("SA_play-audio")){
								steam_set_achievement("SA_play-audio");
							}
						}
						audioFile = getAudioFile;
						audioStream = audio_create_stream(audioFile);
						audioSound = audio_play_sound(audioStream, 100, false);
						visible = true;
					}
			
			}

			break;	
		case "menu_exit":

			keyboard_string = "";
			if (!instance_exists(obj_dialogueBox)) {
				var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				inst.questionWindowActive = true;
				inst.noButtonActive = true;
				obj_control.saveBeforeExiting = true;
				scr_saveINI();
				var defStr = "";
				defStr = (global.userName == "") ? scr_get_translation("msg_signin") : global.userName;
				global.inputBoxDefStr = defStr;
				// if everything is saved already we can just pretend they clicked "no"
				scr_dialogueNo();
			}

			instance_destroy();
			break;
		default:
			break;
	}


}
