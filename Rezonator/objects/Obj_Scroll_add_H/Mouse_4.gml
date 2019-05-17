/// @description Insert description here
// You can write your code in this editor

var list = Scroll_getList(owner)

var ins = instance_create_depth(x,y,depth,Obj_Scroll_text_V)
ins.text = "a\nd\nd\ne\nd\n\n:)"
ds_list_add(list,ins)


Scroll_refresh(owner)