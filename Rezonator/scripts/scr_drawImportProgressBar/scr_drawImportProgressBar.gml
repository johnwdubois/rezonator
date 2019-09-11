if (ds_grid_height(obj_control.unitGrid) < global.totalUnitAmount) {
	var progressBarValue = (ds_grid_height(obj_control.unitGrid) / global.totalUnitAmount) * 100;

	draw_healthbar(progressBarX, progressBarY, progressBarX + progressBarWidth, progressBarY + progressBarHeight, progressBarValue, progressBarBackColor, progressBarFrontColor, progressBarFrontColor, 0, true, false);
	
	draw_set_font(progressBarFont);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(progressBarX + 12, mean(progressBarY, progressBarY + progressBarHeight) + 1, string(progressBarValue) + "%");
}