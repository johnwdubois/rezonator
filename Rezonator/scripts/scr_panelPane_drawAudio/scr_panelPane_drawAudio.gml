function scr_panelPane_drawAudio() {
	// draw import UI
	/*
	draw_set_font(global.fontChainList);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	var importAudioButtonString = " Import OGG Audio ";
	var importAudioButtonX1 = x + 20;
	var importAudioButtonY1 = y + 20;
	var importAudioButtonX2 = importAudioButtonX1 + string_width(importAudioButtonString);
	var importAudioButtonY2 = importAudioButtonY1 + string_height(importAudioButtonString);

	if (point_in_rectangle(mouse_x, mouse_y, importAudioButtonX1, importAudioButtonY1, importAudioButtonX2, importAudioButtonY2)) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(importAudioButtonX1, importAudioButtonY1, importAudioButtonX2, importAudioButtonY2, false);
	
		if (mouse_check_button_pressed(mb_left)) {
			functionAudio_filename = get_open_filename_ext("audio file|*.ogg", "", working_directory, "Open a discourse audio OGG file");		
			if (functionAudio_filename == "") {
				exit;
			}
			else if (not file_exists(functionAudio_filename)) {
				functionAudio_filename = "";
			}
		
			global.audioFilename = functionAudio_filename;
			instance_create_layer(x, y, "InstancesAudio", obj_audioUI);
		
		}
	}

	draw_set_color(global.colorThemeText);
	draw_text(importAudioButtonX1, mean(importAudioButtonY1, importAudioButtonY2), importAudioButtonString);

	draw_set_color(global.colorThemeBorders);
	draw_rectangle(importAudioButtonX1, importAudioButtonY1, importAudioButtonX2, importAudioButtonY2, true);

	draw_set_color(global.colorThemeText);
	draw_set_font(global.fontPanelTab);
	draw_set_alpha(0.75);
	draw_text(importAudioButtonX1, y + windowHeight - 20, "Audio File: " + string(functionAudio_filename));




	*/


}
