/// @description Insert description here
// You can write your code in this editor

if(room != room_first)
	room_goto(room_previous(room))
else
	room_goto(room_last)
