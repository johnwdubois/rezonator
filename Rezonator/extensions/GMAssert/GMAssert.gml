#define __gma_assert_error__
/// @function __gma_assert_error__(message, expected, got)
/// @param message The message to display to the user
/// @param expected The value expected for the assertion
/// @param got The actual received value for the assertion
{
  var gtbp = asset_get_index("__GMA_TEST_BREAKPOINT__"),
      gbp = asset_get_index("__GMA_BREAKPOINT__");
  if (GMASSERT_ENABLED && ((gtbp != -1 && !script_execute(gtbp, argument0, argument2, argument1)) || (gbp != -1 && gtbp == -1 && !script_execute(gbp, argument0, argument2, argument1)) || gbp == -1)) {
    var msg = argument0 + chr(13)+chr(10) + chr(13)+chr(10) + "Expected: " + __gma_debug_value__(argument1) + chr(13)+chr(10) + chr(13)+chr(10) + "Got: " + __gma_debug_value__(argument2) + chr(13)+chr(10) + chr(13)+chr(10);
    if (os_browser == browser_not_a_browser) {
      show_error(msg, true);
    }
    else {
      show_message(msg);
    }
  }
}

#define __gma_assert_error_simple__
/// @function __gma_assert_error_simple__(message, got)
/// @param message The message to display to the user
/// @param got The actual received value for the assertion
{
  var gtbp = asset_get_index("__GMA_TEST_BREAKPOINT__"),
      gbp = asset_get_index("__GMA_BREAKPOINT__");
  if (GMASSERT_ENABLED && ((gtbp != -1 && !script_execute(gtbp, argument0, argument1, "")) || (gbp != -1 && gtbp == -1 && !script_execute(gbp, argument0, argument1, "")) || gbp == -1)) {
    var msg = argument0 + chr(13) + chr(13);
    if (os_browser == browser_not_a_browser) {
      show_error(msg, true);
    }
    else {
      show_message(msg);
    }
  }
}

#define __gma_assert_error_raw__
/// @function __gma_assert_error_raw__(message, expected, got)
/// @param message The message to display to the user
/// @param expected The value expected for the assertion
/// @param got The actual received value for the assertion
{
  var gtbp = asset_get_index("__GMA_TEST_BREAKPOINT__"),
      gbp = asset_get_index("__GMA_BREAKPOINT__");
  if (GMASSERT_ENABLED && ((gtbp != -1 && !script_execute(gtbp, argument0, argument2, argument1)) || (gbp != -1 && gtbp == -1 && !script_execute(gbp, argument0, argument2, argument1)) || gbp == -1)) {
    var msg = argument0 + chr(13) + chr(13) + "Expected: " + argument1 + chr(13) + chr(13) + "Got: " + argument2 + chr(13) + chr(13);
    if (os_browser == browser_not_a_browser) {
      show_error(msg, true);
    }
    else {
      show_message(msg);
    }
  }
}

