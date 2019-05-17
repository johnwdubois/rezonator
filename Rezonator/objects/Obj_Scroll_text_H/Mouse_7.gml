/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(!Scroll_isValidClick())
	exit

show_debug_message(ind)
var list = Scroll_getList(owner)
	
ds_list_delete(list,ind)
instance_destroy()

Scroll_refresh(owner)

