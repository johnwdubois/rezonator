/// @function utf8_write
/// @param    target
///     Target buffer to write to
/// @param    char
///     Unicode character to write
///
/// @description
///     Attempts to write an UTF-8 encoded character to the target buffer supplied.
///
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function utf8_write(argument0, argument1) {

	var buffer = argument0;
	var char   = argument1;

	var codepoint = ord(char);
	var info = utf8_codepoint_info(codepoint);

	if (info == undefined) {
	    exit;
	}

	var bytes = array_create(4);
	for (var i = info[UTF8.UnitSequenceSize] - 1; i >= 1; i--) {
	    bytes[i]  = UTF8.UNIT_VALUE_CONTINUATION | (codepoint & UTF8.UNIT_CODEPOINT_CONTINUATION);
	    codepoint = codepoint >> UTF8.SEQUENCE_SHIFT;
	}

	bytes[0] = info[UTF8.UnitValue] | (codepoint & info[UTF8.UnitCodepoint]);

	for (var i = 0; i < info[UTF8.UnitSequenceSize]; i++) {
	    buffer_write(buffer, buffer_u8, bytes[i]);
	}



}
