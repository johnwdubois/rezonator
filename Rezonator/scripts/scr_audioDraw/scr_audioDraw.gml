function scr_audioDraw() {
	
	// Get dimensions of whole GUI window
	windowHeight = (camera_get_view_height(camera_get_active())) * 0.08;
	windowWidth = camera_get_view_width(camera_get_active()) - global.toolPaneWidth;
	x = 0;
	y = (camera_get_view_height(camera_get_active())) - windowHeight;
	  
	var progressColor = c_orange;

	// draw GUI background
	var bgColor = make_color_rgb(125, 125, 128);
	draw_set_color(bgColor);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
	if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		mouseOverAudioUI = true;
	}

	// draw track title
	draw_set_color(global.colorThemeBG);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	var audioFileX = floor(x + (windowWidth * mean(0.02, 0.15)));
	var audioFileY = floor(y + 24);
	var strHeight = string_height("0");
	var audioFileStr = audioFileExists ? filename_name(audioFile) : "";
	scr_adaptFont(audioFileStr, "S");
	draw_text(audioFileX, audioFileY, audioFileStr);
	
	if (point_in_rectangle(mouse_x, mouse_y, x, y, seekBarX1 - string_width("AAAAAAA"), y + windowHeight) && audioFile != "" && audioFileExists) {
		scr_createTooltip(mean(x, seekBarX1 - string_width("AAAAAAA")), y, string(audioFile), obj_tooltip.arrowFaceDown);
	}
	
	playheadRadSmall = strHeight * 0.2;
	playheadRadBig = strHeight * 0.3;
	


	// draw seekbar BG
	draw_set_color(bgColor);
	draw_rectangle(seekBarX1 - string_width("AAAAAAA"), y, seekBarX2 + string_width("AAAAAAA"), y + windowHeight, false);

	
	// draw play/pause button
	var playTriangleWidth = strHeight * 0.9;
	var playTriangleHeight = strHeight * 0.8;
	var playPauseX = mean(seekBarX1, seekBarX2);
	var playPauseY = y + (windowHeight * 0.35) - (playTriangleHeight * 0.5);
	var pauseLineLeftX = x + (windowWidth * 0.5) - (7);
	var pauseLineRightX = x + (windowWidth * 0.5) + (7);
	var pauseLineY1 = y + (windowHeight * 0.35) - (playTriangleHeight * 0.5);
	var pauseLineY2 = pauseLineY1 + playTriangleHeight;
	var playPauseMouseY1 = clamp(pauseLineY1 - (strHeight * 0.5), y, seekBarY1);
	var playPauseMouseY2 = clamp(pauseLineY2 + (strHeight * 0.5), y, seekBarY1);
	var mouseoverSeekbar = point_in_rectangle(mouse_x, mouse_y, seekBarX1 - (playheadRad * 2), seekBarY1 - (playheadRad * 2), seekBarX2 + (playheadRad * 2), seekBarY2 + (playheadRad * 2));
	var mouseOverPlayPause = point_in_rectangle(mouse_x, mouse_y, pauseLineLeftX - (strHeight * 0.5), playPauseMouseY1, pauseLineRightX + (strHeight * 0.5), playPauseMouseY2);
	
	if (audioPaused) {
		// draw play triangle
		var playTriangleX1 = x + (windowWidth * 0.5) - (playTriangleWidth * 0.5);
		var playTriangleY1 = y + (windowHeight * 0.35) - (playTriangleHeight * 0.5);
		var playTriangleX2 = playTriangleX1;
		var playTriangleY2 = playTriangleY1 + playTriangleHeight;
		var playTriangleX3 = playTriangleX1 + playTriangleWidth;
		var playTriangleY3 = mean(playTriangleY1, playTriangleY2);
		draw_set_color((mouseOverPlayPause) ? global.colorThemeSelected1 : global.colorThemeBG);
		draw_triangle(playTriangleX1, playTriangleY1, playTriangleX2, playTriangleY2, playTriangleX3, playTriangleY3, false);
	}
	else {
		// draw pause
		draw_set_color((mouseOverPlayPause) ? global.colorThemeSelected1 : global.colorThemeBG);
		draw_line_width(pauseLineLeftX, pauseLineY1, pauseLineLeftX, pauseLineY2, 5);
		draw_line_width(pauseLineRightX, pauseLineY1, pauseLineRightX, pauseLineY2, 5);
	}
	
	if (mouseOverPlayPause) {
		//draw_rectangle(pauseLineLeftX - (strHeight * 0.5), playPauseMouseY1, pauseLineRightX + (strHeight * 0.5), playPauseMouseY2, true);
		scr_createTooltip(mean(pauseLineLeftX, pauseLineRightX), pauseLineY1 - (strHeight * 0.25), (audioPaused) ? scr_get_translation("help_label_play") : scr_get_translation("option_pause"), obj_tooltip.arrowFaceDown);
	}

	
	// Check for mouseClick on play/pause button
	if (mouseOverPlayPause) {
		if (mouse_check_button_pressed(mb_left)) {
			if (audioFileExists) {
				audioPaused = !audioPaused;
			}
		}
	}
	
	// Check for Spacebar to toggle play/pause and set Bookmark
	if (keyboard_check_released(vk_space) and !instance_exists(obj_dialogueBox) && audioSound != -1) {
	/*
		if (bookmarkStartTime > -1) {
			if (audioPaused) {
				audio_sound_set_track_position(audioSound, bookmarkStartTime);
				audioPaused = !audioPaused;
			}
			else {
				audioPaused = !audioPaused;
			}
		}
		else {
	*/		
			audioPaused = !audioPaused;
			
	//	}
	}
	
	
	// Check for Enter to set bookmark
	if (keyboard_check_pressed(vk_enter) and !instance_exists(obj_dialogueBox) && audioSound != -1 && !instance_exists(obj_inputBox) && obj_control.navWindowTaggingID == "") {

		bookmarkStartTime = audioPos;
		audio_sound_set_track_position(audioSound, bookmarkStartTime);
		bookmarkEndTime = -1;
		if (audioPaused) {
			audioPaused = !audioPaused;
		}

	}
	

	// draw seekbar
	seekBarWidth = camera_get_view_width(camera_get_active()) / 2;
	seekBarX1 = mean(x, x + windowWidth) - (seekBarWidth / 2);
	seekBarY1 = y + (windowHeight * 0.75) - (seekBarHeight / 2);
	seekBarX2 = seekBarX1 + seekBarWidth;
	seekBarY2 = seekBarY1 + seekBarHeight;
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(seekBarX1, seekBarY1, seekBarX2, seekBarY2, false);
	draw_set_color(progressColor);
	draw_rectangle(seekBarX1, seekBarY1, playheadX, seekBarY2, false);
	
		// Draw audio Bookmark
	if (bookmarkStartTime > -1) {
		
		//Draw bookmarks
		bookmarkX = ((real(bookmarkStartTime) * real(seekBarWidth)) / audioLength) + seekBarX1;
		bookmarkY = seekBarY1 - (playheadRad*1.5);
		var bookmarkWidth = windowWidth*0.001;
		//draw_set_halign(fa_right);
		//draw_set_color(c_white);
		//draw_rectangle(bookmarkX - bookmarkWidth, bookmarkY ,bookmarkX + bookmarkWidth, bookmarkY + playheadRad*4, false);
		//draw_sprite_ext(spr_linkArrow, 0, bookmarkX, bookmarkY, 0.4, 0.4, 270, c_white, 1);
	}



	// draw playhead circle
	playheadX = ((audioPos * seekBarWidth) / audioLength) + seekBarX1;
	playheadY = mean(seekBarY1, seekBarY2);
	draw_set_color(progressColor);
	draw_set_circle_precision(64);
	if (abs(audioPos - audioPosTemp) > 5 and not playheadHolding) {
		draw_set_alpha(0);
	}
	draw_circle(playheadX, playheadY, playheadRad, false);
	draw_set_alpha(1);
	
	//Check for mousehover/click on Playhead
	var playheadHoldable = false;

	if ((mouseoverSeekbar or playheadHolding) && audioSound != -1 && audioFileExists) {
		playheadHoldable = true;
	}
	if (playheadHoldable and !mouseOverPlayPause) {
		playheadRadDest = playheadRadBig;
		if (mouse_check_button_pressed(mb_left)) {
			playheadHolding = true;
			bookmarkStartTime = -1;
		}
	}
	else {
		playheadRadDest = playheadRadSmall;
	}
	playheadRad = lerp(playheadRad, playheadRadDest, 0.5);


	if (!mouse_check_button(mb_left) && audioSound != -1) {
		if (playheadHolding) {
			audioPosTemp = clamp(audioPosTemp, 0, audioLength);
			audio_sound_set_track_position(audioSound, audioPosTemp);
			playheadHolding = false;
			playheadRad = 0;
		}
	}
	if (playheadHolding) {
		playheadX = clamp(mouse_x, seekBarX1, seekBarX2);
		audioPosTemp = ((playheadX - seekBarX1) * audioLength) / seekBarWidth;
	}
	else {
		audioPosTemp = audioPos;
	}

	// draw time lengths
	var audioPosCurrent = (playheadHolding) ? audioPosTemp : audioPos;
	var strCurrentMinutes = string(floor(audioPosCurrent / 60));
	var strCurrentSeconds = string(floor(audioPosCurrent % 60));
	var strTotalMinutes = string(floor(audioLength / 60));
	var strTotalSeconds = string(floor(audioLength % 60));
	if (string_length(strCurrentMinutes) < 2) {
		strCurrentMinutes = "0" + string(floor(audioPosCurrent / 60));
	}
	if (string_length(strCurrentSeconds) < 2) {
		strCurrentSeconds = "0" + string(floor(audioPosCurrent % 60));
	}
	if (string_length(strTotalMinutes) < 2) {
		strTotalMinutes = "0" + string(floor(audioLength / 60));
	}
	if (string_length(strTotalSeconds) < 2) {
		strTotalSeconds = "0" + string(floor(audioLength % 60));
	}
	draw_set_color(global.colorThemeBG);
	draw_set_valign(fa_middle);
	var timeXBuffer = 20;
	draw_set_halign(fa_left);
	var timeRemaining = string_hash_to_newline(strTotalMinutes + ":" + strTotalSeconds);
	draw_text(seekBarX2 + timeXBuffer, mean(seekBarY1, seekBarY2), timeRemaining);
	draw_set_halign(fa_right);
	var timePassed = string_hash_to_newline(strCurrentMinutes + ":" + strCurrentSeconds);
	draw_text(seekBarX1 - timeXBuffer, mean(seekBarY1, seekBarY2), timePassed);


	// draw jumpToUnit toggle
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	var jumpUnitStartTextX = x + windowWidth - string_width("A");
	var jumpUnitStartTextY = y + (windowHeight * 0.25);
	var jumpUnitText = "Click to Play Audio"//scr_get_translation("msg_audio-update");

	var jumpUnitStartRectX1 = jumpUnitStartTextX - string_width(jumpUnitText) - string_width("A");
	var jumpUnitStartRectY1 = max(y, jumpUnitStartTextY - strHeight * 0.55);
	var jumpUnitStartRectX2 = jumpUnitStartRectX1 - strHeight;
	var jumpUnitStartRectY2 = jumpUnitStartTextY + strHeight * 0.55;
	
	
	draw_text(jumpUnitStartTextX, jumpUnitStartTextY, jumpUnitText);

	if (point_in_rectangle(mouse_x, mouse_y, jumpUnitStartRectX2, jumpUnitStartRectY1, jumpUnitStartRectX1, jumpUnitStartRectY2)
	and mouse_check_button_released(mb_left)) {
		audioJumpOnWordClick = !audioJumpOnWordClick;
	}
	
	if (audioJumpOnWordClick) {
		draw_set_color(merge_color(global.colorThemeBG, bgColor, 0.5));
		draw_rectangle(jumpUnitStartRectX1, jumpUnitStartRectY1, jumpUnitStartRectX2, jumpUnitStartRectY2, false);
		draw_sprite_ext(spr_checkmark, 0, mean(jumpUnitStartRectX1, jumpUnitStartRectX2), mean(jumpUnitStartRectY1, jumpUnitStartRectY2), 1, 1, 0, global.colorThemeText, 1);
	}
	
	draw_set_color(global.colorThemeBG);
	scr_drawRectWidth(jumpUnitStartRectX1, jumpUnitStartRectY1, jumpUnitStartRectX2, jumpUnitStartRectY2, 2 , false);
	
	
	
	// load audio button
	var loadAudioButtonX1 = x + (windowWidth * 0.02);
	var loadAudioButtonY1 = y + (windowHeight * 0.6);
	var loadAudioButtonX2 = x + (windowWidth * 0.15);
	var loadAudioButtonY2 = y + (windowHeight * 0.9);
	var mouseoverLoadAudio = point_in_rectangle(mouse_x, mouse_y, loadAudioButtonX1, loadAudioButtonY1, loadAudioButtonX2, loadAudioButtonY2);
	
	draw_set_color(mouseoverLoadAudio ? merge_color(global.colorThemeSelected2, global.colorThemeBG, 0.3) : global.colorThemeSelected1);
	draw_rectangle(loadAudioButtonX1, loadAudioButtonY1, loadAudioButtonX2, loadAudioButtonY2, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(loadAudioButtonX1, loadAudioButtonY1, loadAudioButtonX2, loadAudioButtonY2, true);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(floor(mean(loadAudioButtonX1, loadAudioButtonX2)), floor(mean(loadAudioButtonY1, loadAudioButtonY2)), scr_get_translation("option_import-audio"));
	
	if (mouseoverLoadAudio) {
		if (mouse_check_button_released(mb_left)) {
			var fileFolder = (directory_exists(string(global.previousAudioDirectory)) && global.previousAudioDirectory != "") ? global.previousAudioDirectory : working_directory;
			
			var getAudioFile = get_open_filename_ext("ogg file|*.ogg", "", fileFolder, scr_get_translation("msg_file_audio"));
			if (getAudioFile != "" and file_exists(getAudioFile)) {
				audio_stop_all();
				audioFile = "";
				audioStream = -1;
				audioSound = -1;
				audioLength = 0;
				audioPos = 0;
				audioPaused = true;
				
				if (STEAMAPI) {
					if (!steam_get_achievement("SA_play-audio")) {
						steam_set_achievement("SA_play-audio");
					}
				}
				audioFile = getAudioFile;
				global.previousAudioDirectory = filename_path(audioFile);
				audioStream = audio_create_stream(audioFile);
				audioSound = audio_play_sound(audioStream, 100, false);
				visible = true;
			}
		}
	}
	var maxSpace  = x+windowWidth - (seekBarX2 + timeXBuffer*2 +string_width(timeRemaining));
	
	//draw volume control
	var fillInColor = c_white;
	var volumeBarWidth = min(display_get_width()* 0.07, maxSpace);
	var volumeBarX1 = x+windowWidth - (volumeBarWidth) - string_width("A");
	var volumeBarY1 = y + (windowHeight * 0.75) - (seekBarHeight / 2);
	var volumeBarX2 = volumeBarX1 + volumeBarWidth;
	var volumeBarY2 = volumeBarY1 + seekBarHeight;
	
	var mouseoverVolumebar = point_in_rectangle(mouse_x, mouse_y, volumeBarX1 - (volumeRad * 2), volumeBarY1 - (volumeRad * 2), volumeBarX2 + (volumeRad * 2), volumeBarY2 + (volumeRad * 2));
	draw_set_color(global.colorThemeSelected1);
	draw_roundrect(volumeBarX1, volumeBarY1, volumeBarX2, volumeBarY2, false);
	draw_set_color(fillInColor);
	draw_roundrect(volumeBarX1, volumeBarY1, volumeSliderX, volumeBarY2, false);

	// draw playhead circle
	if (!volumeHolding) volumeSliderX = (audioVolume * volumeBarWidth) + volumeBarX1;
	volumeSliderY = mean(volumeBarY1, volumeBarY2);

	if (volumeHolding or mouseoverVolumebar) {
		draw_set_color(fillInColor);
		draw_set_circle_precision(64);
		draw_circle(volumeSliderX, volumeSliderY, volumeRad, false);
		draw_set_alpha(1);
	}
	var audioScale = 0.25;
	if ((volumeBarWidth + sprite_get_width(spr_audioTool)*audioScale) <= maxSpace) {
		draw_sprite_ext(spr_audioTool,0,volumeBarX1 - sprite_get_width(spr_audioTool)*audioScale, floor(mean(volumeBarY1, volumeBarY2)), audioScale,audioScale,0,c_white,1)
	}
	
	if (mouseoverVolumebar) {
		if (mouse_check_button(mb_left)) {
			volumeHolding = true;
		}
	}
	if (!mouse_check_button(mb_left)) {
		volumeHolding = false;
	}
	
	if (volumeHolding) {
		volumeSliderX = clamp(mouse_x,volumeBarX1,volumeBarX2);
		audioVolume = (volumeSliderX - volumeBarX1) / volumeBarWidth;
	}
	if (audioSound != -1 && audioFileExists) {
		audio_sound_gain(audioSound, audioVolume, 0);
	}
	
	

}
