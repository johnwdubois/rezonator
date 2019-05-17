
var list = ds_list_create()

var scroll 

if(Obj_Scroll_mode.value)
	scroll = Scroll_textList_V(c_white)
else
	scroll = Scroll_itemsList_V(c_white)

//Scroll_dragDisable(scroll)
ds_list_add(list,scroll)

y += 260

var scroll 

if(Obj_Scroll_mode.value)
	scroll = Scroll_textList_V(c_aqua)
else
	scroll = Scroll_itemsList_V(c_aqua)
	
//Scroll_dragDisable(scroll)

ds_list_add(list,scroll)

var back = instance_create_depth(x,y + sprite_height+16,depth,Obj_Scroll_Back_Parallel_)
var next = instance_create_depth(x + sprite_width - 64,y + sprite_height+16,depth,Obj_Scroll_Next_Parallel_)

Scroll_add_next_parallel(list,next)
Scroll_add_back_parallel(list,back)

var slider = instance_create_depth(bbox_left,bbox_bottom+32,depth,Obj_Scroll_Slider_H_parallel)
Scroll_add_slider_parallel(list,slider,bbox_left+96,bbox_right-96)


