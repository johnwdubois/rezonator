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