draw_set_color(c_white);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(c_black);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);



draw_text(x, y - 80, "scrollPlusY: " + string(scrollPlusY));
draw_text(x, y - 60, "scrollBarPlusY: " + string(scrollBarPlusY));
draw_text(x, y - 40, "scrollBarHeight: " + string(scrollBarHeight));




scr_resizeWindow();

scr_surfaceStart();

scr_scrollBar(valueList);

scr_surfaceEnd();