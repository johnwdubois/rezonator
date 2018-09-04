if (!obj_control.gridView)
{
	exit;
}

var scrollTogetherButtonX = 100;
var scrollTogetherButtonY = 100;
var scrollTogetherButtonRectX1 = scrollTogetherButtonX - sprite_get_width(spr_scrollTogether) / 2;
var scrollTogetherButtonRectY1 = scrollTogetherButtonY - sprite_get_height(spr_scrollTogether) / 2;
var scrollTogetherButtonRectX2 = scrollTogetherButtonX + sprite_get_width(spr_scrollTogether) / 2;
var scrollTogetherButtonRectY2 = scrollTogetherButtonY + sprite_get_height(spr_scrollTogether) / 2;

draw_sprite_ext(spr_scrollTogether, scrollTogether, scrollTogetherButtonX, scrollTogetherButtonY, 1, 1, 0, c_purple, 1);

if (point_in_rectangle(mouse_x, mouse_y, scrollTogetherButtonRectX1, scrollTogetherButtonRectY1, scrollTogetherButtonRectX2, scrollTogetherButtonRectY2))
{
	if (mouse_check_button_pressed(mb_left))
	{
		if (scrollTogether)
		{
			scrollTogether = false;
		}
		else
		{
			scrollTogether = true;
			
			/*
			for (var i = 0; i < array_length_1d(grid); i++)
			{
				gridCurrentTopViewRow[i] = 0;
			}
			*/
		}
	}
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fnt_debug);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

scr_drawGridViewer(0);
scr_drawGridViewer(1);