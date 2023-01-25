function scr_drawLogo(logoX, logoY, drawVersion) {
	
	draw_set_alpha(1);
	var logoSpr = global.html5 ? spr_logoWeb : spr_logo;
	var logoScale = clamp(camera_get_view_height(camera_get_active()) / 2160, 0.25, 1);	
	draw_sprite_ext(logoSpr, global.fontSize, logoX, logoY, 1, 1, 0, c_white, 1);
	
	if (drawVersion) {

		draw_set_halign(fa_right);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(string(global.versionString), "S");
		var versionTextX = 0;
		var versionTextY = 0;
		if (global.fontSize == 0) {
			versionTextX = logoX + sprite_get_width(logoSpr)* .185;
			versionTextY = logoY + sprite_get_height(logoSpr)* .3;
		}
		else if (global.fontSize == 1) {
			versionTextX = logoX + sprite_get_width(logoSpr)* .222;
			versionTextY = logoY + sprite_get_height(logoSpr)* .36;
		}
		else if (global.fontSize == 2) {
			versionTextX = logoX + sprite_get_width(logoSpr)* .26;
			versionTextY = logoY + sprite_get_height(logoSpr)* .41;
		}
		else if (global.fontSize == 3) {
			versionTextX = logoX + sprite_get_width(logoSpr)* .3;
			versionTextY = logoY + sprite_get_height(logoSpr)* .48;
		}
		else if (global.fontSize == 4) {
			versionTextX = logoX + sprite_get_width(logoSpr)* .332;
			versionTextY = logoY + sprite_get_height(logoSpr)* .53;
		}
		else if (global.fontSize == 5) {
			versionTextX = logoX + sprite_get_width(logoSpr)* .37;
			versionTextY = logoY + sprite_get_height(logoSpr)* .58;
		}
		
		if (global.html5) {
			versionTextX -= string_width("000000");
		}
		
		draw_text(versionTextX, versionTextY, global.versionString);
	}
}