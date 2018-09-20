draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(c_black);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);

var iconMarginTop = 30;
var iconPlusY = 0;
var iconPlusYIncrement = sprite_get_height(spr_tools) * 1.5;
var iconHorizontalSpacing = 20;

for (var i = 0; i < sprite_get_number(spr_tools); i++)
{
	if (i == sprite_get_number(spr_tools) - 1)
	{
		continue;
	}
	
	var iconX = x + (windowWidth / 2);
	var iconY = y + iconMarginTop + iconPlusY;
	
	if (i mod 2 == 0)
	{
		iconX -= iconHorizontalSpacing;
	}
	else
	{
		iconX += iconHorizontalSpacing;
	}
	
	var spriteColor = c_white;
	if (currentTool == i)
	{
		spriteColor = c_fuchsia;
	}
	
	draw_sprite_ext(spr_tools, i, iconX, iconY, 1, 1, 0, spriteColor, 1);
	
	var mouseoverRectX1 = iconX - sprite_get_width(spr_tools) / 2;
	var mouseoverRectY1 = iconY - sprite_get_height(spr_tools) / 2;
	var mouseoverRectX2 = mouseoverRectX1 + sprite_get_width(spr_tools);
	var mouseoverRectY2 = mouseoverRectY1 + sprite_get_height(spr_tools);
	
	if (point_in_rectangle(mouse_x, mouse_y, mouseoverRectX1, mouseoverRectY1, mouseoverRectX2, mouseoverRectY2))
	{
		var rectBuffer = 2;
		draw_set_color(c_gray);
		draw_rectangle(mouseoverRectX1 - rectBuffer, mouseoverRectY1 - rectBuffer, mouseoverRectX2 + rectBuffer, mouseoverRectY2 + rectBuffer, true);
		
		if (mouse_check_button_pressed(mb_left))
		{
			currentTool = i;
		}
	}
	
	if (i mod 2 == 1)
	{
		iconPlusY += iconPlusYIncrement;
	}
}

scr_drawImportProgressBar();