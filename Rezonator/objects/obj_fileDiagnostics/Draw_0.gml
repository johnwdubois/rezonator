var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);
var strHeight = string_height("0");

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_alpha(1);
draw_set_color(global.colorThemeSelected1);
draw_rectangle(0, 0, camWidth, camHeight, false);

// this is all for debugging, this text does not need to be localized
draw_set_color(global.colorThemeText);
draw_text(30, 60, "File Diagnostics - press ESC to exit");


var userName = (os_type == os_macosx) ? "USER" : "USERNAME";
var userStr = environment_get_variable(userName);

var docsDirExistsStr = directory_exists(global.documentsDirString) ? "exists" : "does not exist";
var rezDirExistsStr = directory_exists(global.rezonatorDirString) ? "exists" : "does not exist";
var workDirExistsStr = directory_exists(working_directory) ? "exists" : "does not exist";

draw_text(30, 60 + (strHeight * 2), "user: " + string(userStr));
draw_text(30, 60 + (strHeight * 3), "docsDir: " + string(global.documentsDirString) + ", " + docsDirExistsStr);
draw_text(30, 60 + (strHeight * 4), "rezDir: " + string(global.rezonatorDirString) + ", " + rezDirExistsStr);
draw_text(30, 60 + (strHeight * 5), "workDir: " + string(working_directory) + ", " + workDirExistsStr);