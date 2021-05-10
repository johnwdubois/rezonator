/// @description Insert description here
// You can write your code in this editor

// Check for LMB clicks
if (mouse_check_button_pressed(mb_left) )
{
	if (obj_control.hoverTokenID != -1)
	{
		// A word has been clicked
		// Set up the persistent box
		persistentBoxFlag = true;
		currentWordID = obj_control.hoverTokenID;
		boxX = mouse_x + mouseCursorWidth;
		boxY = mouse_y + mouseCursorHeight;
	}
	
	else
	{
		// A non-word has been clicked
		// Stop showing a persistent box (if there was one)
		persistentBoxFlag = false;	
	}
}