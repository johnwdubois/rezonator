// drag to resize audio window
if (point_in_rectangle(mouse_x, mouse_y, x, y - 5, x + windowWidth, y + 5)) {
	window_set_cursor(cr_size_ns);
	
	if (mouse_check_button_pressed(mb_left)) {
		windowResizeYHolding = true;
	}
}
if (!mouse_check_button(mb_left)) {
	windowResizeYHolding = false;
}
if (windowResizeYHolding) {
	y = clamp(mouse_y, obj_control.wordTopMargin + 200, camera_get_view_height(view_camera[0]) - 75);
	windowHeight = camera_get_view_height(view_camera[0]) - y;
}
else {
	y = clamp(y, obj_control.wordTopMargin + 200, camera_get_view_height(view_camera[0]) - 75);
	windowHeight = camera_get_view_height(view_camera[0]) - y;
}


// audio pausing
if (audioPaused and audio_is_playing(audioSound)) {
	audio_pause_sound(audioSound);
}
if (!audioPaused and audio_is_paused(audioSound)) {
	audio_resume_sound(audioSound);
}

audioLength = audio_sound_length(audioSound);
audioPos = audio_sound_get_track_position(audioSound);

if (audioPos >= audioLength - 1) {
	audio_sound_set_track_position(audioSound, 0);
	audioPaused = true;
}