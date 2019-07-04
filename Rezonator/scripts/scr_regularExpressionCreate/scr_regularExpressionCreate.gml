/// @description  regular_expression_create(regular expression)
/// @param regular expression
// regular expression: A string containing the regular expression (see the next paragraph if you're unfamiliar with regular expressions). Special characters are parentheses, * (Kleene closure), | (union), ^ (the empty string).
//                     With backslash you have access to more: \n (new line), \+ (e.g. a\+ is the same as aa*), \? (a\? is the same as (^|a)), \a-z (a character from a to z), \A-Z (a character from A to Z),
//                     \m-n (a character from m to n (or n to m) where m and n are digits from 0 to 9). Use \\ for the backslash character itself, and \* for *, \| for |, \^ for ^, \( for (, and \) for ).
//
//                     What are regular expressions? Regular expressions are strings that define patterns. Such a string can for example be "a|b" which accepts either the string "a" or the string "b".
//                     Saying that a regular expression accepts a string, means that the string follows the regular expression's pattern (the string matches the regular expression). Looking at for example email addresses or
//                     integer numbers, you can see they have patterns. An email address starts with some text, then has an @-symbol, then some more text, then a .-symbol and then some more text again, e.g. example123@example.com.
//                     This is a pattern that you can write a regular expression for. A regular expression for email addresses can be used to check if what a user has typed in is a valid email address or not. We can say that
//                     such a regular expression accepts strings that are valid email addresses. If we use the regular_expression_match script with such a regular expression and some user input text, it would return
//                     true if the user input text is a valid email address. As for the other example, integer numbers, we can see that they have a pattern as well (following common conventions for number representation).
//                     Integers only contain digits or a minus sign. There can't be more than one minus sign and it can only be in the beginning of the number's string. And we usually don't want zeros at the beginning of
//                     our integers like "000123" unless the integer itself is zero.
//                     So how would you go about writing these regular expressions? First you need to know the syntax. Regular expressions can be written using the special characters |, (, ), ^, *, and other characters such as
//                     letters and digits. Let's look at some examples. "a|b" uses the special character |. | is called union and is kind of like an or-operator. You can read "a|b" as "a or b". The regular expression "a|b" only
//                     accepts the strings "a" or "b". "a|b|c" only accepts "a", "b", or "c" and so on. "a|bc|abc" only accepts "a", "bc", or "abc". You can use parentheses in a similar way that you would use parentheses in
//                     mathematical expressions. "(a|b)c" will only accept "ac" or "bc", you can read this as "a or b, followed by c". E.g. "(a|b)|c" or "(((a)|b|c))" is the same as "a|b|c".
//                     The regular expression "e|d(a|b)c|f" will only accept "e", "dac", "dbc", or "f". Notice that the d and c prioritizes the combination with (a|b). Adding parentheses to make it "(e|d)(a|b)(c|f)" makes d and c
//                     prioritize the |-operation. Remember how I said that you can read "a|b" as "a or b"? You can read "ab" as "a and b" (note that b has to be after a). There's an invisible and-operation there.
//                     Same with (a|b)c. There's an invisible and-operation between (a|b) and c. It's kind of like when we ignore the multiplication symbol in mathematics. And the and-operation has a higher priority than the
//                     or-operation, which is why d and c in "e|d(a|b)c|f" prioritizes the combination with (a|b), it's the same as "e|(d(a|b)c)|f".
//                     Let's move on to our next special symbol, "^". This is the symbol for the empty string, like "" for strings in programming. "^" is a regular expression that will only accept an empty string ("").
//                     If any character is in the string, it will not be accepted by the regular expression. "^|a" will only accept an empty string ("") or "a". For a more practical example, "colo(^|u)r" will accept "color" or
//                     "colour". Our next special symbol, "*", is called Kleene closure. It's used to allow for an arbitrary amount of repetitions of something. The regular expression "a*" will accept a string with an arbitrary
//                     amount of "a"-characters, e.g. "a", "aa", "aaa", or "aaaaaaaaa", or even "" (no "a"-characters at all, the amount is arbitrary meaning an amount of zero is also accepted).
//                     The regular expression "(a|b)*" accepts arbitrary strings made up of a or b, e.g. "a", "b", "ab", "ba", "ababbbabbaaabababa", "aaa", or "". "c(a|b)*" accepts the same as "(a|b)*", but it has to start with
//                     a c. Using the example strings from above that would be "ca", "cb", "cab", "cba", "cababbbabbaaabababa", "caaa", or "c". The and-operation might have a higher priority than the or-operation, but the
//                     Kleene star operation has an even higher priority than the and-operation, meaning that "c(a|b)*" is not the same as "(c(a|b))*", but rather the same as "c((a|b)*)", and "abc*a" is not the same
//                     as "(abc)*a", but rather the same as "ab(c*)a" (the Kleene closure goes for the c, but not for the whole abc). The regular expression "(c(a|b))*" accepts arbitrary strings made up of a or b,
//                     but all a or b has to have a c in front of them, e.g. "cacacbcacbca", "ca", or "".
//                     That was the difficult part! Next, let's look at the backslash character. Regular expressions can use more than just letters and digits between operators. E.g. the regular expression "@|£" which
//                     accepts "@" or "£" is also allowed. But what if you want to use the actual |-character? In that case you can use the backslash character to access it; "@|\|" will accept "@" or "|". The same
//                     goes for (, ), ^, and *. If you want to use the backslash character itself, you can use "\\", e.g. "@|\\" will accept "@" or "\". The backslash character can also be used for some simplifications.
//                     Instead of writing "a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z", you can use "\a-z", same for upper case with "\A-Z" and digits "\0-9" (in the digits case it's also possible to specify a
//                     range, e.g. \1-9 accepts all digits except 0, \2-5 or \5-2 accepts digits from 2 to 5). The regular expression "(\a-z|\A-Z|\0-9)*" accepts strings of arbitrary length containing letters or digits.
//                     \n is the same as the new line character (chr(10)). \+ is a shortcut for "one or more", instead of writing "(a|b|c)(a|b|c)*" to accept arbitrary strings made up of a, b or c that must contain at least
//                     one character, you can write "(a|b|c)\+". \? is another shortcut. Instead of writing "colo(^|u)r", you can write "colou\?r".
//                     Now let's try to write regular expressions for email addresses and integer numbers! So for email addresses we want the user to be able to have characters a-z, A-Z, 0-9, "_", ".", or "-" to the left of
//                     the @-character, so let's start with "(\a-z|\A-Z|\0-9|_|.|-)*" This will allow for strings of arbitrary length made up of letters, digits, "_", ".", or "-". But this will also accept an empty string,
//                     and we want at least one character to the left of the @-character, so let's make it "(\a-z|\A-Z|\0-9|_|.|-)(\a-z|\A-Z|\0-9|_|.|-)*" which we can simplify to "(\a-z|\A-Z|\0-9|_|.|-)\+". Then let's add
//                     the @-character to get "(\a-z|\A-Z|\0-9|_|.|-)\+@". To the right of the @-character, we want the domain part of the email address with characters a-z, 0-9, ".", or "-", followed by a ".", then
//                     characters a-z. So let's add "(\a-z|\0-9|.|-)\+.(\a-z)\+" to get "(\a-z|\A-Z|\0-9|_|.|-)\+@(\a-z|\0-9|.|-)\+.(\a-z)\+", and there we have it. I've done some simplifications though. The real email address
//                     format is more complicated, you're for example not allowed to have a domain part like "-abc-.com" or "abc..com", but this regular expression accepts this. For integer numbers it's less complicated though.
//                     First we want an optional minus sign, so we start off with "(^|-)" which we simplify to "-\?". Then we want one or more digits, so we get "-\?(\0-9)\+". This will also accept strings like
//                     "000123" and "-01", so to avoid this, let's make it so that we can't start with zeros. Then we get "-\?(\1-9)(\0-9)*". This accepts any integer except for 0, so let's add 0 with an or-operation and we
//                     end up with "(-\?(\1-9)(\0-9)*)|0". I hope this explanation has been helpful!
//
// If successful: Returns a compiled regular expression in the form of a list. This value can be used with the other regular_expression_* scripts.
// If unsuccessful: Returns an error string.

