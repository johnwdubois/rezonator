// ********
// Basic audio player demo
// This demo loads an ogg file into audioviz, and then proceeds to render the ENTIRE
// track into a buffer which GM can play as an audio buffer.  Just playing audio like this
// is no different from GM's built-in audio_create_stream function, with the exception
// that the raw audio data is available for you to inspect inside buffer, should you want
// access to the raw data.
//
// CREDITS: Royalty free music by Patrick de Arteaga: https://patrickdearteaga.com/royalty-free-music/
// *********

// create audio. At this point, ogg will be loaded into audioviz extension's memory
ogg = aviz_create("Straw_Cowboys.ogg");

// get ogg metadata
var samplerate = aviz_get_samplerate(ogg);
var samples = aviz_get_samples(ogg);
var channels = aviz_get_channels(ogg);

// calculate channelspec, we need this later
var channelspec;
switch (channels) {
	case 1: channelspec = audio_mono; break;
	case 2: channelspec = audio_stereo; break;
	case 6: channelspec = audio_3d; break;
	default:
		show_error("OGG with " + string(channels) + " not supported", false);
		instance_destroy();
}

// create a buffer of the right size, the *2 is because of s16
buffer = buffer_create(samples*channels*2, buffer_fixed, 1);

// fill entire buffer with the data
aviz_tick(ogg, buffer_get_address(buffer), 0, samples);

// don't need the ogg any more, so unload it from memory
aviz_destroy(ogg);

// create a sound from the buffer, but first need to find the right channelspec


audio = audio_create_buffer_sound(buffer, buffer_s16, samplerate, 0, buffer_get_size(buffer), channelspec);
audio_sound_gain(audio, 0.5, 0); // let's turn the sound down a bit

// create the audio controls
is_playing = false;
is_paused = false;

with (instance_create_depth(room_width/2 - 64, room_height/2, depth, obj_aviz_play_control)) {
	control = other.id;
}
with (instance_create_depth(room_width/2 + 64, room_height/2, depth, obj_aviz_stop_control)) {
	control = other.id;
}