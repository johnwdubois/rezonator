/// @description Insert description here
// You can write your code in this editor


if (keyboard_check(vk_down)) 
{
	holdDown++;	
}
if(keyboard_check_released(vk_down)) 
{
	holdDown = 0;
}
if (keyboard_check(vk_up)) 
{
	holdUp++;	
}
if(keyboard_check_released(vk_up)) 
{
	holdUp = 0;
}