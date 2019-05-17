/// @description Insert description here
// You can write your code in this editor

////////////////////////////////DRAG MOVE

if(owner)
	event_inherited()

if(drag_enable)
{
	if(!pressed)
	if(mouse_check_button_pressed(mb_left))
	if(mouse_x > master.x and mouse_x<master.x+master.width)
	if(mouse_y > master.y and mouse_y<master.y+master.heigth)
	if(point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+heigth))
	{
		pressed = true
		press_steps = 0
		dragging_abs = 0
		dragging_x = mouse_x
		dragging_y = mouse_y
	}


	if(pressed)
	if(mouse_check_button(mb_left))
	{
		
		press_steps ++
	
		var dif;
		if(V_H == "V")
			dif = mouse_y - dragging_y
		else
			dif = mouse_x - dragging_x
		
		dragging_abs += abs(dif)
		var goto = Scroll_getPos(id) - dif

		Scroll_moveToPixels(id,goto)
	
		dragging_x = mouse_x
		dragging_y = mouse_y
	
	}
	else
		pressed = false
}

///////////////////////////////////////HANDLER OF ALL MOVES!!!! dont touch . . . is perfect :)
if(abs(pixels_transfer - pixels) > 0.2)
{
	
	pixels_transfer += (pixels - pixels_transfer) / Scroll_K_transfer
	porcent_transfer = pixels_transfer / move_lenght * 100
			
	with(Slider)
		if(!pressed)
			event_perform(ev_other,ev_user1)
		
	with(parallelObj)
		event_perform(ev_other,ev_user0)
	
	Script_Scroll_callChildenMove(list)
	
}

