instance_destroy();
/*
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
	
	var loadingBarX1 = (camera_get_view_width(camera_get_active()) / 4);
	var loadingBarY1 = (camera_get_view_height(camera_get_active()) - camera_get_view_height(camera_get_active()) / 4);
	var loadingBarX2 = (camera_get_view_width(camera_get_active()) - camera_get_view_width(camera_get_active()) / 4);
	var loadingBarY2 = (camera_get_view_height(camera_get_active()) - camera_get_view_width(camera_get_active()) / 8);


	var widthOfLoadingBar = (( loadingBarX2 - loadingBarX1 ) * clamp(obj_openingScreen.CJKLoopIteration, 0,5))/5;
	
	var realLoadingBarX1 = loadingBarX1;
	var realLoadingBarY1 = loadingBarY1;
	var realLoadingBarX2 = realLoadingBarX1 + widthOfLoadingBar;
	var realLoadingBarY2 = loadingBarY2;

	
	draw_set_alpha(myAlpha);
	draw_set_color(global.colorThemeNegSpace);
	draw_rectangle(loadingBarX1,loadingBarY1,loadingBarX2,loadingBarY2,false);
	draw_set_color(make_color_rgb(183,183,255));
	draw_rectangle(realLoadingBarX1,realLoadingBarY1,realLoadingBarX2,realLoadingBarY2,false);

}

if (alphaDrop) {
	myAlpha -= 0.05;
	
	if (myAlpha <= 0) {
		instance_destroy();
	}
}