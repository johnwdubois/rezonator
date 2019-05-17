
var list = ds_list_create()

var scroll 

if(Obj_Scroll_mode.value)
	scroll = Scroll_textList_H(c_white)
else
	scroll = Scroll_itemsList_H(c_white)

//Scroll_dragDisable(scroll)
ds_list_add(list,scroll)

x += 260


if(Obj_Scroll_mode.value)
	scroll = Scroll_textList_H(c_aqua)
else
	scroll = Scroll_itemsList_H(c_aqua)
//Scroll_dragDisable(scroll)

ds_list_add(list,scroll)

x += 260

if(Obj_Scroll_mode.value)
	scroll = Scroll_textList_H(c_lime)
else
	scroll = Scroll_itemsList_H(c_lime)

//Scroll_dragDisable(scroll)
ds_list_add(list,scroll)

var back = instance_create_depth(x + sprite_width + 32,y,depth,Obj_Scroll_Back_Parallel_)
var next = instance_create_depth(x + sprite_width + 32,y+sprite_height-64,depth,Obj_Scroll_Next_Parallel_)

Scroll_add_next_parallel(list,next)
Scroll_add_back_parallel(list,back)


var slider = instance_create_depth(bbox_right+64,bbox_bottom,depth,Obj_Scroll_Slider_V_parallel)
Scroll_add_slider_parallel(list,slider,bbox_top + 96,bbox_bottom - 96)


