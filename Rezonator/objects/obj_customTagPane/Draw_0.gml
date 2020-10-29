windowWidth = camera_get_view_width(camera_get_active()) / 2;
windowHeight = camera_get_view_height(camera_get_active()) / 2;
x = (camera_get_view_width(camera_get_active()) / 2) - (windowWidth / 2);
y = (camera_get_view_height(camera_get_active()) / 2) - (windowHeight / 2);

draw_set_alpha(1);
draw_set_color(global.colorThemeSelected1);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

draw_set_alpha(1);
draw_set_color(global.colorThemeBorders);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);

if (instance_exists(obj_customTag_labelPane)) {
	var textX = floor(mean(obj_customTag_labelPane.x, obj_customTag_labelPane.x + obj_customTag_labelPane.windowWidth));
	var textY = floor(mean(y, obj_customTag_labelPane.y));
	draw_set_font(global.fontMainBold);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	draw_text(textX, textY, scr_get_translation("msg_labels"));
}

if (instance_exists(obj_customTag_tagListPane)) {
	var textX = floor(mean(obj_customTag_tagListPane.x, obj_customTag_tagListPane.x + obj_customTag_tagListPane.windowWidth));
	var textY = floor(mean(y, obj_customTag_tagListPane.y));
	draw_set_font(global.fontMainBold);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	draw_text(textX, textY, scr_get_translation("msg_create_tag"));
}