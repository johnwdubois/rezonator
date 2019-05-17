/// @function Scroll_add_next_parallel(scroll,ins)
/// @description 

/// @param {real} scroll
/// @param {real} ins

var list = argument0
var Obj_Scroll_next_child  = argument1

for(var a = 0 ; a < ds_list_size(list) ; a++)
{
	var scroll = list[|a]
	scroll.Back = Obj_Scroll_next_child 
}

Obj_Scroll_next_child.list = list

