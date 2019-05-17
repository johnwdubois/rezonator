/// @function Scroll_addParallel(list<scroll>)
/// @description 

/// @param {real} list<scroll>

var list = argument0

var ins_parallel = instance_create_depth(0,0,depth,Obj_Scroll_parallel)


var a = 0;
while(true)
{
	var scroll = list[|a]
	if(is_undefined(scroll))
		break
		
	scroll.parallelObj = ins_parallel
	a++
	
}

ins_parallel.list = list


with(ins_parallel)
	event_perform(ev_other,ev_user0)
	