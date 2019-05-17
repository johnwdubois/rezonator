/// @description Insert description here
// You can write your code in this editor

Scroll_Example5()
instance_destroy()

/*
/// @description Insert description here
// You can write your code in this editor

var list = ds_list_create()

for(var a = 0 ; a < 10 ; a++)
{
	var ins = instance_create_depth(x,y,depth,Obj_Scroll_product)
	ins.name = "NAME" + string(a)
	ins.price = "PRICE" + string(a)
		var list_product = ds_list_create()
		var ins_ = instance_create_depth(30,30,depth,Obj_Scroll_buy)
		ins.text = "im here :)"
		ds_list_add(list_product,ins_)
	ins.list = list_product
	
	ds_list_add(list,ins)
}
	
var scroll = Scroll_create(x,y,depth,sprite_width,sprite_height,list,"H",512,1)

var next = instance_create_depth(bbox_left,bbox_bottom+32,depth,Obj_Scroll_Up)
var back = instance_create_depth(bbox_right-64,bbox_bottom+32,depth,Obj_Scroll_Down)

Scroll_add_next(scroll,next)
Scroll_add_back(scroll,back)

var slider = instance_create_depth(bbox_right,bbox_bottom + 64,depth,Obj_Scroll_Slider_H)

Scroll_add_slider(scroll,slider,bbox_left + 96,bbox_right - 96)


//This object dont matter
instance_destroy()

