function scr_drawImportProgressBar() {
	// Draw to the screen a loading progress bar for the user

	if (ds_grid_height(obj_control.unitGrid) < global.totalUnitAmount) {
		var progressBarValue = (ds_grid_height(obj_control.lineGrid) / global.totalUnitAmount) * 100;

		draw_healthbar(progressBarX, progressBarY, progressBarX + progressBarWidth, progressBarY + progressBarHeight, progressBarValue, progressBarBackColor, progressBarFrontColor, progressBarFrontColor, 0, true, false);
	
		draw_set_font(progressBarFont);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(progressBarX + 12, mean(progressBarY, progressBarY + progressBarHeight) + 1, string(progressBarValue) + "%");
	}
	else if (!checkedForParticipantNames) {
		checkedForParticipantNames = true;
	
		var anyNames = false;
		var unitGridHeight = ds_grid_height(obj_control.unitGrid);
		for (var i = 0; i < unitGridHeight; i++) {
			if (string_length(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, i)) > 0) {
				anyNames = true;
				break;
			}
		}
		if (!anyNames) {
			with (obj_alarm) {
				alarm[6] = 5;
			}
		}
	}


}
