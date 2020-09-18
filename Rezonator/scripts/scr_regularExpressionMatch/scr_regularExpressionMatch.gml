/// @description  regular_expression_match(compiled regular expression, input string)
/// @param compiled regular expression
/// @param  input string
function scr_regularExpressionMatch(argument0, argument1) {
	// Returns true if the input string follows the compiled regular expression.
	// compiled regular expression: A compiled regular expression returned from regular_expression_create.
	// input string: A string to check against the regular expression.

	var stack_nodes_current, stack_nodes_next, stack_nodes_current_index, stack_nodes_next_index, char_position, char, number_0, number_1, i, node, size, t, length, map;

	stack_nodes_current[15] = 0; stack_nodes_current_index = -1;
	stack_nodes_next[15] = 0; stack_nodes_next_index = -1;
	stack_nodes_current[++stack_nodes_current_index] = argument0[| 0];

	map = ds_map_create();

	length = string_length(argument1);
	for (char_position = 1; char_position <= length; ++char_position) {
	    while (stack_nodes_current_index >= 0) {
	        node = stack_nodes_current[stack_nodes_current_index--];
	        size = ds_list_size(node.edges_out);
	        for (i = 0; i < size; ++i) {
	            if (node.edges_out[| i].symbol == "" && is_undefined(map[? node.edges_out[| i].to])) {
	                stack_nodes_current[++stack_nodes_current_index] = node.edges_out[| i].to;
	                ds_map_add(map, node.edges_out[| i].to, true);
	            } else {
	                char = string_char_at(node.edges_out[| i].symbol, 1);
	                if (char == "\\") {
	                    switch (string_char_at(node.edges_out[| i].symbol, 2)) {
	                        case "0":
	                            char = ord(string_char_at(argument1, char_position));
	                            if (char >= 97 && char <= 122) stack_nodes_next[++stack_nodes_next_index] = node.edges_out[| i].to;
	                            break;
                            
	                        case "1":
	                            char = ord(string_char_at(argument1, char_position));
	                            if (char >= 65 && char <= 90) stack_nodes_next[++stack_nodes_next_index] = node.edges_out[| i].to;
	                            break;
                            
	                        case "2":
	                            char = ord(string_char_at(argument1, char_position));
	                            number_0 = ord(string_char_at(node.edges_out[| i].symbol, 3));
	                            number_1 = ord(string_char_at(node.edges_out[| i].symbol, 4));
	                            if ((char >= number_0 && char <= number_1) || (char <= number_0 && char >= number_1)) stack_nodes_next[++stack_nodes_next_index] = node.edges_out[| i].to; 
	                            break;
	                    }
	                } else if (string_char_at(argument1, char_position) == char) {
	                    stack_nodes_next[++stack_nodes_next_index] = node.edges_out[| i].to;
	                }
	            }
	        }
	    }
	    if (stack_nodes_next_index < 0) {ds_map_destroy(map); return false;}
	    t = stack_nodes_current; stack_nodes_current = stack_nodes_next; stack_nodes_next = t;
	    t = stack_nodes_current_index; stack_nodes_current_index = stack_nodes_next_index; stack_nodes_next_index = t;
	    ds_map_clear(map);
	}

	while (stack_nodes_current_index >= 0) {
	    node = stack_nodes_current[stack_nodes_current_index--];
	    size = ds_list_size(node.edges_out);
	    if (size == 0) {ds_map_destroy(map); return true;}
	    for (i = 0; i < size; ++i) if (node.edges_out[| i].symbol == "" && is_undefined(map[? node.edges_out[| i].to])) {
	        stack_nodes_current[++stack_nodes_current_index] = node.edges_out[| i].to;
	        ds_map_add(map, node.edges_out[| i].to, true);
	    }
	}

	ds_map_destroy(map);

	return false;

	/*
	 * Permission is hereby granted, free of charge, to any person
	 * obtaining a copy of this software and associated
	 * documentation files (the "Software"), to deal in the
	 * Software without restriction, including without limitation
	 * the rights to use, copy, modify, merge, publish, distribute,
	 * sublicense, and/or sell copies of the Software, and to
	 * permit persons to whom the Software is furnished to do so,
	 * subject to the following conditions:
	 * 
	 * The above copyright notice and this permission notice shall
	 * be included in all copies or substantial portions of the
	 * Software.
	 * 
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
	 * KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
	 * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
	 * PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS
	 * OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
	 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
	 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	 */



}
