/// @description Insert description here
// You can write your code in this editor


var a = 0
var ins_pressed = list[|0]
while(true)
{	
	var ins = list[|a]
	
	if(is_undefined(ins))
		break
		
	if(ins.pressed)
	{
		ins_pressed = ins
		break
	}
	a++
}


var pos = start_sprite + (end_sprite-start_sprite) * list[|0].porcent_transfer / 100

if(V_H == "V")
	y = pos
else
	x = pos

Script_Scroll_parallel(ins_pressed,list)


var a = 0
while(true)
{
	var ins = list[|a]
	
	if(is_undefined(ins))
		break
		
	with(ins)
		Script_Scroll_callChildenMove(list)
			
	a++
}

