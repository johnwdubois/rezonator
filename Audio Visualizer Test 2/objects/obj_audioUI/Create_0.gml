var filename = get_open_filename_ext("audio file|*.ogg", "", working_directory, "Open a discourse audio OGG file");
audio = aviz_create(filename);

var sampleRate = aviz_get_samplerate(audio);
var samples = aviz_get_samples(audio);
var channels = aviz_get_channels(audio);

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

buffer = buffer_create(samples * channels * 2, buffer_fixed, 1);

aviz_tick(audio, buffer_get_address(buffer), 0, samples);

aviz_tick()