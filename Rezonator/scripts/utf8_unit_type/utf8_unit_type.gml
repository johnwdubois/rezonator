/// @function utf8_unit_type
/// @param    unit
///     The unit to retrieve the type from
/// @returns
///     One of the UTF8.UNIT_TYPE_* constants
///
/// @description
///     Checks which type of UTD-8 code unit was supplied, or if an invalid code unit was supplied.
///
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function utf8_unit_type(argument0) {

	var unit = argument0;

	var info = utf8_unit_info(unit);
	if (info != undefined) {
	    return info[UTF8.UnitType];
	}

	return UTF8.UNIT_TYPE_INVALID;



}
