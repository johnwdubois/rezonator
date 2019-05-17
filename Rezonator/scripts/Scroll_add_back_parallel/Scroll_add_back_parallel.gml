/// @function Scroll_add_back_parallel(scroll,ins)
/// @description 

/// @param {real} scroll
/// @param {real} ins

var list = argument0
var Obj_Scroll_back_child = argument1

for(var a = 0 ; a < ds_list_size(list) ; a++)
{
	var scroll = list[|a]
	scroll.Back = Obj_Scroll_back_child
}

Obj_Scroll_back_child.list = list