// Converts the infix regular expression to a postfix regular expression.

var infix, postfix, parentheses_nalt, parentheses_natom, parentheses_index, nalt, natom, length, i, char, chars;

infix = argument0; postfix = "";
parentheses_nalt[63] = 0; parentheses_natom[63] = 0;
parentheses_index = 0;
nalt = 0; natom = 0;

length = string_length(infix);
if (length == 0) return "Error. Regular expression cannot be an empty string. You can use " + "^" + " if you want the regular expression to only accept empty strings.";
if (string_char_at(infix, length) == "|") return "Union error when converting to postfix form at character " + string(length) + ".";
for (i = 1; i <= length; ++i) {
    char = string_char_at(infix, i);
    switch (char) {
        case "(":
            if (natom > 1) {--natom; postfix += "(";}
            parentheses_nalt[parentheses_index] = nalt; parentheses_natom[parentheses_index] = natom;
            ++parentheses_index;
            nalt = 0; natom = 0;
            break;
            
        case "|":
            if (natom == 0) return "Union error when converting to postfix form at character " + string(i) + ".";
            while (--natom > 0) postfix += "(";
            ++nalt;
            break;
            
        case ")":
            if (parentheses_index == 0) return "Closing parenthesis error when converting to postfix form at character " + string(i) + ".";
            if (natom == 0) return "Closing parenthesis error when converting to postfix form at character " + string(i) + ".";
            while (--natom > 0) postfix += "(";
            for (; nalt > 0; --nalt) postfix += "|";
            --parentheses_index;
            nalt = parentheses_nalt[parentheses_index]; natom = parentheses_natom[parentheses_index];
            ++natom;
            break;
            
        case "*":
            if (natom == 0) return "Kleene closure error when converting to postfix form at character " + string(i) + ".";
            postfix += char;
            break;
            
        case "\\":
            postfix += char;
            char = string_char_at(infix, i + 1);
            if (char == "?" || char == "+") {
                if (natom == 0) return "\\" + char + " error when converting to postfix form at character " + string(i) + ".";
                postfix += char; ++i; break;
            }
            if (char == "n") {
                postfix += char; ++i;
                if (natom > 1) postfix += "("; else ++natom; break;
            }
            chars = string_copy(infix, i + 1, 3);
            if (chars == "a-z" || chars == "A-Z" || (string_digits(char) != "" && string_char_at(infix, i + 2) == "-" && string_digits(string_char_at(infix, i + 3)) != "")) {
                postfix += chars; i += 3;
                if (natom > 1) postfix += "("; else ++natom; break;
            }
            return "Backslash character not followed by an accepted symbol.";
            
        default:
            if (natom > 1) postfix += "("; else ++natom;
            postfix += char;
            break;
    }
}

