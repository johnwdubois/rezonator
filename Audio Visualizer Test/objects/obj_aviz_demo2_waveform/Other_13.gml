/// @description Stop audio
audio_stop_sound(audio);
is_playing = false;
is_paused = false;
last_sample = 0;
aviz_seek(ogg, 0); // seek back to zero