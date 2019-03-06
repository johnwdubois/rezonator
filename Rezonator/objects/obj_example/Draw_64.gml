draw_sprite_tiled(spr_background, 0, get_timer() * 0.00002, get_timer() * 0.00001);

switch (example) {
    case 0:
        draw_set_color(c_ltgray); draw_set_font(ft_info_big);
        draw_set_halign(fa_center); draw_set_valign(fa_middle);
        draw_text(room_width >> 1, room_height >> 1, "Poor input boxes make your game look and\nfeel unprofessional, and can ruin the important\nfirst impression of a player. But they're a\npain to program properly.\n\nWith the Text Inputs extension you can avoid dozens\nof hours of UI programming, and get high\nquality text inputs in an instant!");
        break;
        
    case 1:
        draw_set_color(c_ltgray); draw_set_font(ft_info_small);
        draw_set_halign(fa_center); draw_set_valign(fa_middle);
        draw_text(room_width >> 1, room_height >> 2, "Here's an example. The extension supports text navigation, selection,\ncopying/pasting, undo/redo and more. When using the\nextension, you can decide which features to include for each of your\ntext inputs. It's made entirely in GML and is very customizable.");
        with (obj_input_text) draw_sprite(spr_input_0, 0, x - 16, y);
        break;
        
    case 2:
        draw_set_color(c_ltgray); draw_set_font(ft_info_small);
        draw_set_halign(fa_center); draw_set_valign(fa_top);
        draw_text(room_width >> 1, 50, "A lot of work has gone into realizing multiline inputs.\nPerfect for chat systems, ingame logs, signs, books, editors etc.\nThe left input is with text wrapping, the right is without.");
        with (obj_input_text) draw_sprite(spr_input_1, 0, x - 16, y - 16);
        break;
        
    case 3:
        draw_set_color(c_ltgray); draw_set_font(ft_info_small);
        draw_set_halign(fa_center); draw_set_valign(fa_top);
        draw_text(room_width >> 1, 50, "Text can be aligned horizontally and vertically in nine different ways.");
        with (obj_input_text) draw_sprite(spr_input_2, 0, x - origin_x - 12, y - origin_y - 12);
        break;
    
    case 4:
        draw_set_color(c_ltgray); draw_set_font(ft_info_small);
        draw_set_halign(fa_center); draw_set_valign(fa_top);
        draw_text(room_width >> 1, 50, "There are three different ways to fit the text inside its rectangle:\nThe default shifting, uniform scaling, and stretched scaling.");
        with (obj_input_text) draw_sprite(spr_input_2, 0, x - 12, y - 12);
        break;
        
    case 5:
        draw_set_color(c_ltgray); draw_set_font(ft_info_small);
        draw_set_halign(fa_center); draw_set_valign(fa_top);
        draw_text(room_width >> 1, 50, "You can scale, rotate, set character/line limits, choose color and alpha,\nchange text cursor sprite, remove or use another input background and more.");
        with (colorful) draw_sprite_ext(spr_input_3, 0, x, y, 1, 1, 0, c_orange, 1);
        with (rotated) draw_sprite_ext(spr_input_3, 0, x, y, 1, 1, image_angle, c_white, 1);
        with (vertical) draw_sprite_ext(spr_input_3, 0, x, y, 1, 1, -90, c_white, 1);
        break;
        
    case 6:
        draw_set_color(c_ltgray); draw_set_font(ft_info_big);
        draw_set_halign(fa_center); draw_set_valign(fa_middle);
        draw_text(room_width >> 1, room_height >> 1, "I hope that got you interested! You can\nget the extension at the YoYo Games Marketplace.\nThanks for your attention.");
        break;
}

if (example == examples - 1) {
    if (os_browser == browser_not_a_browser) {
        draw_set_color(c_ltgray); draw_set_font(ft_info_small);
        draw_set_halign(fa_center); draw_set_valign(fa_middle);
        draw_text(room_width - 50, room_height - 45, "Quit");
    }
} else draw_sprite(spr_arrow, 0, room_width - 50, room_height - 45);
if (example != 0) draw_sprite_ext(spr_arrow, 0, 50, room_height - 45, -1, 1, 0, c_white, 1);

