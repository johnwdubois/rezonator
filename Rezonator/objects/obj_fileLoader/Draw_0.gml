if (global.openProject and ds_grid_height(obj_control.wordGrid) < 1)
{
	scr_loadREZ();
}

if (keyboard_check(vk_control) and keyboard_check_pressed(ord("S")) and ableToHotkey)
{
	if (ds_grid_height(obj_control.unitGrid) < global.totalUnitAmount)
	{
		show_message("Please let Rezonator finish importing files before saving.");
	}
	else
	{
		draw_set_alpha(1);
		draw_set_color(obj_control.progressBarFrontColor);
		draw_rectangle(obj_control.progressBarX, obj_control.progressBarY, obj_control.progressBarX + obj_control.progressBarWidth, obj_control.progressBarY + obj_control.progressBarHeight, false);
		draw_set_color(c_white);
		draw_set_font(obj_control.progressBarFont);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(obj_control.progressBarX + 12, mean(obj_control.progressBarY, obj_control.progressBarY + obj_control.progressBarHeight), "Saving project...");
		
		ableToHotkey = false;
		alarm[0] = 1;
	}
}
else if (keyboard_check(vk_control) and keyboard_check_pressed(ord("O")) and ableToHotkey)
{
	ableToHotkey = false;
	scr_loadREZ();
}
if (not keyboard_check(vk_control) and not ableToHotkey)
{
	ableToHotkey = true;
}