#define __gma_debug_value__
/// @function __gma_debug_value__(val, [noprefix])
/// @param val The value to derive a debug-friendly value from
/// @param [noprefix] Whether to skip the "(type)" header (defaults to false)
{
  var type = typeof(argument[0]);
  var dv;
  switch (type) {
    case "number":
      //Return integers as-is
      if (frac(argument[0]) == 0) {
        dv = string(argument[0]);
      }
      //Get mantissa and exponent
      else {
        var mantissa, exponent;
        exponent = floor(log10(abs(argument[0])));
        mantissa = string_replace_all(string_format(argument[0]/power(10,exponent), 15, 14), " ", "");
        //Trim trailing zeros off mantissa
        var i, ca;
        i = string_length(mantissa);
        do {
          ca = string_char_at(mantissa, i);
          i -= 1;
        } until (ca != "0")
        if (ca != ".") {
          mantissa = string_copy(mantissa, 1, i+1);
        }
        else {
          mantissa = string_copy(mantissa, 1, i);
        }
        //Add exponent except if it is zero
        if (exponent != 0) {
          dv = mantissa + "e" + string(exponent);
        }
        else {
          dv = mantissa;
        }
      }
    break;
    case "string":
      dv = "\"" + string_replace_all(argument[0], "\"", "\"\"") + "\"";
    break;
    case "array":
      var size;
      var result = "",
          arr = argument[0],
          height = array_height_2d(arr);
      //1D
      if (height == 1) {
        size = array_length_1d(arr)
        for (var i = 0; i < size; i++) {
          result += __gma_debug_value__(arr[i], true);
          if (i < size-1) {
            result += ", ";
          }
        }
      }
      //2D
      else {
        for (var i = 0; i < height; i++) {
          size = array_length_2d(arr, i);
          for (var j = 0; j < size; j++) {
            result += __gma_debug_value__(arr[i, j], true);
            if (j < size-1) {
              result += ", ";
            }
          }
          if (i < height-1) {
            result += "; ";
          }
        }
      }
      dv = "[" + result + "]";
    break;
    case "bool":
      if (argument[0]) {
        dv = "true";
      } else {
        dv = "false";
      }
    break;
    case "int32":
    case "int64":
    case "ptr":
      dv = string(argument[0]);
    break;
    case "undefined":
    case "null":
    case "unknown":
      dv = "";
    break;
    case "vec3":
      dv = string(argument[0]);
    break;
    case "vec4":
      dv = string(argument[0]);
    break;
  }
  if (argument_count > 1 && argument[1]) {
    return dv;
  }
  return "(" + type + ")" + chr(13)+chr(10) + dv;
}

#define __gma_debug_list_value__
/// @function __gma_debug_list_value__(val)
/// @param val The value to derive a debug-friendly value from
{
  //Return list(<INVALID>) if it does not exist
  if (!ds_exists(argument0, ds_type_list)) {
    return "list(<INVALID>)";
  }
  //Return list(entry1, entry2, ..., entry n) if it exists
  var content = "",
      siz = ds_list_size(argument0);
  for (var i = 0; i < siz; i++) {
    content += __gma_debug_value__(argument0[| i], true);
    if (i < siz-1) {
      content += ", ";
    }
  }
  return "list(" + content + ")";
}

#define __gma_equal__
/// @function __gma_equal__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "array":
        var a1d = array_height_2d(argument0) == 1,
            b1d = array_height_2d(argument1) == 1;
        if (a1d != b1d) return false;
        if (a1d) {
          var size = array_length_1d(argument0);
          if (size != array_length_1d(argument1)) return false;
          for (var i = 0; i < size; i++) {
            if (!__gma_equal__(argument0[@ i], argument1[@ i])) return false;
          }
        }
        else {
          var size_i = array_height_2d(argument0);
          if (size_i != array_height_2d(argument1)) return false;
          var size_j;
          for (var i = 0; i < size_i; i++) {
            size_j = array_length_2d(argument0, i);
            if (size_j != array_length_2d(argument1, i)) return false;
            for (var j = 0; j < size_j; j++) {
              if (!__gma_equal__(argument0[@ i, j], argument1[@ i, j])) return false;
            }
          }
        }
        return true;
      break;
      default:
        return argument0 == argument1;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_equalish__
/// @function __gma_equalish__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "array":
        var a1d = array_height_2d(argument0) == 1,
            b1d = array_height_2d(argument1) == 1;
        if (a1d != b1d) return false;
        if (a1d) {
          var size = array_length_1d(argument0);
          if (size != array_length_1d(argument1)) return false;
          for (var i = 0; i < size; i++) {
            if (!__gma_equalish__(argument0[@ i], argument1[@ i])) return false;
          }
        }
        else {
          var size_i = array_height_2d(argument0);
          if (size_i != array_height_2d(argument1)) return false;
          var size_j;
          for (var i = 0; i < size_i; i++) {
            size_j = array_length_2d(argument0, i);
            if (size_j != array_length_2d(argument1, i)) return false;
            for (var j = 0; j < size_j; j++) {
              if (!__gma_equalish__(argument0[@ i, j], argument1[@ i, j])) return false;
            }
          }
        }
        return true;
      break;
      case "number":
        return argument0 == argument1 || abs(argument0-argument1) <= GMASSERT_TOLERANCE;
      break;
      default:
        return argument0 == argument1;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_greater_than__
