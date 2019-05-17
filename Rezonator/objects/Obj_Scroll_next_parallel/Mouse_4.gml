/// @description Insert description here
// You can write your code in this editor

var owner = list[|0]

var nextPos = Scroll_getPos(owner) + Scroll_getStep(owner)

Scroll_moveToPixels(owner,nextPos)

Script_Scroll_parallel(owner,list)
