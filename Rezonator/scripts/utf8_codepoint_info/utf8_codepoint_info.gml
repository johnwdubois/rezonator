/// @function utf8_codepoint_info
/// @param    codepoint
///     The codepoint to retrieve the info from
/// @returns
///     One of global unit info arrays or undefined if invalid
///
/// @description
///     Retrieves the unit info of the UTF-8 code unit corresponding to the codepoint supplied, if valid.
/// 
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function utf8_codepoint_info(argument0) {

	var codepoint = argument0;

	for (var i = 0; i < global.UTF8UnitInfoLength; i++) {
	    var info = global.UTF8UnitInfo[i];
    
	    if (codepoint >= info[UTF8.UnitMinCodepoint] && codepoint <= info[UTF8.UnitMaxCodepoint]) {
	        return info;
	    }
	}

	return undefined;



}