/// @function __gma_greater_than__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "number":
        return argument0 > argument1;
      break;
      case "string":
        if (argument0 == argument1) return false;
        var len0 = string_length(argument0),
            len1 = string_length(argument1),
            len = min(len0, len1);
        var c0, c1;
        for (var i = 1; i <= len; i++) {
          c0 = ord(string_char_at(argument0, i));
          c1 = ord(string_char_at(argument1, i));
          if (c0 != c1) {
            return c0 > c1;
          }
        }
        return len0 > len1;
      break;
      case "array":
        var a1d = array_height_2d(argument0) == 1,
            b1d = array_height_2d(argument1) == 1;
        if (a1d != b1d) return false;
        if (a1d) {
          var size = array_length_1d(argument0);
          if (size != array_length_1d(argument1)) return false;
          for (var i = 0; i < size; i++) {
            if (!__gma_greater_than__(argument0[@ i], argument1[@ i])) return false;
          }
        }
        else {
          var size_i = array_height_2d(argument0);
          if (size_i != array_height_2d(argument1)) return false;
          var size_j;
          for (var i = 0; i < size_i; i++) {
            size_j = array_length_2d(argument0, i);
            if (size_j != array_length_2d(argument1, i)) return false;
            for (var j = 0; j < size_j; j++) {
              if (!__gma_greater_than__(argument0[@ i, j], argument1[@ i, j])) return false;
            }
          }
        }
        return true;
      break;
      default:
        return false;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_less_than__
/// @function __gma_less_than__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "number":
        return argument0 < argument1;
      break;
      case "string":
        if (argument0 == argument1) return false;
        var len0 = string_length(argument0),
            len1 = string_length(argument1),
            len = min(len0, len1);
        var c0, c1;
        for (var i = 1; i <= len; i++) {
          c0 = ord(string_char_at(argument0, i));
          c1 = ord(string_char_at(argument1, i));
          if (c0 != c1) {
            return c0 < c1;
          }
        }
        return len0 < len1;
      break;
      case "array":
        var a1d = array_height_2d(argument0) == 1,
            b1d = array_height_2d(argument1) == 1;
        if (a1d != b1d) return false;
        if (a1d) {
          var size = array_length_1d(argument0);
          if (size != array_length_1d(argument1)) return false;
          for (var i = 0; i < size; i++) {
            if (!__gma_less_than__(argument0[@ i], argument1[@ i])) return false;
          }
        }
        else {
          var size_i = array_height_2d(argument0);
          if (size_i != array_height_2d(argument1)) return false;
          var size_j;
          for (var i = 0; i < size_i; i++) {
            size_j = array_length_2d(argument0, i);
            if (size_j != array_length_2d(argument1, i)) return false;
            for (var j = 0; j < size_j; j++) {
              if (!__gma_less_than__(argument0[@ i, j], argument1[@ i, j])) return false;
            }
          }
        }
        return true;
      break;
      default:
        return false;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_greater_than_or_equal__
/// @function __gma_greater_than_or_equal__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "number":
        return argument0 >= argument1;
      break;
      case "string":
        if (argument0 == argument1) return true;
        var len0 = string_length(argument0),
            len1 = string_length(argument1),
            len = min(len0, len1);
        var c0, c1;
        for (var i = 1; i <= len; i++) {
          c0 = ord(string_char_at(argument0, i));
          c1 = ord(string_char_at(argument1, i));
          if (c0 != c1) {
            return c0 > c1;
          }
        }
        return len0 > len1;
      break;
      case "array":
        var a1d = array_height_2d(argument0) == 1,
            b1d = array_height_2d(argument1) == 1;
        if (a1d != b1d) return false;
        if (a1d) {
          var size = array_length_1d(argument0);
          if (size != array_length_1d(argument1)) return false;
          for (var i = 0; i < size; i++) {
            if (!__gma_greater_than_or_equal__(argument0[@ i], argument1[@ i])) return false;
          }
        }
        else {
          var size_i = array_height_2d(argument0);
          if (size_i != array_height_2d(argument1)) return false;
          var size_j;
          for (var i = 0; i < size_i; i++) {
            size_j = array_length_2d(argument0, i);
            if (size_j != array_length_2d(argument1, i)) return false;
            for (var j = 0; j < size_j; j++) {
              if (!__gma_greater_than_or_equal__(argument0[@ i, j], argument1[@ i, j])) return false;
            }
          }
        }
        return true;
      break;
      default:
        return false;
      break;
    }
  }
  else {
    return false;
  }
}

