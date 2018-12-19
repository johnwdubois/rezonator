if (not obj_control.gridView)
{
	if (keyboard_check_pressed(ord("R")))
	{
		with (obj_chain)
		{
			scr_chainDeselect();
		}
		currentTool = toolRezBrush;
	}
	else if (keyboard_check_pressed(ord("T")))
	{
		with (obj_chain)
		{
			scr_chainDeselect();
		}
		currentTool = toolTrackBrush;
	}
	else if (keyboard_check_pressed(ord("K")))
	{
		with (obj_chain)
		{
			scr_chainDeselect();
		}
		currentTool = toolStackBrush;
	}
}