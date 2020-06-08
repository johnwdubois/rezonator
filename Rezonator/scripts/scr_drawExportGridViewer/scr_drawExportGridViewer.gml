var grid = argument0;
var gridWidth = ds_grid_width(grid);
var gridHeight = ds_grid_height(grid);

scr_surfaceStart();

var scrollBarWidth = 20;
var textY = 0;
var textPlusY = 0;
draw_set_font(global.fontGridView);
var strWidth = string_width("A");
var strHeight = string_height("0");

var windowX1 = windowX + (strWidth * 2);
var windowY1 = windowY + (strHeight * 2);
var windowX2 = windowX + windowWidth - (strWidth * 2);
var windowY2 = windowY + windowHeight - (strHeight * 2);

draw_set_color(global.colorThemeBG);
draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX2 - clipX, windowY2 - clipY, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX2 - clipX, windowY2 - clipY, true);



var currentItemString = " ";


scr_surfaceEnd();