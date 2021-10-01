
var text = "buh";

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(col);
draw_set_alpha(1);
scr_adaptFont(text, "L", true);
draw_text_transformed(x, y, text, scale, scale, angle);

angle += spinSpeed;