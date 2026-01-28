shader_type spatial;
render_mode unshaded;

uniform sampler2D screen_texture :hint_screen_texture;

void fragment() {
	vec3 color = texture(screen_texture, SCREEN_UV).rgb;

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
