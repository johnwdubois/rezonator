if (async_load[? "queue_id"] == audio) {
	// which buffer was just played?
	var buff = async_load[? "buffer_id"];
	
	// check which sample that was
	if (ds_map_exists(buffer_map, buff)) {
		last_sample = buffer_map[? buff]; // this is used by the audio seek control
	}
	
	// check which sample that was and get the FFT before removing it
	if (ds_map_exists(fft_map, buff)) {
		var fft_buff = fft_map[? buff];
		
		// calculate the bar graph heights - this is a bit hard to explain.
		// each bar consists of double the frequency bins as the previous one
		// so bar graph indexes are mapped to the sqrt of the fft position,
		// this mimics the logarithmic frequency response of the ear and is
		// close to how VU meters work "in the real world".
		// Each frequency of the FFT is also converted to dB approximately
		if (not is_undefined(fft_buff) and buffer_exists(fft_buff)) {
			buffer_seek(fft_buff, buffer_seek_start, 0);

			// zero totals
			var totals;
			for (var i=0; i<bars; i++) {
				bargraph[i] = 0;	
				totals[i] = 0;
			}
			
			// calculate size of each bar
			for (var i=0; i<fft_buckets; i++) {
				var dB = -20*log10(abs(buffer_read(fft_buff, buffer_f32)/3000000));
				var len = clamp(1-dB/100, 0, 1);
		
				var bar = clamp(bars * sqrt(i/fft_buckets), 0, bars-1);
				bargraph[bar] += len;
				totals[bar] += 1;
			}
			
			// adjust by totals
			for (var i=0; i<bars; i++) {
				var bias = totals[i];
				bargraph[i] /= bias;
			}
		}
		
		buffer_delete(fft_buff); // we're free to delete this one
	}
}