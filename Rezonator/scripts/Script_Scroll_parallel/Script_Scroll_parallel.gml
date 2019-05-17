
var ins_selected = argument0
var list = argument1

var ins_max = noone

var move_lenghtMAX = -1
var a = 0
while(true)
{	
	var ins = list[|a]
	
	if(is_undefined(ins))
		break
	
	var move_lenght = ins.move_lenght_mine
	if(move_lenght > move_lenghtMAX)
	{
		move_lenghtMAX = move_lenght
		ins_max = ins
	}
	
	a++
}


if(ins_selected != noone)
{
	
	ins_selected.move_lenght = move_lenghtMAX
	
	var a = 0
	while(true)
	{
		
		var ins = list[|a]
	
		if(is_undefined(ins))
			break
		
		ins.porcent = ins_selected.porcent
		ins.porcent_transfer = ins_selected.porcent_transfer
		ins.pixels = ins_selected.pixels
		ins.pixels_transfer = ins_selected.pixels_transfer

		a++	
	}
}