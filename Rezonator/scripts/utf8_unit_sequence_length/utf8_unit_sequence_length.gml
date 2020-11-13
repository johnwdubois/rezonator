/// @function utf8_unit_sequence_length
/// @param    unit
///     The unit to retrieve the sequence length from
/// @returns
///     The sequence length for the code unit supplied or -1 if invalid
///
/// @description
///     Retrieves the number of bytes in the sequence starting at the UTF-8 code unit supplied, if valid.
///
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function utf8_unit_sequence_length(argument0) {

	var unit = argument0;

	var info = utf8_unit_info(unit);
	if (info != undefined) {
	    return info[UTF8.UnitSequenceSize];
	}

	return -1;



}
