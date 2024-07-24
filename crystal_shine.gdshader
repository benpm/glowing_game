shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color += vec4(
		sin(TIME * 2.0 * 0.25 + SCREEN_UV.x * 10.0) * 0.1,
		cos(TIME * 1.5 * 0.25 + SCREEN_UV.y * 8.0) * 0.1,
		sin(TIME * 2.5 * 0.25 + SCREEN_UV.x * 10.0) * 0.2,
		0.0
	);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
