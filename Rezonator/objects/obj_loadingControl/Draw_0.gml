scr_windowCameraAdjust();

var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

draw_set_color(global.colorThemeText);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(camWidth * 0.5, camHeight * 0.1, "Importing : " + string(filename_name(global.importFilename)));




draw_set_halign(fa_left);

for (var i = 0; i < 6; i++) {
	var textRow = importGridRow - i;
	if (textRow >= 0 && textRow < importGridHeight) {
		var currentLineText = (global.importType == "import_type_word") ? global.importCSVGrid[# indexOfDisplayToken, importGridRow - i] : global.importTXTLineGrid[# 0, importGridRow - i];
		draw_text(camWidth * 0.35, camHeight * 0.2 + (i *string_height(currentLineText)* 1.5), currentLineText);
		draw_text(camWidth * 0.3, camHeight * 0.2 + (i *string_height(currentLineText)* 1.5), string(textRow));
	}
}


// draw progress bar
var barBackBorder = 2;
var barBackWidth = camWidth * 0.5;
var barBackHeight = camHeight * 0.1;
var barFillWidth = barBackWidth * (importGridRow / importGridHeight);
var barBackX1 = (camWidth / 2) - (barBackWidth / 2);
var barBackY1 = camHeight * 0.7;
var barBackX2 = barBackX1 + barBackWidth;
var barBackY2 = barBackY1 + barBackHeight;
var barFillX2 = barBackX1 + barFillWidth;

// draw back bar
draw_set_color(global.colorThemeSelected2);
draw_rectangle(barBackX1 - barBackBorder, barBackY1 - barBackBorder, barBackX2 + barBackBorder, barBackY2 + barBackBorder, false);
draw_set_color(c_ltblue);
draw_rectangle(barBackX1, barBackY1, barFillX2, barBackY2, false);

// draw unit count
draw_set_color(global.colorThemeText);
draw_text(camWidth / 2, camHeight * 0.6, string(importGridRow) + " / " + string(importGridHeight));
//draw_text(camWidth / 2, camHeight * 0.5, "nodeMap size: " + string(ds_map_size(global.nodeMap)) + "\nFPS: " + string(fps) + "\n Nodes per sec: " + string(nodesPerSec));