#define __gma_less_than_or_equal__
/// @function __gma_less_than_or_equal__(got, expected)
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
{
  var type = typeof(argument0);
  if (type == typeof(argument1)) {
    switch (type) {
      case "number":
        return argument0 <= argument1;
      break;
      case "string":
        if (argument0 == argument1) return true;
        var len0 = string_length(argument0),
            len1 = string_length(argument1),
            len = min(len0, len1);
        var c0, c1;
        for (var i = 1; i <= len; i++) {
          c0 = ord(string_char_at(argument0, i));
          c1 = ord(string_char_at(argument1, i));
          if (c0 != c1) {
            return c0 < c1;
          }
        }
        return len0 < len1;
      break;
      case "array":
        var a1d = array_height_2d(argument0) == 1,
            b1d = array_height_2d(argument1) == 1;
        if (a1d != b1d) return false;
        if (a1d) {
          var size = array_length_1d(argument0);
          if (size != array_length_1d(argument1)) return false;
          for (var i = 0; i < size; i++) {
            if (!__gma_less_than_or_equal__(argument0[@ i], argument1[@ i])) return false;
          }
        }
        else {
          var size_i = array_height_2d(argument0);
          if (size_i != array_height_2d(argument1)) return false;
          var size_j;
          for (var i = 0; i < size_i; i++) {
            size_j = array_length_2d(argument0, i);
            if (size_j != array_length_2d(argument1, i)) return false;
            for (var j = 0; j < size_j; j++) {
              if (!__gma_less_than_or_equal__(argument0[@ i, j], argument1[@ i, j])) return false;
            }
          }
        }
        return true;
      break;
      default:
        return false;
      break;
    }
  }
  else {
    return false;
  }
}

#define assert
/// @function assert(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is true.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!argument[0]) {
    __gma_assert_error_simple__(msg, argument[0]);
  }
}

#define assert_fail
/// @function assert_fail(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is false.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Assertion didn't fail!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (argument[0]) {
    __gma_assert_error_simple__(msg, argument[0]);
  }
}

#define assert_operation
/// @function assert_operation(got, expected, op, invert, [msg], [debug_got], [debug_expected])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param op A script taking the gotten value and the expected as arguments and returning true/false
/// @param invert Whether to invert the result returned by op
/// @param [msg] (optional)
/// @param [debug_got] (optional)
/// @param [debug_expected] (optional)
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg = "Assertion Failed!",
      debug_got = undefined,
      debug_expected = undefined;
  switch (argument_count) {
    case 7:
      debug_expected = argument[6];
    case 6:
      debug_got = argument[5];
    case 5:
      msg = argument[4];
    case 4:
    break;
    default:
      show_error("Expected 4-7 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!(argument[3] ^^ script_execute(argument[2], argument[0], argument[1]))) {
    //
    var debug_value_expected, debug_value_got;
    if (is_undefined(debug_expected)) {
      debug_value_expected = __gma_debug_value__(argument[1]);
    } else if (is_string(debug_expected)) {
      debug_value_expected = debug_expected;
    } else {
      debug_value_expected = script_execute(debug_expected, argument[1])
    }
    if (is_undefined(debug_got)) {
      debug_value_got = __gma_debug_value__(argument[0]);
    } else {
      debug_value_got = script_execute(debug_got, argument[0]);
    }
    __gma_assert_error_raw__(msg, debug_value_expected, debug_value_got);
  }
}

