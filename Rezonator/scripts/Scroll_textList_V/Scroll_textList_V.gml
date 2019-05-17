var color = argument0

var list = ds_list_create()

for(var a = 0 ; a < 20 ; a++)
{
	var ins = instance_create_depth(x,y,depth,Obj_Scroll_text_V)
	ins.text = "T\ne\nx\nt\n\n#\n" + string(a)
	ins.image_blend = color
	ds_list_add(list,ins)
}
	
var scroll = Scroll_create(x,y,depth,sprite_width,256,list,"H",64,1)

return scroll;
