/// @function utf8_unit_info
/// @param    unit
///     The unit to retrieve the info from
/// @returns
///     One of global unit info arrays or undefined if invalid
///
/// @description
///     Retrieves the unit info of the UTF-8 code unit supplied, if valid.
///
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function utf8_unit_info(argument0) {

	var unit = argument0;

	for (var i = 0; i < global.UTF8UnitInfoLength; i++) {
	    var info = global.UTF8UnitInfo[i];
    
	    if ((unit & info[UTF8.UnitMask]) == info[UTF8.UnitValue]) {
	        return info;
	    }
	}

	return undefined;



}
