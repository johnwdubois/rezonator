var list = ds_list_create()

for(var a = 0 ; a < 5 ; a++)
{
	var scroll
	if(Obj_Scroll_mode.value)
		scroll = Scroll_textList_H(Scroll_colorExamples(a))
	else
		scroll = Scroll_itemsList_H(Scroll_colorExamples(a))
		
	ds_list_add(list,scroll)
}

var scroll = Scroll_create(x,y,depth,sprite_width,sprite_height,list,"H",256,3)

var slider = instance_create_depth(bbox_right,bbox_bottom+32,depth,Obj_Scroll_Slider_H)
Scroll_add_slider(scroll,slider,bbox_left,bbox_right)

var back = instance_create_depth(x - 96 ,bbox_bottom,depth,Obj_Scroll_Back_)
var next = instance_create_depth(bbox_right + 32,bbox_bottom,depth,Obj_Scroll_Next_)

Scroll_add_next(scroll,next)
Scroll_add_back(scroll,back)

Scroll_dragDisable(scroll)



var slider = instance_create_depth(bbox_right + 64,bbox_bottom+32,depth,Obj_Scroll_Slider_V_parallel)
Scroll_add_slider_parallel(list,slider,bbox_top+96,bbox_bottom-64-32)


var back = instance_create_depth(bbox_right+ 32,bbox_top,depth,Obj_Scroll_Back_Parallel_)
var next = instance_create_depth(bbox_right+ 32,bbox_bottom-64-1,depth,Obj_Scroll_Next_Parallel_)
Scroll_add_next_parallel(list,next)
Scroll_add_back_parallel(list,back)
