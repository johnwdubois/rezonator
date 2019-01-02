if (gridView)
{
	exit;
}

if (showDisplayCols)
{
	draw_set_alpha(0.25);
	draw_set_color(c_black);
	
	for (var i = 0; i < 20; i++)
	{
		var displayColX = wordLeftMargin + (i * gridSpaceHorizontal);
		draw_line(displayColX, 0, displayColX, room_height);
		draw_text(displayColX, 160, string(i));
	}
}

draw_set_color(c_ltgray);
draw_line(0, camera_get_view_height(view_camera[1]) / 2, camera_get_view_width(view_camera[1]), camera_get_view_height(view_camera[1]) / 2);




draw_set_font(fnt_debug);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_alpha(1);

if (showDevVars)
{
	draw_text(camera_get_view_width(view_camera[0]) - 100, 100, "fps: " + string(fps));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 130, "gridSpaceVertical: " + string(gridSpaceVertical));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 150, "currentCenterDisplayRow: " + string(currentCenterDisplayRow));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 170, "lineGrid height: " + string(ds_grid_height(lineGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 190, "unitGrid height: " + string(ds_grid_height(unitGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 210, "total unit amount: " + string(global.totalUnitAmount));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 230, "units loaded: " + string((ds_grid_height(unitGrid) / global.totalUnitAmount) * 100) + "%");
	draw_text(camera_get_view_width(view_camera[0]) - 100, 270, "wordGrid height: " + string(ds_grid_height(wordGrid)));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 290, "dynamicWordGrid height: " + string(ds_grid_height(dynamicWordGrid)));

	draw_text(camera_get_view_width(view_camera[0]) - 100, 310, "displayRowAscending: " + string(displayRowAscending));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 330, "currentChainID: " + string(obj_chain.currentChainID));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 400, "newWordHoverWordID: " + string(newWordHoverWordID));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 600, "mostRecentlyAddedWord: " + string(mostRecentlyAddedWord));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 650, "mostRecentlyAddedWordMoved: " + string(mostRecentlyAddedWordMoved));
	
	draw_text(camera_get_view_width(view_camera[0]) - 100, 750, "chainColorID[1]: " + string(obj_chain.chainColorID[1]));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 770, "chainColorID[2]: " + string(obj_chain.chainColorID[2]));
	draw_text(camera_get_view_width(view_camera[0]) - 100, 790, "chainColorID[3]: " + string(obj_chain.chainColorID[3]));
}


scr_drawLine();
