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

if (showDevVars)
{
	draw_text(room_width - 100, 100, "fps: " + string(fps));
	draw_text(room_width - 100, 130, "gridSpaceVertical: " + string(gridSpaceVertical));
	draw_text(room_width - 100, 150, "currentCenterDisplayRow: " + string(currentCenterDisplayRow));
	draw_text(room_width - 100, 170, "lineGrid height: " + string(ds_grid_height(lineGrid)));
	draw_text(room_width - 100, 190, "unitGrid height: " + string(ds_grid_height(unitGrid)));
	draw_text(room_width - 100, 210, "total unit amount: " + string(global.totalUnitAmount));
	draw_text(room_width - 100, 230, "units loaded: " + string((ds_grid_height(unitGrid) / global.totalUnitAmount) * 100) + "%");
	draw_text(room_width - 100, 270, "wordGrid height: " + string(ds_grid_height(wordGrid)));
	draw_text(room_width - 100, 290, "dynamicWordGrid height: " + string(ds_grid_height(dynamicWordGrid)));

	draw_text(room_width - 100, 310, "displayRowAscending: " + string(displayRowAscending));
	draw_text(room_width - 100, 330, "currentChainID: " + string(obj_chain.currentChainID));
	
	draw_text(room_width - 100, 400, "newWordHoverWordID: " + string(newWordHoverWordID));
}


scr_drawLine();

if (ds_grid_height(unitGrid) < global.totalUnitAmount)
{
	var loadbarX1 = 24;
	var loadbarY1 = room_height - 80;
	var loadbarX2 = loadbarX1 + 200;
	var loadbarY2 = loadbarY1 + 32;
	var loadbarValue = (ds_grid_height(unitGrid) / global.totalUnitAmount) * 100;
	var backColor = make_color_rgb(220, 220, 220);
	
	draw_healthbar(loadbarX1, loadbarY1, loadbarX2, loadbarY2, loadbarValue, c_gray, c_blue, c_blue, 0, true, false);
	
	draw_set_font(fnt_mainBold);
	draw_set_color(c_white);
	draw_text(loadbarX1 + 12, mean(loadbarY1, loadbarY2) + 1, string(loadbarValue) + "%");
}