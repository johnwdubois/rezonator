/// @function Scroll_add_slider_parallel(scroll,ins,start,end)
/// @description 

/// @param {real} scroll
/// @param {real} ins
/// @param {real} start
/// @param {real} end

var list = argument0
var Obj_Scroll_slider_child = argument1
var start_ = argument2
var end_ = argument3

var a = 0;
while(true)
{
	var scroll = list[|a]
	if(is_undefined(scroll))
		break
		
	scroll.Slider = Obj_Scroll_slider_child
	a++
	
}

Obj_Scroll_slider_child.list = list

Obj_Scroll_slider_child.start_ = start_
Obj_Scroll_slider_child.end_ = end_

Obj_Scroll_slider_child.V_H = list[|0].V_H

with(Obj_Scroll_slider_child)
	event_perform(ev_other,ev_user0)
	