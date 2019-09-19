/// @description Insert description here
// You can write your code in this editor
if(drawBackground and backgroundAlpha > 1) {
	backgroundAlpha--;
	//draw_set_alpha(backgroundAlpha/100);
	draw_sprite_ext(wheres_elmo_BG, 0, camera_get_view_width(view_camera[0])/2, camera_get_view_height(view_camera[0])/2, 1, 1, 0, c_white, backgroundAlpha/100);
}
else if(drawBackground) {
	drawBackground = false;	
}