#define assert_equal
/// @function assert_equal(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_equal__(argument[0], argument[1])) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_equalish
/// @function assert_equalish(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is approximately equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Equalish assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_equalish__(argument[0], argument[1])) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_is
/// @function assert_is(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is exactly equal to the expected expression (as compared using ==).
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (typeof(argument[0]) != typeof(argument[1]) || argument[0] != argument[1]) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_not_equal
/// @function assert_not_equal(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Not equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (__gma_equal__(argument[0], argument[1])) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_not_equalish
/// @function assert_not_equalish(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not approximately equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Not equalish assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (__gma_equalish__(argument[0], argument[1])) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_isnt
/// @function assert_isnt(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not exactly equal to the expected expression (as compared using ==).
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Not equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (typeof(argument[0]) == typeof(argument[1]) && argument[0] == argument[1]) {
    __gma_assert_error__(msg, argument[1], argument[0]);
  }
}

#define assert_greater_than
/// @function assert_greater_than(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is greater than the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Greater than assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_greater_than__(argument[0], argument[1])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value greater than " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that comes after " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all greater than " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error__(msg + " (unsupported type)", argument[1], argument[0]);
      break;
    }
  }
}

#define assert_less_than
/// @function assert_less_than(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is less than the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Less than assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_less_than__(argument[0], argument[1])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value less than " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that comes before " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all less than " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error__(msg + " (unsupported type)", argument[1], argument[0]);
      break;
    }
  }
}

#define assert_greater_than_or_equal
/// @function assert_greater_than_or_equal(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is greater than or equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Greater than or equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_greater_than_or_equal__(argument[0], argument[1])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value greater than or equal to " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that comes after or is " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all greater than or equal to " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error__(msg + " (unsupported type)", argument[1], argument[0]);
      break;
    }
  }
}

#define assert_less_than_or_equal
/// @function assert_less_than_or_equal(got, expected, [msg])
/// @param got The actual received value for the assertion
/// @param expected The value expected for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is less than or equal to the expected expression.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Less than or equal assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!__gma_less_than_or_equal__(argument[0], argument[1])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value less than or equal to " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that comes before or is " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all less than or equal " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error__(msg + " (unsupported type)", argument[1], argument[0]);
      break;
    }
  }
}

#define assert_is_string
/// @function assert_is_string(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is a string.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "String type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_string(argument[0])) {
    __gma_assert_error_raw__(msg, "Any string", __gma_debug_value__(argument[0]));
  }
}

#define assert_is_real
/// @function assert_is_real(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is a real number.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Real type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_real(argument[0])) {
    __gma_assert_error_raw__(msg, "Any real value", __gma_debug_value__(argument[0]));
  }
}

#define assert_is_array
/// @function assert_is_array(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is an array.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Array type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_array(argument[0])) {
    __gma_assert_error_raw__(msg, "Any array", __gma_debug_value__(argument[0]));
  }
}

#define assert_is_defined
/// @function assert_is_defined(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not undefined.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Defined type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_undefined(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but undefined", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_string
/// @function assert_isnt_string(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not a string.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Non-string type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_string(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but a string", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_real
/// @function assert_isnt_real(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not a real number.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Non-real type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_real(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but a real value", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_array
/// @function assert_isnt_array(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not an array.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Non-array type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (is_array(argument[0])) {
    __gma_assert_error_raw__(msg, "Anything but an array", __gma_debug_value__(argument[0]));
  }
}

#define assert_isnt_defined
/// @function assert_isnt_defined(got, [msg])
/// @param got The actual received value for the assertion
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is undefined.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 1:
      msg = "Undefined type assertion failed!";
    break;
    case 2:
      msg = argument[1];
    break;
    default:
      show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check assertion
  if (!is_undefined(argument[0])) {
    __gma_assert_error_raw__(msg, "undefined", __gma_debug_value__(argument[0]));
  }
}

