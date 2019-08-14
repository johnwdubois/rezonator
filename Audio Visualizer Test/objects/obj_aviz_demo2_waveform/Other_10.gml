/// @description Fill audio queue

var buff = buffer_create(buff_size, buffer_fixed, 1);
var rendered_sample = aviz_tick(ogg, buffer_get_address(buff), 0, tick_size);
if (rendered_sample < 0) { // return would be 0 if track is done
	buffer_delete(buff);
	exit;
}
audio_queue_sound(audio, buff, 0, buff_size);

// add to the buffer map
// we store as part of the map the buffer's id as key and the sample number
// returned by the aviz_tick function; this number is the start sample
// of the buffer, and will be used later to update last_sample in the async event
ds_map_add(buffer_map, buff, rendered_sample);