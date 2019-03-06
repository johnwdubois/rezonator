/// @description  input_text_set_transformation(id, x, y, xscale, yscale, angle)
/// @function  input_text_set_transformation
/// @param id
/// @param  x
/// @param  y
/// @param  xscale
/// @param  yscale
/// @param  angle
// Sets the position, scale and angle of a text input instance.
// id: The instance id of the obj_input_text to transform.
// x, y: The text's position.
// xscale, yscale: The text's scale.
// angle: The text's angle.

with (argument0) {
    x = argument1;
    y = argument2;
    global_scale_x = argument3;
    global_scale_y = argument4;
    image_angle = argument5;
    
    image_xscale = global_scale_x * local_scale_x; image_yscale = global_scale_y * local_scale_y;
    var t = matrix_build(x, y, 0, 0, 0, image_angle, 1, 1, 1);
    matrix_global = matrix_build(0, 0, 0, 0, 0, 0, global_scale_x, global_scale_y, 1); matrix_global = matrix_multiply(matrix_global, t);
    matrix_cursor = matrix_build(0, 0, 0, 0, 0, 0, image_xscale, image_yscale, 1); matrix_cursor = matrix_multiply(matrix_cursor, t);

    transformation_was_changed = true;
}
