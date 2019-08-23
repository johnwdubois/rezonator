// draw import UI
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
		if (file_exists(functionAudio_filename)) {
			scr_panelPane_loadAudio();
		}
		else {
			functionAudio_filename = "";
		}
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






// draw play/pause
var playPauseImageIndex = 0;
if (functionAudio_isPlaying) {
	playPauseImageIndex = 1;
}

var playPauseSpriteX = x + (windowWidth / 2);
var playPauseSpriteY = y + (windowHeight * 0.3);
var playPauseButtonRad = sprite_get_width(spr_playPause) * 0.5;

draw_sprite_ext(spr_playPause, playPauseImageIndex, playPauseSpriteX, playPauseSpriteY, 1, 1, 0, c_white, 1);

draw_set_color(c_black);
draw_set_alpha(1);

if (point_distance(mouse_x, mouse_y, playPauseSpriteX, playPauseSpriteY) < playPauseButtonRad) {	
	if (mouse_check_button_pressed(mb_left)) {
		if (functionAudio_isPaused) {
			event_user(EVENT_RESUME);
		}
		else if (functionAudio_isPlaying) {
			event_user(EVENT_PAUSE);
		}
		else {
			event_user(EVENT_PLAY);
		}
	}
	
	playPauseButtonRad = sprite_get_width(spr_playPause) * 0.6;
}
draw_set_circle_precision(64);
draw_circle(playPauseSpriteX, playPauseSpriteY, playPauseButtonRad, true);




// draw seek controls
var seekLineX1 = x + windowWidth * 0.25;
var seekLineY1 = y + (windowHeight * 0.75);
var seekLineX2 = x + windowWidth * 0.75;
var seekLineY2 = seekLineY1;
draw_set_color(global.colorThemeBG);
draw_rectangle(seekLineX1 - 10, seekLineY1 - 10, seekLineX2 + 10, seekLineY2 + 10, false);
draw_set_color(global.colorThemeBorders);
draw_line_width(seekLineX1, seekLineY1, seekLineX2, seekLineY2, 2);


draw_set_alpha(1);

var offset = seekLineX1;

var seekCircleX = (seekLineX2 - seekLineX1) * functionAudio_lastSample / functionAudio_samples;
var seekCircleRad = 10;

if (point_in_rectangle(mouse_x, mouse_y, seekLineX1 - 5, seekLineY1 - 5, seekLineX2 + 5, seekLineY2 + 5)) {
	seekCircleRad = 13;
	if (mouse_check_button(mb_left) and not functionAudio_seekHolding) {
		functionAudio_seekHolding = true;
	}
}

if (functionAudio_seekHolding) {
	seekCircleX = clamp(mouse_x, seekLineX1, seekLineX2) - seekLineX1;
	draw_set_color(c_red);
}

if (not mouse_check_button(mb_left)) {
	if (functionAudio_seekHolding) {
		functionAudio_seekHolding = false;
		functionAudio_seekTo = (functionAudio_samples * (mouse_x - offset)) / (seekLineX2 - seekLineX1);
		functionAudio_seekTo = clamp(functionAudio_seekTo, 0, functionAudio_samples);
		event_user(EVENT_SEEK);
		if (functionAudio_showSeek) {
			functionAudio_showSeek = false;
			alarm[6] = 5;
		}
	}
}

if (functionAudio_showSeek) {
	draw_circle(offset + seekCircleX, seekLineY1, seekCircleRad, false);
}