#define assert_in_range
/// @function assert_in_range(got, lower, upper, [msg])
/// @param got The actual received value for the assertion
/// @param lower The lower bound of the range (inclusive)
/// @param upper The upper bound of the range (inclusive)
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is within the inclusive range between lower and upper.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 3:
      msg = "In-range assertion failed!";
    break;
    case 4:
      msg = argument[3];
    break;
    default:
      show_error("Expected 3 or 4 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types
  switch (typeof(argument[1])) {
    case "number":
    case "string":
    case "array":
    break;
    default:
      msg += " (invalid lower bound type)";
        __gma_assert_error_raw__(msg, "A real value, string or array", __gma_debug_value__(argument[1]));
    exit;
  }
  if (typeof(argument[1]) != typeof(argument[2])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error__(msg + " (mismatched range types)", "A real value for the upper bound", __gma_debug_value__(argument[2]));
      break;
      case "string":
        __gma_assert_error__(msg + " (mismatched range types)", "A string for the upper bound", __gma_debug_value__(argument[2]));
      break;
      case "array":
        __gma_assert_error__(msg + " (mismatched range types)", "An array for the upper bound", __gma_debug_value__(argument[2]));
      break;
      default:
        msg += " (invalid lower bound type)";
        __gma_assert_error_raw__(msg, "A real value, string or array", __gma_debug_value__(argument[1]));
      break;
    }
    exit;
  }
  //Check assertion
  if (!(__gma_less_than_or_equal__(argument[0], argument[2]) && __gma_less_than_or_equal__(argument[1], argument[0]))) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that lies between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error_raw__(msg + " (unsupported type)", "A value comparable to " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
    }
  }
}

