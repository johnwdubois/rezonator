// ********
// Waveforme visualize demo
// This demo plays audio in the same way as demo 1 but instead of providing seek controls
// renders a visualization of the audio
//
// CREDITS: Royalty free music by Patrick de Arteaga: https://patrickdearteaga.com/royalty-free-music/
// *********

// create audio. At this point, ogg will be loaded into memory
ogg = aviz_create("Markalo_disco.ogg");

// get ogg metadata
var samplerate = aviz_get_samplerate(ogg);
samples = aviz_get_samples(ogg);
var channels = aviz_get_channels(ogg);

// calculate channelspec, we need this later
switch (channels) {
	case 1: channelspec = audio_mono; break;
	case 2: channelspec = audio_stereo; break;
	case 6: channelspec = audio_3d; break;
	default:
		show_error("OGG with " + string(channels) + " not supported", false);
		instance_destroy();
}

// create the GM audio queue
audio = audio_create_play_queue(buffer_s16, samplerate, channelspec);

// calculate size of a "chunk" of audio per step
tick_size = samplerate/room_speed;

// calculate size of buffer needed to hold this "chunk"
buff_size = tick_size * channels * 2;

// we keep track of all buffers added to the audio queue. this is used to
// 1. map played buffers to samples
// 2. allow us to clean up unplayed buffers to prevent memory leaks
buffer_map = ds_map_create();

repeat(3) { // pre-fill audio queue with a few chunks, to prevent audio jittering
	event_user(EVENT_TICK);
}

audio_sound_gain(audio, 0.5, 0);

// create the visualized version of the track;

aviz_set_debug_mode(AVIZ_DEBUGMODE_DEBUG)

waveform_data = buffer_create(600*4, buffer_fixed, 1);
aviz_render(ogg, buffer_get_address(waveform_data), 600);

// create the audio controls
is_playing = false;
is_paused = false;

with (instance_create_depth(room_width/2 - 64, room_height/2, depth-1, obj_aviz_play_control)) {
	control = other.id;
}
with (instance_create_depth(room_width/2 + 64, room_height/2, depth-1, obj_aviz_stop_control)) {
	control = other.id;
}

// create seek control
last_sample = 0;
seek_to = 0;

with (instance_create_depth(room_width/2, room_height/2+64, depth-1, obj_aviz_seek_control)) {
	control = other.id;
}