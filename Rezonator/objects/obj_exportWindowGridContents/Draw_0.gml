

// this window should only exist if hideAll is true and exportWindowGridList exists
if (!obj_control.hideAll or !instance_exists(obj_exportWindowGridList)) {
	instance_destroy();
}

// set width & height for this window
windowWidth = (obj_exportWindowGridList.exportWindowWidth) - (obj_exportWindowGridList.windowWidth);
windowHeight = obj_exportWindowGridList.windowHeight;

// set position for this window
x = obj_exportWindowGridList.x + obj_exportWindowGridList.windowWidth;
y = obj_exportWindowGridList.y;



// draw base for this window
draw_set_color(global.colorThemeBG);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);


// name of currently selected grid
var grid = obj_exportWindowGridList.selectedGrid;
var gridName = scr_getGridNameString(grid);

draw_set_color(global.colorThemeText);
scr_adaptFont(gridName, "L")
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(x + string_width("0"), y + string_height("0"), gridName);

scr_drawExportGridViewer(grid);