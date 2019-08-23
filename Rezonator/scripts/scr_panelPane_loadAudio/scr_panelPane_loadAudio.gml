if (not file_exists(functionAudio_filename)) {
	exit;
}

functionAudio_ogg = aviz_create(functionAudio_filename);

var sampleRate = aviz_get_samplerate(functionAudio_ogg);
functionAudio_samples = aviz_get_samples(functionAudio_ogg);
var channels = aviz_get_channels(functionAudio_ogg);

var channelSpec;
switch (channels) {
	case 1:
		channelSpec = audio_mono;
		break;
	case 2:
		channelSpec = audio_stereo;
		break;
	case 6:
		channelSpec = audio_3d;
		break;
	default:
		show_error("OGG with " + string(channels) + " not supported", false);
		instance_destroy();
}

functionAudio_audio = audio_create_play_queue(buffer_s16, sampleRate, channelSpec);

functionAudio_tickSize = sampleRate / room_speed;
functionAudio_buffSize = functionAudio_tickSize * channels * 2;

functionAudio_bufferMap = ds_map_create();
repeat(3) {
	event_user(EVENT_TICK);
}

audio_sound_gain(functionAudio_audio, 0.5, 0);



functionAudio_isPlaying = false;
functionAudio_isPaused = false;

functionAudio_lastSample = 0;
functionAudio_seekTo = 0;

functionAudio_seekHolding = false;
functionAudio_showSeek = true;