function scr_audioDraw() {
	if (live_call()) return live_result;
	
	// Draw Rezonator's audio player
	windowHeight = (camera_get_view_height(camera_get_active())) * 0.08;
	windowWidth = camera_get_view_width(camera_get_active()) - global.scrollBarWidth;
	x = 0;
	y = (camera_get_view_height(camera_get_active())) - windowHeight;
	
	var progressColor = c_orange;
	var playPauseSprite = spr_playPause;

	// draw background
	draw_set_alpha(1);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
	if(point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		mouseOverAudioUI = true;
	}

	// draw track title
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(global.fontChainList);
	draw_text(x + 24, y + 24, "Audio Track");
	var strHeightAudioTrack = string_height("A");
	draw_set_font(global.fontChainContents);
	draw_text(x + 24, y + 24 + strHeightAudioTrack, string(audioFile));



	// draw seekbar BG
	draw_set_color(global.colorThemeBG);
	draw_rectangle(seekBarX1 - string_width("AAAAAAA"), y + 10, seekBarX2 + string_width("AAAAAAA"), y + windowHeight, false);

	// draw seekbar
	seekBarWidth = camera_get_view_width(camera_get_active()) / 2;
	seekBarX1 = mean(x, x + windowWidth) - (seekBarWidth / 2);
	seekBarY1 = y + (windowHeight * 0.75) - (seekBarHeight / 2);
	seekBarX2 = seekBarX1 + seekBarWidth;
	seekBarY2 = seekBarY1 + seekBarHeight;

	draw_set_color(global.colorThemeText);
	draw_rectangle(seekBarX1, seekBarY1, seekBarX2, seekBarY2, false);
	draw_set_color(progressColor);
	draw_rectangle(seekBarX1, seekBarY1, playheadX, seekBarY2, false);


	// draw playhead circle
	playheadX = ((audioPos * seekBarWidth) / audioLength) + seekBarX1;
	playheadY = mean(seekBarY1, seekBarY2);

	var playheadHoldable = false;

	if (point_in_rectangle(mouse_x, mouse_y, seekBarX1 - (playheadRad * 2), seekBarY1 - (playheadRad * 2), seekBarX2 + (playheadRad * 2), seekBarY2 + (playheadRad * 2))
	or playheadHolding) {
		playheadHoldable = true;
	}
	if (playheadHoldable) {
		playheadRadDest = playheadRadBig;
		if (mouse_check_button_pressed(mb_left)) {
			playheadHolding = true;
		}
	}
	else {
		playheadRadDest = playheadRadSmall;
	}
	playheadRad = lerp(playheadRad, playheadRadDest, 0.5);


	if (!mouse_check_button(mb_left)) {
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
	draw_set_color(progressColor);
	draw_set_circle_precision(64);
	if (abs(audioPos - audioPosTemp) > 5 and not playheadHolding) {
		show_message("here")
		draw_set_alpha(0);
	}
	draw_circle(playheadX, playheadY, playheadRad, false);
	draw_set_alpha(1);




	// draw play/pause
	var playPauseRad = sprite_get_width(playPauseSprite) / 2;
	var playPauseX = mean(seekBarX1, seekBarX2);
	var playPauseY = clamp(seekBarY1 - 38, y + playPauseRad + 2, y + windowHeight);
	draw_sprite(playPauseSprite, !audioPaused, playPauseX, playPauseY);
	if (point_in_circle(mouse_x, mouse_y, playPauseX, playPauseY, playPauseRad)) {
		if (mouse_check_button_pressed(mb_left)) {
			audioPaused = !audioPaused;
		}
		playPauseRad += 3;
	}
	if (keyboard_check_pressed(vk_space) and not instance_exists(obj_dialogueBox) and not instance_exists(obj_stackShow)) {
		//var stackSelected = 
		if(selectedStack > -1) {
			if(audioPaused) {
				scr_audioJumpToUnit(stackStartUnit);
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
	draw_set_color(global.colorThemeBorders);
	draw_set_circle_precision(64);
	for (var i = 0; i < 1.5; i += 0.25) {
		draw_circle(playPauseX, playPauseY, playPauseRad - i, true);
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
	draw_set_color(global.colorThemeText);
	draw_set_font(global.fontChainContents);
	draw_set_valign(fa_middle);
	var timeXBuffer = 20;
	draw_set_halign(fa_left);
	draw_text(seekBarX2 + timeXBuffer, mean(seekBarY1, seekBarY2), string_hash_to_newline(strTotalMinutes + ":" + strTotalSeconds));
	draw_set_halign(fa_right);
	draw_text(seekBarX1 - timeXBuffer, mean(seekBarY1, seekBarY2), string_hash_to_newline(strCurrentMinutes + ":" + strCurrentSeconds));





	// draw jumpToUnit toggle
	draw_set_font(global.fontChainContents);
	draw_set_halign(fa_right);
	var jumpUnitStartTextX = x + windowWidth - string_width("AA");
	var jumpUnitStartTextY = floor(playPauseY) - floor((string_height("0") / 2));
	draw_text(jumpUnitStartTextX, jumpUnitStartTextY, "Click word to jump audio");

	var jumpUnitStartRectX1 = jumpUnitStartTextX - string_width("Click word to jump audio  ");
	var jumpUnitStartRectY1 = jumpUnitStartTextY - 10;
	var jumpUnitStartRectX2 = jumpUnitStartRectX1 - 20;
	var jumpUnitStartRectY2 = jumpUnitStartTextY + 10;

	if (point_in_rectangle(mouse_x, mouse_y, jumpUnitStartRectX2, jumpUnitStartRectY1, jumpUnitStartRectX1, jumpUnitStartRectY2)
	and mouse_check_button_released(mb_left)) {
		audioJumpOnWordClick = !audioJumpOnWordClick;
	}

	if (audioJumpOnWordClick) {
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(jumpUnitStartRectX1, jumpUnitStartRectY1, jumpUnitStartRectX2, jumpUnitStartRectY2, false);
	}
	else {
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(jumpUnitStartRectX1, jumpUnitStartRectY1, jumpUnitStartRectX2, jumpUnitStartRectY2, true);
	}





	

/*
	draw_set_halign(fa_left);
	draw_text((camera_get_view_width(camera_get_active()) / 2) + 10, (camera_get_view_height(camera_get_active()) / 2) + 10, "x: " + string(x));
	draw_text((camera_get_view_width(camera_get_active()) / 2) +10, (camera_get_view_height(camera_get_active()) / 2) + 30, "y: " + string(y));
	draw_text((camera_get_view_width(camera_get_active()) / 2) +10, (camera_get_view_height(camera_get_active()) / 2) + 50, "x + windowWidth: " + string(x + windowWidth));
	draw_text((camera_get_view_width(camera_get_active()) / 2) +10, (camera_get_view_height(camera_get_active()) / 2) + 70, "y + windowHeight: " + string(y + windowHeight));
	draw_text(10, 90, "playheadX: " + string(playheadX));
	draw_text(10, 110, "playheadHolding: " + string(playheadHolding));
	
*/

}
