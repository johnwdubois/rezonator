
var scroll 

if(Obj_Scroll_mode.value)
	scroll = Scroll_textList_H(c_white)
else
	scroll = Scroll_itemsList_H(c_white)

var back = instance_create_depth(x + sprite_width + 32,y,depth,Obj_Scroll_Back_)
var next = instance_create_depth(x + sprite_width + 32,y + sprite_height - 64,depth,Obj_Scroll_Next_)

Scroll_add_next(scroll,next)
Scroll_add_back(scroll,back)

var slider = instance_create_depth(bbox_right+64,y,depth,Obj_Scroll_Slider_V)

Scroll_add_slider(scroll,slider,bbox_top + 96,bbox_bottom - 96)


var ins = instance_create_depth(bbox_left-96,bbox_top,depth,Obj_Scroll_add_V)
ins.owner = scroll

var ins = instance_create_depth(bbox_left-96,bbox_top+128+32,depth,Obj_Scroll_shuffle_V)
ins.owner = scroll


Scroll_refresh(scroll)

