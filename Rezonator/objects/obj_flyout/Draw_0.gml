if (!ds_exists(optionList, ds_type_list)) exit;
if (!sprite_exists(sprite)) exit;


var imageNum = sprite_get_number(sprite);
var optionScale = 0.8;
var sprWidth = sprite_get_width(sprite)
windowWidth = imageNum * sprWidth;
var flyoutX1 = x - windowWidth;
var flyoutY1 = y - sprWidth * 0.5;
var flyoutX2 = x;
var flyoutY2 =  flyoutY1 + sprite_get_height(sprite);

scr_dropShadow(flyoutX1 + 4, flyoutY1, flyoutX2, flyoutY2);

// draw flyout BG & outline
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_roundrect(flyoutX1, flyoutY1, flyoutX2, flyoutY2, false);

// draw flyout options
var optionY = floor(y);
var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox);
for (var i = 0; i < imageNum; i++) {
	
	var optionStr = string(ds_list_find_value(optionList, i));
	
	// get coordinates for current option
	var currentOptionX = floor(flyoutX1 + ((windowWidth / imageNum) * (i + 0.5)));
	var currentOptionRectX1 = currentOptionX - (sprWidth * 0.5);
	var currentOptionRectY1 = flyoutY1;
	var currentOptionRectX2 = currentOptionRectX1 + sprWidth;
	var currentOptionRectY2 = flyoutY2;
	var mouseoverCurrentOption = point_in_rectangle(mouse_x, mouse_y, currentOptionRectX1, currentOptionRectY1, currentOptionRectX2, currentOptionRectY2) && !mouseoverCancel;
	
	// mouseover & click on option
	if (mouseoverCurrentOption) {
		
		var optionBGRectX1 = currentOptionX - (sprWidth * optionScale * 0.5) + 2;
		var optionBGRectY1 = y - (sprWidth * optionScale * 0.5) + 2;
		var optionBGRectX2 = optionBGRectX1 + (sprWidth * optionScale) - 4;
		var optionBGRectY2 = optionBGRectY1 + (sprWidth * optionScale) - 4;
		
		draw_set_color(global.colorThemeSelected1);
		draw_roundrect(currentOptionRectX1, currentOptionRectY1, currentOptionRectX2, currentOptionRectY2, false);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(optionBGRectX1, optionBGRectY1, optionBGRectX2, optionBGRectY2, false);
		
		scr_createTooltip(mean(currentOptionRectX1, currentOptionRectX2), currentOptionRectY2, optionStr, obj_tooltip.arrowFaceUp);
		
		if (mouse_check_button_released(mb_left)) scr_flyoutSelect(optionStr);
	}
	
	// draw option sprite
	draw_sprite_ext(sprite, i, currentOptionX, optionY, optionScale, optionScale, 0, global.colorThemeText, 1);
	
}

draw_set_color(global.colorThemeBorders);
draw_roundrect(flyoutX1, flyoutY1, flyoutX2, flyoutY2, true);