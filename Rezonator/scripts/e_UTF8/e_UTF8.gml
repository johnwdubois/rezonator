/// @function e_UTF8
///
/// @description
///     Declares the UTF8 enum that specified some important constants when handilng UTF-8 encoded strings.
///
/// Author: Rui Rosário
/// Source: https://marketplace.yoyogames.com/assets/5650/utf-8

function e_UTF8() {

	enum UTF8 {
	    // Number of bits to shift when glueing UTD-8 code units in a sequence
	    SEQUENCE_SHIFT = 6,

	    // Different bitmasks for the UTF-8 code units
	    UNIT_MASK_PREFIX_1     = $80,
	    UNIT_MASK_PREFIX_2     = $e0,
	    UNIT_MASK_PREFIX_3     = $f0,
	    UNIT_MASK_PREFIX_4     = $fe,
	    UNIT_MASK_CONTINUATION = $c0,
    
	    // Different values for the UTF-8 code units
	    UNIT_VALUE_PREFIX_1     = $00,
	    UNIT_VALUE_PREFIX_2     = $c0,
	    UNIT_VALUE_PREFIX_3     = $e0,
	    UNIT_VALUE_PREFIX_4     = $f0,
	    UNIT_VALUE_CONTINUATION = $80,
    
	    // Different codepoint bitmasks for the UTF-8 code units
	    UNIT_CODEPOINT_PREFIX_1     = $7f,
	    UNIT_CODEPOINT_PREFIX_2     = $1f,
	    UNIT_CODEPOINT_PREFIX_3     = $0f,
	    UNIT_CODEPOINT_PREFIX_4     = $03,
	    UNIT_CODEPOINT_CONTINUATION = $3f,
    
	    // Minimum Unicode codepoints for the UTF-8 code units
	    UNIT_MINCODEPOINT_PREFIX_1 = $000000,
	    UNIT_MINCODEPOINT_PREFIX_2 = $000080,
	    UNIT_MINCODEPOINT_PREFIX_3 = $000800,
	    UNIT_MINCODEPOINT_PREFIX_4 = $010000,
    
	    // Minimum Unicode codepoints for the UTF-8 code units
	    UNIT_MAXCODEPOINT_PREFIX_1 = $00007f,
	    UNIT_MAXCODEPOINT_PREFIX_2 = $0007ff,
	    UNIT_MAXCODEPOINT_PREFIX_3 = $00ffff,
	    UNIT_MAXCODEPOINT_PREFIX_4 = $10ffff,
    
	    // Different sequence sizes for the UTF-8 code units
	    UNIT_SEQSIZE_PREFIX_1 = 1,
	    UNIT_SEQSIZE_PREFIX_2 = 2,
	    UNIT_SEQSIZE_PREFIX_3 = 3,
	    UNIT_SEQSIZE_PREFIX_4 = 4,
    
	    // Different types of UTF-8 code units
	    UNIT_TYPE_PREFIX_1,
	    UNIT_TYPE_PREFIX_2,
	    UNIT_TYPE_PREFIX_3,
	    UNIT_TYPE_PREFIX_4,
	    UNIT_TYPE_CONTINUATION,
	    UNIT_TYPE_INVALID,
    
	    // Accessor indexes for the global UTF-8 code units array
	    UnitMask = 0,
	    UnitValue,
	    UnitCodepoint,
	    UnitMinCodepoint,
	    UnitMaxCodepoint,
	    UnitSequenceSize,
	    UnitType,
	};



}