if (parentheses_index != 0) return "Error. Missing parenthesis.";
while (--natom > 0) postfix += "(";
for (; nalt > 0; --nalt) postfix += "|";

// Parses the postfix regular expression, converting it to a nondeterministic finite state automaton.

var group_edges_in, group_edges_out, group_index, stack, stack_index, i, j, symbol, size, edge_0, edge_1, group_0, group_1, t, node, list_nodes;

group_edges_in[63] = 0; group_edges_out[63] = 0; group_index = -1;
length = string_length(postfix);
list_nodes = ds_list_create();

for (i = 1; i <= length; ++i) {
    char = string_char_at(postfix, i);
    switch (char) {
        case "(":
            group_1 = group_index--; group_0 = group_index;
            node = instance_create(0, 0, obj_regular_expression_node); ds_list_add(list_nodes, node);
            size = ds_list_size(group_edges_out[group_0]);
            for (j = 0; j < size; ++j) (ds_list_find_value(group_edges_out[group_0], j)).to = node;
            size = ds_list_size(group_edges_in[group_1]);
            for (j = 0; j < size; ++j) {t = ds_list_find_value(group_edges_in[group_1], j); t.from = node; ds_list_add(node.edges_out, t);}
            ds_list_destroy(group_edges_out[group_0]); ds_list_destroy(group_edges_in[group_1]);
            group_edges_out[group_0] = group_edges_out[group_1];
            break;
            
        case "|":
            group_1 = group_index--; group_0 = group_index;
            size = ds_list_size(group_edges_in[group_1]);
            for (j = 0; j < size; ++j) ds_list_add(group_edges_in[group_0], ds_list_find_value(group_edges_in[group_1], j));
            size = ds_list_size(group_edges_out[group_1]);
            for (j = 0; j < size; ++j) ds_list_add(group_edges_out[group_0], ds_list_find_value(group_edges_out[group_1], j));
            ds_list_destroy(group_edges_in[group_1]); ds_list_destroy(group_edges_out[group_1]);
            break;
            
        case "*":
            node = instance_create(0, 0, obj_regular_expression_node); ds_list_add(list_nodes, node);
            edge_0 = instance_create(0, 0, obj_regular_expression_edge);
            edge_1 = instance_create(0, 0, obj_regular_expression_edge);
            size = ds_list_size(group_edges_in[group_index]);
            for (j = 0; j < size; ++j) {t = ds_list_find_value(group_edges_in[group_index], j); t.from = node; ds_list_add(node.edges_out, t);}
            size = ds_list_size(group_edges_out[group_index]);
            for (j = 0; j < size; ++j) (ds_list_find_value(group_edges_out[group_index], j)).to = node;
            edge_0.from = -1; edge_0.to = node; edge_0.symbol = "";
            edge_1.from = node; edge_1.to = -1; edge_1.symbol = "";
            ds_list_add(node.edges_out, edge_1);
            ds_list_clear(group_edges_in[group_index]); ds_list_clear(group_edges_out[group_index]);
            ds_list_add(group_edges_in[group_index], edge_0); ds_list_add(group_edges_out[group_index], edge_1);
            break;
            
        case "\\":
            char = string_char_at(postfix, i + 1);
            switch (char) {
                case "?":
                    edge_0 = instance_create(0, 0, obj_regular_expression_edge);
                    edge_0.from = -1; edge_0.to = -1; edge_0.symbol = "";
                    ++group_index;
                    group_edges_in[group_index] = ds_list_create(); group_edges_out[group_index] = ds_list_create();
                    ds_list_add(group_edges_in[group_index], edge_0); ds_list_add(group_edges_out[group_index], edge_0);
                
                    group_1 = group_index--; group_0 = group_index;
                    size = ds_list_size(group_edges_in[group_1]);
                    for (j = 0; j < size; ++j) ds_list_add(group_edges_in[group_0], ds_list_find_value(group_edges_in[group_1], j));
                    size = ds_list_size(group_edges_out[group_1]);
                    for (j = 0; j < size; ++j) ds_list_add(group_edges_out[group_0], ds_list_find_value(group_edges_out[group_1], j));
                    ds_list_destroy(group_edges_in[group_1]); ds_list_destroy(group_edges_out[group_1]);
                    break;
                    
                case "+":
                    ++group_index;
                    group_edges_in[group_index] = ds_list_create(); ds_list_copy(group_edges_in[group_index], group_edges_in[group_index - 1]);
                    group_edges_out[group_index] = ds_list_create(); ds_list_copy(group_edges_out[group_index], group_edges_out[group_index - 1]);
                
                    node = instance_create(0, 0, obj_regular_expression_node); ds_list_add(list_nodes, node);
                    edge_0 = instance_create(0, 0, obj_regular_expression_edge);
                    edge_1 = instance_create(0, 0, obj_regular_expression_edge);
                    size = ds_list_size(group_edges_in[group_index]);
                    for (j = 0; j < size; ++j) {t = ds_list_find_value(group_edges_in[group_index], j); t.from = node; ds_list_add(node.edges_out, t);}
                    size = ds_list_size(group_edges_out[group_index]);
                    for (j = 0; j < size; ++j) (ds_list_find_value(group_edges_out[group_index], j)).to = node;
                    edge_0.from = -1; edge_0.to = node; edge_0.symbol = "";
                    edge_1.from = node; edge_1.to = -1; edge_1.symbol = "";
                    ds_list_add(node.edges_out, edge_1);
                    ds_list_clear(group_edges_in[group_index]); ds_list_clear(group_edges_out[group_index]);
                    ds_list_add(group_edges_in[group_index], edge_0); ds_list_add(group_edges_out[group_index], edge_1);

                    group_1 = group_index--; group_0 = group_index;
                    node = instance_create(0, 0, obj_regular_expression_node); ds_list_add(list_nodes, node);
                    size = ds_list_size(group_edges_out[group_0]);
                    for (j = 0; j < size; ++j) (ds_list_find_value(group_edges_out[group_0], j)).to = node;
                    size = ds_list_size(group_edges_in[group_1]);
                    for (j = 0; j < size; ++j) {t = ds_list_find_value(group_edges_in[group_1], j); t.from = node; ds_list_add(node.edges_out, t);}
                    ds_list_destroy(group_edges_out[group_0]); ds_list_destroy(group_edges_in[group_1]);
                    group_edges_out[group_0] = group_edges_out[group_1];
                    break;
                    
                case "n":
                    edge_0 = instance_create(0, 0, obj_regular_expression_edge);
                    edge_0.from = -1; edge_0.to = -1; edge_0.symbol = chr(10);
                    ++group_index;
                    group_edges_in[group_index] = ds_list_create(); group_edges_out[group_index] = ds_list_create();
                    ds_list_add(group_edges_in[group_index], edge_0); ds_list_add(group_edges_out[group_index], edge_0);
                    break;
            }
            if (char == "?" || char == "+" || char == "n") {++i; break;}
            chars = string_copy(postfix, i + 1, 3);
            if (chars == "a-z" || chars == "A-Z") {
                edge_0 = instance_create(0, 0, obj_regular_expression_edge);
                edge_0.from = -1; edge_0.to = -1;
                if (chars == "a-z") edge_0.symbol = "\\0"; else edge_0.symbol = "\\1";
                ++group_index;
                group_edges_in[group_index] = ds_list_create(); group_edges_out[group_index] = ds_list_create();
                ds_list_add(group_edges_in[group_index], edge_0); ds_list_add(group_edges_out[group_index], edge_0);
                i += 3; break;
            }
            edge_0 = instance_create(0, 0, obj_regular_expression_edge);
            edge_0.from = -1; edge_0.to = -1; edge_0.symbol = "\\2" + char + string_char_at(postfix, i + 3);
            ++group_index;
            group_edges_in[group_index] = ds_list_create(); group_edges_out[group_index] = ds_list_create();
            ds_list_add(group_edges_in[group_index], edge_0); ds_list_add(group_edges_out[group_index], edge_0);
            i += 3; break;
            
        default:
            edge_0 = instance_create(0, 0, obj_regular_expression_edge);
            edge_0.from = -1; edge_0.to = -1;
            if (char == "^") edge_0.symbol = ""; else edge_0.symbol = char;
            ++group_index;
            group_edges_in[group_index] = ds_list_create(); group_edges_out[group_index] = ds_list_create();
            ds_list_add(group_edges_in[group_index], edge_0); ds_list_add(group_edges_out[group_index], edge_0);
    }
}

node_final = instance_create(0, 0, obj_regular_expression_node); ds_list_add(list_nodes, node_final);
node_start = instance_create(0, 0, obj_regular_expression_node); ds_list_insert(list_nodes, 0, node_start);
size = ds_list_size(group_edges_in[group_index]);
for (j = 0; j < size; ++j) {t = ds_list_find_value(group_edges_in[group_index], j); t.from = node_start; ds_list_add(node_start.edges_out, t);}
size = ds_list_size(group_edges_out[group_index]);
for (j = 0; j < size; ++j) (ds_list_find_value(group_edges_out[group_index], j)).to = node_final;
ds_list_destroy(group_edges_in[group_index]); ds_list_destroy(group_edges_out[group_index]);

return list_nodes;

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
