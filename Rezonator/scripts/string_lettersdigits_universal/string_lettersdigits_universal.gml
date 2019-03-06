/// @description  string_lettersdigits_universal(str)
/// @function  string_lettersdigits_universal
/// @param str
// Like string_lettersdigits, but recognizes non-american letters as well. Returns string.

var last_index = string_length(argument0), result = "", i, t;
for (i = 1; i <= last_index; ++i) {
    t = ord(string_char_at(argument0, i));
    if ((t >= 48 && t <= 57) || (t >= 65 && t <= 90) || (t >= 97 && t <= 122) || t == 181 || (t >= 192 && t <= 214) || (t >= 216 && t <= 246) || (t >= 248 && t <= 255))
        result += string_char_at(argument0, i);
}

return result;
