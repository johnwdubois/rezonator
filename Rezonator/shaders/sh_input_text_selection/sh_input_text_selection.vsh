attribute vec3 in_Position;
attribute vec4 in_Colour; // You need a color attribute in your shader for HTML5 to work (even though you don't use it). (GM EA v1.99.182)
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;

void main() {
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vTexcoord = in_TextureCoord;
}
