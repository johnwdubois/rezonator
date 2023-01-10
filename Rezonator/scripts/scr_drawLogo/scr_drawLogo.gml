function scr_drawLogo(logoX, logoY, drawVersion){
	
	draw_set_alpha(1);
	var logoScale = clamp(camera_get_view_height(camera_get_active()) / 2160, 0.25, 1);
	draw_sprite_ext(spr_logo, global.fontSize, logoX, logoY, 1, 1, 0, c_white, 1);
	
	if (drawVersion) {

		draw_set_halign(fa_right);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(string(global.versionString), "S");
		var versionTextX = 0;
		var versionTextY = 0;
		if (global.fontSize == 0) {
			versionTextX = logoX + sprite_get_width(spr_logo)* .185;
			versionTextY = logoY + sprite_get_height(spr_logo)* .3;
		}
		else if (global.fontSize == 1) {
			versionTextX = logoX + sprite_get_width(spr_logo)* .222;
			versionTextY = logoY + sprite_get_height(spr_logo)* .36;
		}
		else if (global.fontSize == 2) {
			versionTextX = logoX + sprite_get_width(spr_logo)* .26;
			versionTextY = logoY + sprite_get_height(spr_logo)* .41;
		}
		else if (global.fontSize == 3) {
			versionTextX = logoX + sprite_get_width(spr_logo)* .3;
			versionTextY = logoY + sprite_get_height(spr_logo)* .48;
		}
		else if (global.fontSize == 4) {
			versionTextX = logoX + sprite_get_width(spr_logo)* .332;
			versionTextY = logoY + sprite_get_height(spr_logo)* .53;
		}
		else if(global.fontSize == 5) {
			versionTextX = logoX + sprite_get_width(spr_logo)* .37;
			versionTextY = logoY + sprite_get_height(spr_logo)* .58;
		}
		
		draw_text(versionTextX, versionTextY, global.versionString);
	}
}