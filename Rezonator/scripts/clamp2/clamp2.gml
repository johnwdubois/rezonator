/// @description  clamp2(val, min, max)
/// @function  clamp2
/// @param val
/// @param  min
/// @param  max
// Like GM's clamp(), but if max is smaller than min, 0 is returned.

if (argument2 < argument1) return 0;
return clamp(argument0, argument1, argument2);
