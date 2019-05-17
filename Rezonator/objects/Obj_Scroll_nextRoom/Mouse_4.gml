/// @description Insert description here
// You can write your code in this editor

if(room != room_last)
	room_goto(room_next(room))
else
	room_goto(room_first)
