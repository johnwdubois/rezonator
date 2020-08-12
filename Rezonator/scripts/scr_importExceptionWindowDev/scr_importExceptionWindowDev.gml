var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var rowHeight = string_height("A") * 1.3;



// exception Info window
var exceptionInfoWindowRectX1 = 40;
var exceptionInfoWindowRectY1 = 100;
var exceptionInfoWindowRectX2 = camWidth - 40;
var exceptionInfoWindowRectY2 = camHeight - 150;




windowWidth = clamp(exceptionInfoWindowRectX2 - exceptionInfoWindowRectX1, 48, 2000);
windowHeight = clamp(exceptionInfoWindowRectY2 - exceptionInfoWindowRectY1, 48, 1500);
clipWidth = windowWidth;
clipHeight = windowHeight;
	
windowX = x;
windowY = y;
clipX = x;
clipY = y;

if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(clipWidth, clipHeight);
}

scr_windowCameraAdjust();

surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);


x = exceptionInfoWindowRectX1;
y = exceptionInfoWindowRectY1;



// Draw exception Info window contents
draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var mouseoverRow = -1;

var plusY = exceptionInfoWindowRectY1 + rowHeight;
	
for (var i = 0; i < ds_grid_height(global.importTXTLineGrid); i++) {
		
	var cellRectX1 = exceptionInfoWindowRectX1;
	var cellRectY1 = plusY + scrollPlusY;
	var cellRectX2 = exceptionInfoWindowRectX2 - global.scrollBarWidth;
	var cellRectY2 = plusY + rowHeight;
	
	var textY = floor(plusY + (rowHeight / 2) + scrollPlusY);
	
	var currentLine = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i);
	var currentException = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colException, i);
	
		
	// draw BG stripes
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		
		
	// click on line to make exception
	if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, textY - (rowHeight / 2), cellRectX2, textY + (rowHeight / 2))) {
		mouseoverRow = i;
		
		draw_set_alpha(0.5);
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(cellRectX1 - clipX, textY - (rowHeight / 2) - clipY, cellRectX2 - clipX, textY + (rowHeight / 2) - clipY, false);
		
		if (mouse_check_button_pressed(mb_left)) {
			currentException = !currentException;
			ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, currentException);
		}
	}
	
	draw_set_alpha(currentException ? 0.5 : 1);
	draw_set_color(global.colorThemeText);
	draw_set_font(fnt_main);
	draw_text(cellRectX1 + 5 - clipX, floor(plusY + (rowHeight / 2) + scrollPlusY) - clipY, string(currentLine));
	
	
	// draw exception strikeout line
	if (currentException) {
		draw_set_color(c_red);
		draw_set_alpha(1);
		draw_line_width(cellRectX1 - clipX, textY - clipY, cellRectX1 + string_width(currentLine) - clipX, textY - clipY, 2);
	}
		
	plusY += rowHeight;
}
draw_set_alpha(1);




// draw header for column
draw_set_color(global.colorThemeBG);
draw_rectangle(exceptionInfoWindowRectX1 - clipX, exceptionInfoWindowRectY1 - clipY, exceptionInfoWindowRectX2 - clipX, exceptionInfoWindowRectY1 + rowHeight - clipY, false);

draw_set_color(global.colorThemeBorders);
draw_rectangle(exceptionInfoWindowRectX1 - clipX, exceptionInfoWindowRectY1 - clipY, exceptionInfoWindowRectX2 - clipX, exceptionInfoWindowRectY1 + rowHeight - clipY, true);










// mousewheel input
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	if (mouse_wheel_up()) {
		scrollPlusYDest += 8;
	}
	if (mouse_wheel_down()) {
		scrollPlusYDest -= 8;
	}
}

scr_scrollBar(ds_grid_height(global.importTXTLineGrid), -1, rowHeight, rowHeight,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, (exceptionInfoWindowRectX2 - exceptionInfoWindowRectX1), (exceptionInfoWindowRectY2 - exceptionInfoWindowRectY1));
	
scrollPlusY = min(scrollPlusY, 0);



scr_surfaceEnd();


draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(exceptionInfoWindowRectX1, floor(exceptionInfoWindowRectY1 - string_height("0")), "Mark Exceptions");


// draw exception Info window border
draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(exceptionInfoWindowRectX1, exceptionInfoWindowRectY1, exceptionInfoWindowRectX2, exceptionInfoWindowRectY2, true);
if (obj_importMapping.rezInfoGridSelectedRow >= 0) {
	for (var i = 0; i < 5; i++) {
		draw_rectangle(exceptionInfoWindowRectX1 - i, exceptionInfoWindowRectY1 - i, exceptionInfoWindowRectX2 + i, exceptionInfoWindowRectY2 + i, true);
	}
}







// Continue button
var continueButtonWidth = 150;
var continueButtonHeight = 40;
var continueButtonRectX1 = (camWidth / 2) - (continueButtonWidth / 2);
var continueButtonRectY1 = (camHeight - continueButtonHeight - 20) - (continueButtonHeight / 2);
var continueButtonRectX2 = continueButtonRectX1 + continueButtonWidth;
var continueButtonRectY2 = continueButtonRectY1 + continueButtonHeight;


if (point_in_rectangle(mouse_x, mouse_y, continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2)) {
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, false);
	
	if (mouse_check_button_released(mb_left)) {
		
		scr_importTXTExceptions();
		scr_importInfoGrid();
		
		instance_create(0, 0, obj_importMappingRezInfo);
		instance_create(0, 0, obj_importMappingTagInfo);
		
		with (obj_importException) {
			instance_destroy();
		}
	}
}
draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, true);

draw_set_font(fnt_main);
draw_set_halign(fa_center);
draw_set_color(global.colorThemeText);
draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), "Continue");