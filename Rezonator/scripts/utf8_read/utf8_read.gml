/// @function utf8_read
/// @param    source
///     Source buffer to read from
/// @returns
///     The UTF-8 character read or "" on error
///
/// @description
///     Attempts to read an UTF-8 encoded character from the source buffer supplied.
/// 
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function utf8_read(argument0) {

	var buffer = argument0;

	var prefix = buffer_read(buffer, buffer_u8);
	var info   = utf8_unit_info(prefix);

	if (info == undefined || info[UTF8.UnitType] == UTF8.UNIT_TYPE_CONTINUATION) {
	    return "";
	}

	var codepoint = prefix & info[UTF8.UnitCodepoint];
	for (var i = 1; i < info[UTF8.UnitSequenceSize]; i++) {
	    var continuation = buffer_read(buffer, buffer_u8);
    
	    var cInfo = utf8_unit_info(continuation);
	    if (cInfo[UTF8.UnitType] != UTF8.UNIT_TYPE_CONTINUATION) {
	        return "";
	    }
    
	    codepoint = (codepoint << UTF8.SEQUENCE_SHIFT) | (continuation & cInfo[UTF8.UnitCodepoint]);
	}

	return chr(codepoint);



}
