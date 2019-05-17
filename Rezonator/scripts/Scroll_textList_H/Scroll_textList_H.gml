	var color = argument0

var list = ds_list_create()

for(var a = 0 ; a < 20 ; a++)
{		
	var ins = instance_create_depth(x,y,depth,Obj_Scroll_text_H)
	ins.text = "Text #" + string(a)
	ins.image_blend = color
	ds_list_add(list,ins)
}

var scroll = Scroll_create(x,y,depth,256,sprite_height,list,"V",64,1)


return scroll;