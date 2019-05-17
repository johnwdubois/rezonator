/// @description Insert description here
// You can write your code in this editor

Scroll_Example4()
instance_destroy()

/*
var list = ds_list_create()

for(var a = 0 ; a < 10 ; a++)
{
	var ins = instance_create_depth(x,y,depth,Obj_Scroll_product)
	ins.name = "NAME" + string(a)
	ins.price = "PRICE" + string(a)
		var list_product = ds_list_create()
		//ds_list_add(list_product,instance_create_depth(30,30,depth,Obj_Scroll_buy))
		ds_list_add(list_product,instance_create_depth(30,30,depth,Obj_Scroll_Left_))
		ds_list_add(list_product,instance_create_depth(30,130,depth,Obj_Scroll_Right_))
	ins.list = list_product
	
	ds_list_add(list,ins)
}
	
var scroll = Scroll_create(x,y,depth,sprite_width,sprite_height,list,"V",512,1)

Scroll_dragDisable(scroll)

//This object dont matter
instance_destroy()

