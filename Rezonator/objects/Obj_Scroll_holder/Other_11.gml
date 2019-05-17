/// @description Insert description here
// You can write your code in this editor

going = true

if(owner)
{
	if(owner.V_H == "V")
	{
		x = owner.x
		go = Ystart - owner.pixels_transfer
	}
	else
	{
		go = Xstart - owner.pixels_transfer
		y = owner.y
	}
}

if(master)
{
	Xdraw = x-master.x
	Ydraw = y-master.y
}

Script_Scroll_callChildenMove(list)