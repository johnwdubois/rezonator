
var list = argument0

if(!ds_exists(list,ds_type_list))
	exit

var a = 0
while(true)
{

	var ins = list[|a]
	
	if(is_undefined(ins))
		break
		
	with(ins)
	{
		draw = true
		event_perform(ev_draw,0)
		draw = false
	}
	
	a++
	
}

