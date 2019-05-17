/// @description Insert description here
// You can write your code in this editor


if(!ds_exists(list,ds_type_list))
	exit

var a = 0;
while(true)
{

	var ins = list[|a]
	
	if(is_undefined(ins))
		break
	
	ins.master = master
	ins.depth = depth - 1
	ins.owner = id
	ins.ind = a

	ins.Xstart = ins.x
	ins.Ystart = ins.y
	
	ins.x = x + ins.x
	ins.y = y + ins.y

	
	a++
}

Script_Scroll_callChildenMove(list)
