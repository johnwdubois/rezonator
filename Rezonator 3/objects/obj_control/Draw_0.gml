if (gridView)
{
	exit;
}

draw_set_color(c_ltgray);
draw_line(0, room_height / 2, room_width, room_height / 2);




draw_set_font(fnt_debug);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_alpha(1);

draw_text(room_width - 100, 100, "fps: " + string(fps));
draw_text(room_width - 100, 130, "gridSpaceVertical: " + string(gridSpaceVertical));
draw_text(room_width - 100, 150, "currentCenterDisplayRow: " + string(currentCenterDisplayRow));
draw_text(room_width - 100, 170, "lineGrid height: " + string(ds_grid_height(lineGrid)));
draw_text(room_width - 100, 190, "unitGrid height: " + string(ds_grid_height(unitGrid)));
draw_text(room_width - 100, 210, "wordGrid height: " + string(ds_grid_height(wordGrid)));
draw_text(room_width - 100, 230, "dynamicWordGrid height: " + string(ds_grid_height(dynamicWordGrid)));

draw_text(room_width - 100, 270, "displayRowAscending: " + string(displayRowAscending));
draw_text(room_width - 100, 290, "currentChainID: " + string(obj_chain.currentChainID));

scr_drawLine();