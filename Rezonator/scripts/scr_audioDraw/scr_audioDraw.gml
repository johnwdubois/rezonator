/*
	Purpose: Draw the Audio GUI when an Audio File has been uploaded, including plauhead, bookmarks, and toggles
*/
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
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("msg_audio"), "M");
	var strHeight = string_height("0");
	draw_text(x + 24, y + 24, scr_get_translation("msg_audio"));
	var strHeightAudioTrack = string_height("0");
	scr_adaptFont(string(audioFile), "S");
	draw_text(x + 24, y + 24 + strHeightAudioTrack, string(audioFile));
	
	if (point_in_rectangle(mouse_x, mouse_y, x, y, seekBarX1 - string_width("AAAAAAA"), y + windowHeight)) {
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
		scr_createTooltip(mean(pauseLineLeftX, pauseLineRightX), pauseLineY1 - (strHeight * 0.25), (audioPaused) ? "Play" : "Pause", obj_tooltip.arrowFaceDown);
	}

	
	// Check for mouseClick on play/pause button
	if (mouseOverPlayPause) {
		if (mouse_check_button_pressed(mb_left)) {
			if (selectedStackChain > -1) {
				if (audioPaused) {
					if(audioPos >= bookmarkEndTime) {
						scr_audioJumpToUnit(stackStartUnit);
						audioPaused = !audioPaused;
					}
				}
			}
			audioPaused = !audioPaused;
		}
	}
	
	// Check for Spacebar to toggle play/pause and set Bookmark
	if (keyboard_check_pressed(vk_space) and !instance_exists(obj_dialogueBox) and !instance_exists(obj_stackShow) && audioSound != -1) {
		//var stackSelected = 
		if (selectedStackChain > -1) {
			if (audioPaused) {
				audioPaused = !audioPaused;
			}
			else {
				//show_message(stackStartUnit);
				audio_sound_set_track_position(audioSound, bookmarkStartTime);
				stackUnitListPosition = 0;	
				audioPaused = !audioPaused;
			}
		}
		else if (bookmarkStartTime > -1) {
			if (audioPaused) {
				audio_sound_set_track_position(audioSound, bookmarkStartTime);
				audioPaused = !audioPaused;
			}
			else{
				audioPaused = !audioPaused;
			}
		}
		else {
			audioPaused = !audioPaused;
		}
	}
	
	// Check for Enter to set bookmark
	if (keyboard_check_pressed(vk_enter) and !instance_exists(obj_dialogueBox) and !instance_exists(obj_stackShow) && audioSound != -1) {
		if(selectedStackChain == -1) {
			if(audioPaused) {
				var currentFocusUnit = scr_currentTopLine();
				var currentFocusUnitStartTime = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentFocusUnit - 1);
				bookmarkStartTime = currentFocusUnitStartTime;
				audio_sound_set_track_position(audioSound, bookmarkStartTime);
				bookmarkEndTime = -1;
			}
			else{
				bookmarkStartTime = audioPos;
				audio_sound_set_track_position(audioSound, bookmarkStartTime);
				bookmarkEndTime = -1;
				audioPaused = !audioPaused;
			}
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


	// draw playhead circle
	playheadX = ((audioPos * seekBarWidth) / audioLength) + seekBarX1;
	playheadY = mean(seekBarY1, seekBarY2);
	draw_set_color(progressColor);
	draw_set_circle_precision(64);
	if (abs(audioPos - audioPosTemp) > 5 and not playheadHolding) {
		//show_message("here")
		draw_set_alpha(0);
	}
	draw_circle(playheadX, playheadY, playheadRad, false);
	draw_set_alpha(1);
	
	//Check for mousehover/click on Playhead
	var playheadHoldable = false;

	if ((mouseoverSeekbar or playheadHolding) && audioSound != -1 && file_exists(audioFile)) {
		playheadHoldable = true;
	}
	if (playheadHoldable and !mouseOverPlayPause) {
		playheadRadDest = playheadRadBig;
		if (mouse_check_button_pressed(mb_left)) {
			playheadHolding = true;
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
	
	// Draw audio Bookmark
	if(bookmarkStartTime > -1) {
		
		//Draw bookmarks
		bookmarkX = ((real(bookmarkStartTime) * real(seekBarWidth)) / audioLength) + seekBarX1;
		bookmarkY = seekBarY1 - (playheadRad * 2);
	
		draw_set_halign(fa_right);
		draw_sprite_ext(spr_linkArrow, 0, bookmarkX, bookmarkY, 0.5, 0.5, 30, c_green, 1);
		
		if(bookmarkEndTime > -1) {
		
			//Draw bookmarks
			endmarkX = ((real(bookmarkEndTime) * real(seekBarWidth)) / audioLength) + seekBarX1;
			endmarkY = seekBarY2 + (playheadRad * 2);
			
			draw_set_halign(fa_left);
			draw_sprite_ext(spr_linkArrow, 0, endmarkX, endmarkY, 0.5, 0.5, 210, c_red, 1);
		}
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
	draw_text(seekBarX2 + timeXBuffer, mean(seekBarY1, seekBarY2), string_hash_to_newline(strTotalMinutes + ":" + strTotalSeconds));
	draw_set_halign(fa_right);
	draw_text(seekBarX1 - timeXBuffer, mean(seekBarY1, seekBarY2), string_hash_to_newline(strCurrentMinutes + ":" + strCurrentSeconds));


	// draw jumpToUnit toggle
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	var jumpUnitStartTextX = x + windowWidth - string_width("A");
	var jumpUnitStartTextY = y + (windowHeight * 0.25);
	draw_text(jumpUnitStartTextX, jumpUnitStartTextY, scr_get_translation("msg_jump-audio"));

	var jumpUnitStartRectX1 = jumpUnitStartTextX - string_width("Click word to jump audio  ");
	var jumpUnitStartRectY1 = max(y, jumpUnitStartTextY - strHeight * 0.55);
	var jumpUnitStartRectX2 = jumpUnitStartRectX1 - strHeight;
	var jumpUnitStartRectY2 = jumpUnitStartTextY + strHeight * 0.55;

	if (point_in_rectangle(mouse_x, mouse_y, jumpUnitStartRectX2, jumpUnitStartRectY1, jumpUnitStartRectX1, jumpUnitStartRectY2)
	and mouse_check_button_released(mb_left)) {
		audioJumpOnWordClick = !audioJumpOnWordClick;
	}
	
	if (audioJumpOnWordClick) {
		draw_set_color(merge_color(global.colorThemeBG, bgColor, 0.5));
		draw_rectangle(jumpUnitStartRectX1, jumpUnitStartRectY1, jumpUnitStartRectX2, jumpUnitStartRectY2, false);
		draw_sprite_ext(spr_checkmark, 0, mean(jumpUnitStartRectX1, jumpUnitStartRectX2), mean(jumpUnitStartRectY1, jumpUnitStartRectY2), 1, 1, 0, c_white, 1);
	}
	
	draw_set_color(global.colorThemeBG);
	scr_drawRectWidth(jumpUnitStartRectX1, jumpUnitStartRectY1, jumpUnitStartRectX2, jumpUnitStartRectY2, 2);
	
	
	
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
	draw_text(floor(mean(loadAudioButtonX1, loadAudioButtonX2)), floor(mean(loadAudioButtonY1, loadAudioButtonY2)), "Load Audio");
	
	if (mouseoverLoadAudio) {
		if (mouse_check_button_released(mb_left)) {
			
			audio_stop_all();
			audioFile = "";
			audioStream = -1;
			audioSound = -1;
			audioLength = 0;
			audioPos = 0;
			audioPaused = true;
			
			
			var getAudioFile = get_open_filename_ext("ogg file|*.ogg", "", working_directory, scr_get_translation("msg_file_audio"));
			if (getAudioFile != "" and file_exists(getAudioFile)) {
				audioFile = getAudioFile;
				audioStream = audio_create_stream(audioFile);
				audioSound = audio_play_sound(audioStream, 100, false);
				visible = true;
			}
		}
	}

}
