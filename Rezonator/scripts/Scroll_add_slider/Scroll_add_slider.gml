/// @function Scroll_add_slider(scroll,ins,start,end)
/// @description 

/// @param {real} scroll
/// @param {real} ins
/// @param {real} start
/// @param {real} end

var scroll = argument0
var Obj_Scroll_slider_child = argument1
var start_ = argument2
var end_ = argument3


scroll.Slider = Obj_Scroll_slider_child
Obj_Scroll_slider_child.owner = scroll

Obj_Scroll_slider_child.start_ = start_
Obj_Scroll_slider_child.end_ = end_

Obj_Scroll_slider_child.V_H = scroll.V_H

with(Obj_Scroll_slider_child)
	event_perform(ev_other,ev_user0)
	