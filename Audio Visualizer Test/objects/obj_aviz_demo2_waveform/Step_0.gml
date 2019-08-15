// every step, queue up another bit of audio
if (is_playing and not is_paused) {
	event_user(EVENT_TICK);
	
	// because audio queues automatically stop playing if it runs out of buffer
	// sometimes if our ticks are behind the playback (e.g. if you dragged a window)
	// then the queue would stop.
	// For this reason we have to control play/stop state ourselves, and if in
	// play mode, when the audio stops playing, force it to start again

	if (not audio_is_playing(audio)) {
		audio_play_sound(audio, 0, 0);
	}
}
