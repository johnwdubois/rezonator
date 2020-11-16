/// @function utf8_unit_codepoint
/// @param    unit
///     The unit to retrieve the codepoint from
/// @returns
///     The codepoint value or -1 if an invalid unit is supplied
///
/// @description
///     Retrieves the codepoint of the UTF-8 code unit supplied, if valid.
///
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function utf8_unit_codepoint(argument0) {

	var unit = argument0;

	var info = utf8_unit_info(unit);
	if (info != undefined) {
	    return unit & info[UTF8.UnitCodepoint];
	}

	return -1;



}
