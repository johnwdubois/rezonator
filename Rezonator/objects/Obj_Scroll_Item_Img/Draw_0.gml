/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(!draw)
	exit

var text = ""

switch(image_index)
{
	case 0: text = "Star"; break
	case 1: text = "!!!"; break
	case 2: text = "Nice"; break
	case 3: text = "NOT"; break
	case 4: text = "???"; break
}

draw_set_valign(fa_left)
draw_set_halign(fa_left)

draw_set_color(c_black)
draw_set_font(Font_Normal)

if(owner.owner.V_H == "V")
	draw_text(Xdraw+140 ,Ydraw+20, text)
else
	draw_text(Xdraw+20,Ydraw-90, text)
	