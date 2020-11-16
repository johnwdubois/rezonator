function scr_bufferWriteSlice(buf, data, start, next) {
	// Credit to YellowAfterLife
	// yal.cc

	next = next - start;
	if (next <= 0) exit;
	var size = buffer_get_size(buf);
	var pos = buffer_tell(buf);
	var need = pos + next;
	if (size < need) {
	    do size *= 2 until (size >= need);
	    buffer_resize(buf, size);
	}
	buffer_copy(data, start, next, buf, pos);
	buffer_seek(buf, buffer_seek_relative, next);


}
