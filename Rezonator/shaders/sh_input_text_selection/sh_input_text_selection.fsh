varying vec2 v_vTexcoord;

uniform sampler2D sf_selection;
uniform vec4 selection_color_background;
uniform vec4 selection_color_text;
uniform float alpha;

void main() {
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
    if (texture2D(sf_selection, v_vTexcoord).r > 0.0) {
        gl_FragColor = vec4(
            mix(selection_color_background.rgb, selection_color_text.rgb, selection_color_text.a * gl_FragColor.a),
            mix(selection_color_background.a, selection_color_text.a, gl_FragColor.a) * alpha
        );
    }
}
