x = camera_get_view_width(camera_get_active()) / 2;
y = camera_get_view_height(camera_get_active()) / 2;

camWidth = camera_get_view_width(camera_get_active());
camHeight = camera_get_view_height(camera_get_active());
draw_sprite_ext(spr_pixel, 0, 0, 0, camWidth, camHeight, 0, c_white, (loadSprite == spr_saving) ? 0 : myAlpha);

var text = "";
if (loadSprite == spr_saving) text = scr_get_translation("save_saving");
else if (loadSprite == spr_loading) text = "Loading..."
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(myAlpha);
draw_set_color(global.colorThemeRezPurple);
scr_adaptFont(text, "L", true);
draw_text(camWidth / 2, camHeight * 0.3, text);


if(room == rm_openingScreen){
	
	var loadingBarBackX1 = (camera_get_view_width(camera_get_active()) / 4);
	var loadingBarBackY1 = (camera_get_view_height(camera_get_active()) - camera_get_view_height(camera_get_active()) / 4);
	var loadingBarBackX2 = (camera_get_view_width(camera_get_active()) - camera_get_view_width(camera_get_active()) / 4);
	var loadingBarBackY2 = (camera_get_view_height(camera_get_active()) - camera_get_view_width(camera_get_active()) / 8);

	loadRatio = lerp(loadRatio, loadRatioDest, 0.25);
	loadRatioDest = obj_openingScreen.CJKLoopIteration / 6;

	var loadingBarFillWidth = (loadingBarBackX2 - loadingBarBackX1) * loadRatio;
	
	var loadingBarFillX1 = loadingBarBackX1;
	var loadingBarFillY1 = loadingBarBackY1;
	var loadingBarFillX2 = loadingBarFillX1 + loadingBarFillWidth;
	var loadingBarFillY2 = loadingBarBackY2;

	
	draw_set_alpha(myAlpha);
	draw_set_color(global.colorThemeNegSpace);
	draw_rectangle(loadingBarBackX1, loadingBarBackY1, loadingBarBackX2, loadingBarBackY2, false);
	draw_set_color(make_color_rgb(183,183,255));
	draw_rectangle(loadingBarFillX1, loadingBarFillY1, loadingBarFillX2, loadingBarFillY2, false);
}

if (alphaDrop) {
	myAlpha -= 0.05;
	
	if (myAlpha <= 0) {
		instance_destroy();
	}
}