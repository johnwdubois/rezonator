/// @description Insert description here
// You can write your code in this editor

if(pressed)
if(mouse_check_button(mb_left))
{
	var pos;
	
	if(V_H == "V")
		pos = mouse_y
	else	
		pos = mouse_x
	
	var porcent = (pos - start_sprite) / (end_sprite - start_sprite) * 100
	
	Scroll_moveToPorcent_brute(owner,porcent)
	
	event_perform(ev_other,ev_user1)
	
}
else
	pressed = false