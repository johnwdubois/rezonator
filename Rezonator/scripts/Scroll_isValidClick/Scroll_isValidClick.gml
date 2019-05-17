/// @function Scroll_isValidClick()
/// @description 

if(mouse_x > master.x and mouse_x<master.x+master.width)
if(mouse_y > master.y and mouse_y<master.y+master.heigth)
{

	var ok = false
	var owner_ = owner
	while(true)
	{
		if(!owner_)
		{
			ok = true//Ok anthing is dragging
			break
		}

		if(owner_.object_index == Obj_Scroll)
		if(owner_.drag_enable)
		{
			if(owner_.dragging_abs < 15)
			if(owner_.press_steps < room_speed/2)
			{
				ok = true
			}
			break
			
		}
		
		owner_ = owner_.owner
	
	}
	
	if(ok)
	{
		return(true)
	}
}

return(false)