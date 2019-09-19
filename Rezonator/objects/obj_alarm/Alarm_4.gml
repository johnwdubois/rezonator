/// @description Insert description here
// You can write your code in this editor
backgroundAlpha--;
draw_set_alpha(backgroundAlpha/500000);
draw_sprite_ext(wheres_elmo_BG, 0, camera_get_view_width(view_camera[0])/2, camera_get_view_height(view_camera[0])/2, 1, 1, 0, c_white, backgroundAlpha);
if(backgroundAlpha > 1) {
	alarm[4] = 0;
}