#define assert_not_in_range
/// @function assert_not_in_range(got, lower, upper, [msg])
/// @param got The actual received value for the assertion
/// @param lower The lower bound of the range (inclusive)
/// @param upper The upper bound of the range (inclusive)
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten expression is not within the inclusive range between lower and upper.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 3:
      msg = "Out-of-range assertion failed!";
    break;
    case 4:
      msg = argument[3];
    break;
    default:
      show_error("Expected 3 or 4 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types
  switch (typeof(argument[1])) {
    case "number":
    case "string":
    case "array":
    break;
    default:
      msg += " (invalid lower bound type)";
        __gma_assert_error_raw__(msg, "A real value, string or array", __gma_debug_value__(argument[1]));
    exit;
  }
  if (typeof(argument[1]) != typeof(argument[2])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error__(msg + " (mismatched range types)", "A real value for the upper bound", __gma_debug_value__(argument[2]));
      break;
      case "string":
        __gma_assert_error__(msg + " (mismatched range types)", "A string for the upper bound", __gma_debug_value__(argument[2]));
      break;
      case "array":
        __gma_assert_error__(msg + " (mismatched range types)", "An array for the upper bound", __gma_debug_value__(argument[2]));
      break;
      default:
        msg += " (invalid lower bound type)";
        __gma_assert_error_raw__(msg, "A real value, string or array", __gma_debug_value__(argument[1]));
      break;
    }
    exit;
  }
  //Check assertion
  if (__gma_less_than_or_equal__(argument[0], argument[2]) && __gma_less_than_or_equal__(argument[1], argument[0])) {
    switch (typeof(argument[1])) {
      case "number":
        __gma_assert_error_raw__(msg, "A real value not between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      case "string":
        __gma_assert_error_raw__(msg, "A string that does not lie between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      case "array":
        __gma_assert_error_raw__(msg, "An array with pairwise values all not between " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
      default:
        __gma_assert_error_raw__(msg + " (unsupported type)", "A value comparable to " + __gma_debug_value__(argument[1]) + " and " + __gma_debug_value__(argument[2]), __gma_debug_value__(argument[0]));
      break;
    }
  }
}

#define assert_contains
/// @function assert_contains(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten string, list or array contains a value equal to content.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Inclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "string":
      if (typeof(argument[1]) == "string") {
        if (string_pos(argument[1], argument[0]) == 0) {
          __gma_assert_error_raw__(msg, "A string that contains " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
        }
      }
      else {
        msg += " (invalid content type)";
        __gma_assert_error_raw__(msg, "A string", __gma_debug_value__(argument[1]));
      }
    break;
    case "array":
      var arr = argument[0];
      if (array_height_2d(arr) == 1 || array_length_2d(arr, 1) == 0) {
        var size = array_length_1d(arr);
        for (var i = 0; i < size; i++) {
          if (__gma_equal__(argument[1], arr[i])) {
            found = true;
            break;
          }
        }
      }
      else {
        var size_i = array_height_2d(arr);
        for (var i = 0; i < size_i && !found; i++) {
          var size_j = array_length_2d(arr, i);
          for (var j = 0; j < size_j; j++) {
            if (__gma_equal__(argument[1], arr[i, j])) {
              found = true;
              break;
            }
          }
        }
      }
      if (!found) {
        __gma_assert_error_raw__(msg, "An array that contains " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number":
      if (ds_exists(argument[0], ds_type_list)) {
        var list = argument[0],
            size = ds_list_size(list);
        for (var i = 0; i < size; i++) {
          if (__gma_equal__(argument[1], list[| i])) {
            found = true;
            break;
          }
        }
        if (!found) {
          __gma_assert_error_raw__(msg, "A list that contains " + __gma_debug_value__(argument[1]), __gma_debug_list_value__(argument[0]));
        }
      }
      else {
        msg += " (list ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent list ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
        __gma_assert_error_raw__(msg, "A string, array or list", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_contains_exact
/// @function assert_contains_exact(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten string, list or array contains a value exactly equal to content (as compared using ==).
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Exact inclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "string":
      if (typeof(argument[1]) == "string") {
        if (string_pos(argument[1], argument[0]) == 0) {
          __gma_assert_error_raw__(msg, "A string that contains exactly " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
        }
      }
      else {
        msg += " (invalid content type)";
        __gma_assert_error_raw__(msg, "A string", __gma_debug_value__(argument[1]));
      }
    break;
    case "array":
      var arr = argument[0];
      if (array_height_2d(arr) == 1 || array_length_2d(arr, 1) == 0) {
        var size = array_length_1d(arr);
        for (var i = 0; i < size; i++) {
          if (typeof(argument[1]) == typeof(arr[i]) && argument[1] == arr[i]) {
            found = true;
            break;
          }
        }
      }
      else {
        var size_i = array_height_2d(arr);
        for (var i = 0; i < size_i && !found; i++) {
          var size_j = array_length_2d(arr, i);
          for (var j = 0; j < size_j; j++) {
            if (typeof(argument[1]) == typeof(arr[i, j]) && argument[1] == arr[i, j]) {
              found = true;
              break;
            }
          }
        }
      }
      if (!found) {
        __gma_assert_error_raw__(msg, "An array that contains exactly " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number":
      if (ds_exists(argument[0], ds_type_list)) {
        var list = argument[0],
            size = ds_list_size(list);
        for (var i = 0; i < size; i++) {
          if (typeof(argument[1]) == typeof(list[| i]) && argument[1] == list[| i]) {
            found = true;
            break;
          }
        }
        if (!found) {
          __gma_assert_error_raw__(msg, "A list that contains exactly " + __gma_debug_value__(argument[1]), __gma_debug_list_value__(argument[0]));
        }
      }
      else {
        msg += " (list ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent list ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
        __gma_assert_error_raw__(msg, "A string, array or list", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_doesnt_contain
/// @function assert_doesnt_contain(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten string, list or array does not contain a value equal to content.
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Exclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "string":
      if (typeof(argument[1]) == "string") {
        if (string_pos(argument[1], argument[0]) > 0) {
          __gma_assert_error_raw__(msg, "A string that does not contain " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
        }
      }
      else {
        msg += " (invalid content type)";
        __gma_assert_error_raw__(msg, "A string", __gma_debug_value__(argument[1]));
      }
    break;
    case "array":
      var arr = argument[0];
      if (array_height_2d(arr) == 1 || array_length_2d(arr, 1) == 0) {
        var size = array_length_1d(arr);
        for (var i = 0; i < size; i++) {
          if (__gma_equal__(argument[1], arr[i])) {
            found = true;
            break;
          }
        }
      }
      else {
        var size_i = array_height_2d(arr);
        for (var i = 0; i < size_i && !found; i++) {
          var size_j = array_length_2d(arr, i);
          for (var j = 0; j < size_j; j++) {
            if (__gma_equal__(argument[1], arr[i, j])) {
              found = true;
              break;
            }
          }
        }
      }
      if (found) {
        __gma_assert_error_raw__(msg, "An array that does not contain " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number":
      if (ds_exists(argument[0], ds_type_list)) {
        var list = argument[0],
            size = ds_list_size(list);
        for (var i = 0; i < size; i++) {
          if (__gma_equal__(argument[1], list[| i])) {
            found = true;
            break;
          }
        }
        if (found) {
          __gma_assert_error_raw__(msg, "A list that does not contain " + __gma_debug_value__(argument[1]), __gma_debug_list_value__(argument[0]));
        }
      }
      else {
        msg += " (list ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent list ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
        __gma_assert_error_raw__(msg, "A string, array or list", __gma_debug_value__(argument[0]));
    break;
  }
}

#define assert_doesnt_contain_exact
/// @function assert_doesnt_contain_exact(got, content, [msg]);
/// @param got The actual received value for the assertion
/// @param content A value to look for in the received value
/// @param [msg] (optional) A custom message to display when the assertion fails
/// @description Assert that the gotten string, list or array does not contain a value exactly equal to content (as compared using ==).
{
  if (!GMASSERT_ENABLED) exit;
  //Capture message argument
  var msg;
  switch (argument_count) {
    case 2:
      msg = "Exact exclusion assertion failed!";
    break;
    case 3:
      msg = argument[2];
    break;
    default:
      show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  //Check types and assertion
  var found = false;
  switch (typeof(argument[0])) {
    case "string":
      if (typeof(argument[1]) == "string") {
        if (string_pos(argument[1], argument[0]) > 0) {
          __gma_assert_error_raw__(msg, "A string that does not contain exactly " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
        }
      }
      else {
        msg += " (invalid content type)";
        __gma_assert_error_raw__(msg, "A string", __gma_debug_value__(argument[1]));
      }
    break;
    case "array":
      var arr = argument[0];
      if (array_height_2d(arr) == 1 || array_length_2d(arr, 1) == 0) {
        var size = array_length_1d(arr);
        for (var i = 0; i < size; i++) {
          if (typeof(argument[1]) == typeof(arr[i]) && argument[1] == arr[i]) {
            found = true;
            break;
          }
        }
      }
      else {
        var size_i = array_height_2d(arr);
        for (var i = 0; i < size_i && !found; i++) {
          var size_j = array_length_2d(arr, i);
          for (var j = 0; j < size_j; j++) {
            if (typeof(argument[1]) == typeof(arr[i, j]) && argument[1] == arr[i, j]) {
              found = true;
              break;
            }
          }
        }
      }
      if (found) {
        __gma_assert_error_raw__(msg, "An array that eoes not contain exactly " + __gma_debug_value__(argument[1]), __gma_debug_value__(argument[0]));
      }
    break;
    case "number":
      if (ds_exists(argument[0], ds_type_list)) {
        var list = argument[0],
            size = ds_list_size(list);
        for (var i = 0; i < size; i++) {
          if (typeof(argument[1]) == typeof(list[| i]) && argument[1] == list[| i]) {
            found = true;
            break;
          }
        }
        if (found) {
          __gma_assert_error_raw__(msg, "A list that does not contain exactly " + __gma_debug_value__(argument[1]), __gma_debug_list_value__(argument[0]));
        }
      }
      else {
        msg += " (list ID does not exist)";
        __gma_assert_error_raw__(msg, "An existent list ID", __gma_debug_value__(argument[0]));
      }
    break;
    default:
      msg += " (invalid container type)";
        __gma_assert_error_raw__(msg, "A string, array or list", __gma_debug_value__(argument[0]));
    break;
  }
}
