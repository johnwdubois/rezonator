/// @description Insert description here
// You can write your code in this editor

var pos = start_sprite + (end_sprite-start_sprite) * owner.porcent_transfer / 100

if(V_H == "V")
	y = pos
else
	x = pos

with(owner)
	Script_Scroll_callChildenMove(list)

