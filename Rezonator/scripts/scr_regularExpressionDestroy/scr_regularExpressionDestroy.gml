/// @description  regular_expression_destroy(compiled regular expression)
/// @param compiled regular expression
function scr_regularExpressionDestroy(argument0) {
	// Destroys a compiled regular expression.
	// compiled regular expression: A compiled regular expression returned from regular_expression_create.

	var i, j, size_0, size_1, list;

	size_0 = ds_list_size(argument0);
	for (i = 0; i < size_0; ++i) {
	    list = (argument0[| i]).edges_out;
	    size_1 = ds_list_size(list);
	    for (j = 0; j < size_1; ++j) {
	        instance_activate_object(list[| j]);
	        with (list[| j]) instance_destroy();
	    }
	    ds_list_destroy(list);
	    instance_activate_object(argument0[| i]);
	    with (argument0[| i]) instance_destroy();
	}

	ds_list_destroy(argument0);

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
