/// @description Insert description here
// You can write your code in this editor

if(!owner)
{

	var surf = surface_create(width,heigth)

	surface_set_target(surf)

	Script_Scroll_draw_childs(list)
	
	surface_reset_target()

	draw_surface(surf,x,y)

	surface_free(surf)
}
else
{
	
	if(!draw)
		exit
	
	Script_Scroll_draw_childs(list)
	
}


