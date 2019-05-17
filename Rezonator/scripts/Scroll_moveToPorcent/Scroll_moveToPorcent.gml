/// @function Scroll_moveToPorcent(scroll,porcent)
/// @description 

/// @param {real} scroll
/// @param {real} porcent

var scroll = argument0

var goto = argument1

if(goto > 100)
	goto = 100

if(goto < 0)
	goto = 0

scroll.pixels = scroll.move_lenght*scroll.porcent/100
scroll.porcent = goto
