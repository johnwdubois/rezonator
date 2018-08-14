var filterButtonRadius = 8;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_chainContents);

var filterButtonX = x + (windowWidth / 2);
var filterButtonY = y + filterButtonRadius;

if (obj_control.filterGridActive)
{	
	draw_set_color(c_black);
	draw_circle(filterButtonX, filterButtonY, filterButtonRadius, false);
	draw_set_color(c_white);
	draw_text(filterButtonX, filterButtonY, "F");
}
else
{
	draw_set_color(c_black);
	draw_circle(filterButtonX, filterButtonY, filterButtonRadius, true);
	draw_text(filterButtonX, filterButtonY, "F");
}

draw_set_halign(fa_left);

for (var i = 0; i < 3; i++)
{
	var peekButtonRectX1 = x;
	var peekButtonRectY1 = y + (filterButtonRadius * 2) + (i * ((windowHeight - (filterButtonRadius * 2)) / 3));
	var peekButtonRectX2 = peekButtonRectX1 + windowWidth;
	var peekButtonRectY2 = peekButtonRectY1 + ((windowHeight - (filterButtonRadius * 2)) / 3);
	
	if (point_in_rectangle(mouse_x, mouse_y, peekButtonRectX1, peekButtonRectY1, peekButtonRectX2, peekButtonRectY2))
	{
		if (mouse_check_button_pressed(mb_left))
		{
			with (obj_panelPane)
			{
				functionFilter_peek[i] = !functionFilter_peek[i];
			}
			
			if (obj_control.filterGridActive)
			{
				with (obj_control)
				{
					scr_renderFilter();
				}
			}
		}
	}
	
	if (functionFilter_peek[i])
	{
		draw_set_color(obj_control.c_ltblue);
		draw_rectangle(peekButtonRectX1, peekButtonRectY1, peekButtonRectX2, peekButtonRectY2, false);
	}
	
	draw_set_color(c_black);
	
	var buttonText = "";
	switch (i)
	{
		case 0:
			buttonText = "Before";
			break;
		case 1:
			buttonText = "Tween";
			break;
		case 2:
			buttonText = "After";
			break;
		default:
			break;
	}
	draw_text_transformed(mean(peekButtonRectX1, peekButtonRectX2), peekButtonRectY2, buttonText, 1, 1, 90);
	
	draw_rectangle(peekButtonRectX1, peekButtonRectY1, peekButtonRectX2, peekButtonRectY2, true);
}

if (point_in_circle(mouse_x, mouse_y, filterButtonX, filterButtonY, filterButtonRadius))
{
	if (mouse_check_button_pressed(mb_left))
	{
		if (obj_control.filterGridActive)
		{
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
		}
		else
		{
			with (obj_control)
			{
				scr_renderFilter();
			}
		}
	}
}