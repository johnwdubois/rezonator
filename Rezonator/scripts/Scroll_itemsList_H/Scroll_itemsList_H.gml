	var color = argument0

var list = ds_list_create()

for(var a = 0 ; a < 20 ; a++)
{		
	var ins = instance_create_depth(x,y,depth,Obj_Scroll_Holder_H)
	ins.image_blend = color
	ds_list_add(list,ins)
}

var scroll = Scroll_create(x,y,depth,sprite_width,sprite_height,list,"V",128,1)


return scroll;