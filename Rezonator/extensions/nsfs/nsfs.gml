#define nsfs_init
/// @description  ()
//#global nsfs_is_available:
//#nsfs_status = nsfs_get_status():
nsfs_is_available = nsfs_init_raw();
global.g_nsfs_temp = game_save_id + string_format(date_current_datetime(), 0, 5);

#define buffer_load_ns
/// @description  (nspath, kind = buffer_grow):
/// @param nspath
/// @param  kind = buffer_grow
var nspath = argument[0];
var kind; if (argument_count > 1) kind = argument[1]; else kind = buffer_grow;
var n = buffer_load_ns_raw1(nspath), r;
if (n >= 0) {
	if (n == 0) { // bug: GMS does not allow to create zero-size buffers.
		r = buffer_create(1, kind, 1);
		buffer_resize(r, 0);
	} else r = buffer_create(n, kind, 1);
	buffer_load_ns_raw2(buffer_get_address(r), n);
	return r;
} else return -1;

#define buffer_save_ns
/// @description  (buffer):
/// @param buffer
var buffer = argument0;
return buffer_save_ns_raw(buffer_get_address(buffer), argument1, 0, buffer_get_size(buffer)) >= 0;

#define buffer_save_ext_ns
/// @description  (buffer, path, offset, size):
/// @param buffer
/// @param  path
/// @param  offset
/// @param  size
var b = argument0;
var m = buffer_get_size(b);
var i = argument2;
var n = clamp(i + argument3, 0, m);
i = clamp(i, 0, m);
n -= i;
if (n > 0) {
	return buffer_save_ns_raw(buffer_get_address(b), argument1, i, n) >= 0;
} else return -1;

#define ini_open_ns
/// @description  (path):
/// @param path
global.g_ini_path_ns = argument0;
var s = string_load_ns(argument0);
global.g_ini_hash_ns = sha1_string_utf8(s);
ini_open_from_string(s);

#define ini_close_ns
/// @description  ():
if (global.g_ini_path_ns != undefined) {
	var s = ini_close(), r;
	if (sha1_string_utf8(s) != global.g_ini_hash_ns) {
		r = string_save_ns(s, global.g_ini_path_ns);
	} else r = 0;
	global.g_ini_path_ns = undefined;
	return r;
} else show_error("Calling ini_close_ns but no INI file is open.", 0);

#define sprite_replace_ns
/// @description  (ind, nspath, imgnumb, removeback, smooth, xorig, yorig):
/// @param ind
/// @param  nspath
/// @param  imgnumb
/// @param  removeback
/// @param  smooth
/// @param  xorig
/// @param  yorig
var ind = argument0, nspath = argument1, imgnumb = argument2, removeback = argument3, smooth = argument4, xorig = argument5, yorig = argument6;
var tpath = global.g_nsfs_temp + filename_ext(nspath);
if (file_copy_ns(nspath, tpath)) {
    var r = sprite_replace(ind, tpath, imgnumb, removeback, smooth, xorig, yorig);
    file_delete(tpath);
    return true;
} else return false;

#define sprite_add_ns
/// @description  (nspath, imgnumb, removeback, smooth, xorig, yorig):
/// @param nspath
/// @param  imgnumb
/// @param  removeback
/// @param  smooth
/// @param  xorig
/// @param  yorig
var nspath = argument0, imgnumb = argument1, removeback = argument2, smooth = argument3, xorig = argument4, yorig = argument5;
var tpath = global.g_nsfs_temp + filename_ext(nspath);
if (file_copy_ns(nspath, tpath)) {
    var r = sprite_add(tpath, imgnumb, removeback, smooth, xorig, yorig);
    file_delete(tpath);
    return r;
} else return -1;

#define surface_save_ns
/// @description  (surface, nspath):
/// @param surface
/// @param  nspath
var surface = argument0, nspath = argument1;
var tpath = global.g_nsfs_temp + filename_ext(nspath);
surface_save(surface, tpath);
var r = file_copy_ns(tpath, nspath);
file_delete(tpath);
return r >= 0;

#define surface_save_part_ns
/// @description  surface_save_part_ns(surface, nspath, rx, ry, rw, rh):
/// @param surface
/// @param  nspath
/// @param  rx
/// @param  ry
/// @param  rw
/// @param  rh
var surface = argument0, nspath = argument1, rx = argument2, ry = argument3, rw = argument4, rh = argument5;
var tpath = global.g_nsfs_temp + filename_ext(nspath);
surface_save_part(surface, tpath, rx, ry, rw, rh);
var r = file_copy_ns(tpath, nspath);
file_delete(tpath);
return r >= 0;

#define screen_save_ns
/// @description  (nspath):
/// @param nspath
var nspath = argument0;
var tpath = global.g_nsfs_temp + filename_ext(nspath);
screen_save(tpath);
var r = file_copy_ns(tpath, nspath);
file_delete(tpath);
return r >= 0;

#define screen_save_part_ns
/// @description  screen_save_part_ns(nspath, rx, ry, rw, rh):
/// @param nspath
/// @param  rx
/// @param  ry
/// @param  rw
/// @param  rh
var nspath = argument0, rx = argument1, ry = argument2, rw = argument3, rh = argument4;
var tpath = global.g_nsfs_temp + filename_ext(nspath);
screen_save_part(tpath, rx, ry, rw, rh);
var r = file_copy_ns(tpath, nspath);
file_delete(tpath);
return r >= 0;

