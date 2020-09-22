/// @description Insert description here
// You can write your code in this editor

if (obj_control.gridView) {
	exit;
}

submitChainRectX1 = (camera_get_view_width(camera_get_active())/2) - 95;
submitChainRectY1 = camera_get_view_height(camera_get_active()) - 100;
submitChainRectX2 = (camera_get_view_width(camera_get_active())/2) + 95;
submitChainRectY2 = camera_get_view_height(camera_get_active());

submitChainButtonX1 = submitChainRectX1 + 10;
submitChainButtonY1 = submitChainRectY1 + 50;
submitChainButtonX2 = submitChainRectX2 - 10;
submitChainButtonY2 = submitChainRectY2 - 10;

draw_set_colour(global.colorThemeBG);
draw_roundrect(submitChainRectX1, submitChainRectY1, submitChainRectX2, submitChainRectY2, false);
draw_set_colour(global.colorThemeBorders);
draw_roundrect(submitChainRectX1, submitChainRectY1, submitChainRectX2, submitChainRectY2, true);

draw_set_font(fnt_mainBold);
draw_set_halign(fa_center);
if(global.wheresElmo) {
	draw_text(mean(submitChainRectX1,  submitChainRectX2), 20 + submitChainRectY1, "Where's Elmo");
	draw_text(mean(submitChainButtonX1,  submitChainButtonX2), 20 + submitChainButtonY1, "Submit Chain");
}
else if(global.rezzles) {
	draw_text(mean(submitChainRectX1,  submitChainRectX2), 20 + submitChainRectY1, "Rezzles");
	draw_text(mean(submitChainButtonX1,  submitChainButtonX2), 20 + submitChainButtonY1, "End Chain");
}
else {
	draw_text(mean(submitChainRectX1,  submitChainRectX2), 20 + submitChainRectY1, "StackShow");
	draw_text(mean(submitChainButtonX1,  submitChainButtonX2), 20 + submitChainButtonY1, "End Chain");
}

draw_rectangle(submitChainButtonX1, submitChainButtonY1, submitChainButtonX2, submitChainButtonY2, true);

var mouseOver = point_in_rectangle(mouse_x, mouse_y, submitChainButtonX1, submitChainButtonY1, submitChainButtonX2, submitChainButtonY2);
if(mouseOver) {
	draw_set_alpha(0.25);
	draw_rectangle(submitChainButtonX1, submitChainButtonY1, submitChainButtonX2, submitChainButtonY2, false);
	draw_set_alpha(1);
	if(device_mouse_check_button_released(0, mb_left)) {
		if(!obj_control.dialogueBoxActive){
			with(obj_chain) {
				
				if(obj_control.stackShowActive and (global.wheresElmo or obj_toolPane.tracksOnlyStackShow)) {
					scr_goldStandard();
				}
	
				scr_chainDeselect();

				scr_refreshVizLinkGrid();
			}
		}
	}
}
