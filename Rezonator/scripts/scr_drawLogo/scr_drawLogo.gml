// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawLogo(logoX, logoY, drawVersion){
	
	
	draw_set_alpha(1);
	var logoScale = clamp(camera_get_view_height(camera_get_active()) / 2160, 0.25, 1);
	draw_sprite_ext(spr_logo, global.fontSize, logoX, logoY, 1, 1, 0, c_white, 1);
	
	if (drawVersion) {

		draw_set_halign(fa_right);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(string(global.versionString), "S");
		draw_text(logoX + (sprite_get_width(spr_logo) * logoScale * 0.5), logoY + (sprite_get_height(spr_logo) * logoScale * 0.5), global.versionString);
	}
}