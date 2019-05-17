var list = ds_list_create()

for(var a = 0 ; a < 5 ; a++)
{		
	var scroll
	if(Obj_Scroll_mode.value)
		scroll = Scroll_textList_V(Scroll_colorExamples(a))
	else
		scroll = Scroll_itemsList_V(Scroll_colorExamples(a))
		
	ds_list_add(list,scroll)
}

var scroll = Scroll_create(x,y,depth,sprite_width,sprite_height,list,"V",256,3)

var slider = instance_create_depth(bbox_right+64,bbox_bottom,depth,Obj_Scroll_Slider_V)
Scroll_add_slider(scroll,slider,bbox_top+96,bbox_bottom-96)

var back = instance_create_depth(x + sprite_width + 32,y,depth,Obj_Scroll_Back_)
var next = instance_create_depth(x + sprite_width + 32,y + sprite_height - 64,depth,Obj_Scroll_Next_)


Scroll_add_next(scroll,next)
Scroll_add_back(scroll,back)


Scroll_addParallel(list)

