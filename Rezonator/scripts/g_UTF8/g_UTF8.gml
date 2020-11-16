/// @function g_UTF8
///
/// @description
///     Performs required global initializations for the UTF-8 module.
///
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function g_UTF8() {

	gml_pragma("global", "g_UTF8()");

	/*
	 *  This global array performs a mapping from the masks, to the values, to the types of each UTF-8 code unit
	 */
	global.UTF8UnitInfo = [
	    [
	        UTF8.UNIT_MASK_PREFIX_1,
	        UTF8.UNIT_VALUE_PREFIX_1,
	        UTF8.UNIT_CODEPOINT_PREFIX_1,
	        UTF8.UNIT_MINCODEPOINT_PREFIX_1,
	        UTF8.UNIT_MAXCODEPOINT_PREFIX_1,
	        UTF8.UNIT_SEQSIZE_PREFIX_1,
	        UTF8.UNIT_TYPE_PREFIX_1,
	    ],
	    [
	        UTF8.UNIT_MASK_PREFIX_2,
	        UTF8.UNIT_VALUE_PREFIX_2,
	        UTF8.UNIT_CODEPOINT_PREFIX_2,
	        UTF8.UNIT_MINCODEPOINT_PREFIX_2,
	        UTF8.UNIT_MAXCODEPOINT_PREFIX_2,
	        UTF8.UNIT_SEQSIZE_PREFIX_2,
	        UTF8.UNIT_TYPE_PREFIX_2,
	    ],
	    [
	        UTF8.UNIT_MASK_PREFIX_3,
	        UTF8.UNIT_VALUE_PREFIX_3,
	        UTF8.UNIT_CODEPOINT_PREFIX_3,
	        UTF8.UNIT_MINCODEPOINT_PREFIX_3,
	        UTF8.UNIT_MAXCODEPOINT_PREFIX_3,
	        UTF8.UNIT_SEQSIZE_PREFIX_3,
	        UTF8.UNIT_TYPE_PREFIX_3,
	    ],
	    [
	        UTF8.UNIT_MASK_PREFIX_4,
	        UTF8.UNIT_VALUE_PREFIX_4,
	        UTF8.UNIT_CODEPOINT_PREFIX_4,
	        UTF8.UNIT_MINCODEPOINT_PREFIX_4,
	        UTF8.UNIT_MAXCODEPOINT_PREFIX_4,
	        UTF8.UNIT_SEQSIZE_PREFIX_4,
	        UTF8.UNIT_TYPE_PREFIX_4,
	    ],
	    [
	        UTF8.UNIT_MASK_CONTINUATION,
	        UTF8.UNIT_VALUE_CONTINUATION,
	        UTF8.UNIT_CODEPOINT_CONTINUATION,
	        -1, -1,     // Continuation units do not have min and max codepoints since they don't start sequences
	        -1,         // You cannot know from a continuation unit how there are left in the current sequence
	        UTF8.UNIT_TYPE_CONTINUATION,
	    ],
	];

	global.UTF8UnitInfoLength = array_length_1d(global.UTF8UnitInfo);



}
