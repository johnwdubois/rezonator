// clean up resources - audio needs to be freed up before the buffer
event_user(EVENT_STOP);
audio_free_buffer_sound(audio);
buffer_delete(buffer);