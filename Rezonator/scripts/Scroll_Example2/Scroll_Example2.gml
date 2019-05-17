
var scroll 

if(Obj_Scroll_mode.value)
	scroll = Scroll_textList_V(c_white)
else
	scroll = Scroll_itemsList_V(c_white)
	
var back = instance_create_depth(bbox_left,bbox_bottom+32,depth,Obj_Scroll_Back_)
var next = instance_create_depth(bbox_right - 64,bbox_bottom+32,depth,Obj_Scroll_Next_)

Scroll_add_next(scroll,next)
Scroll_add_back(scroll,back)

var slider = instance_create_depth(bbox_right,bbox_bottom + 64,depth,Obj_Scroll_Slider_H)

Scroll_add_slider(scroll,slider,bbox_left + 96,bbox_right - 96)


var ins = instance_create_depth(bbox_left,bbox_top-96,depth,Obj_Scroll_add_H)
ins.owner = scroll

var ins = instance_create_depth(bbox_left+128+32,bbox_top-96,depth,Obj_Scroll_shuffle_H)
ins.owner = scroll

return scroll;