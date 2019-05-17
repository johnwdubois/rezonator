/// @description Insert description here
// You can write your code in this editor

rot += A * cos(ang) 

var rot_ = rot
with(Obj_Scroll_Item_button)
	image_angle = rot_

ang += .08

if(ang > 2*pi)
	ang -= 2*pi
