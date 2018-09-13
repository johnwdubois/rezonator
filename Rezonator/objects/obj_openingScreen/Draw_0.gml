draw_set_alpha(1);
draw_sprite(spr_logo, 0, room_width / 2, room_height / 4);
draw_set_font(fnt_debug);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
var versionString = string(game_display_name);
versionString = string_delete(versionString, 1, string_length("Rezonator"));
versionString = "Version" + versionString;
draw_text((room_width / 2) + (sprite_get_width(spr_logo) / 2), (room_height / 4) + (sprite_get_height(spr_logo) / 2), versionString);

if not (global.newProject or global.openProject)
{
	scr_newOrOpen();
}
else if (global.newProject and not global.openProject)
{
	scr_newProjectWindow();
}
else if (not global.newProject and global.openProject)
{
	room_goto(rm_mainScreen);
}