shader_type canvas_item;
uniform sampler2D screen_tex : hint_screen_texture, repeat_disable, filter_linear;
uniform sampler2D background_tex : repeat_enable;

uniform float spacing : hint_range(0.0, 10.0) = 0.1;
uniform float dissapate : hint_range(0.0, 0.1) = 0.01;
uniform float bg_amount : hint_range(0.0, 1.0) = 0.2;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 center_color = textureLod(screen_tex, SCREEN_UV, 0.0);
	vec4 avg_color = vec4(0.0);
	for (float x = -1.0 ; x <= 1.0 ; x += 1.0) {
		for (float y = -1.0 ; y <= 1.0 ; y += 1.0) {
			avg_color += textureLod(
				screen_tex,
				SCREEN_UV + spacing * SCREEN_PIXEL_SIZE * vec2(x, y), 0.0) / 9.0;
		}
	}
	vec2 bg_uv = vec2(cos(TIME * 0.1), sin(TIME * 0.2))
	 + SCREEN_UV * (2.0 + sin(TIME * 0.15)) + vec2(cos(TIME * 0.4), sin(TIME)) * 0.1;
	vec2 bg_uv2 = vec2(cos(TIME * 0.3) * 0.5, sin(TIME * 0.1))
	 + SCREEN_UV * (2.3 + sin(TIME * 0.10)) + vec2(cos(TIME * 0.3), sin(TIME * 0.7)) * 0.1;
	bg_uv2.x = cos(bg_uv.x + sin(bg_uv2.y));
	bg_uv2.y = sin(bg_uv.y + cos(bg_uv2.x));
	bg_uv += avg_color.xy;
	vec4 bgcol = texture(background_tex, bg_uv) + texture(background_tex, bg_uv2);
	bgcol = sin(bgcol * 3.0) * 0.2;
	COLOR = mix(
		vec4(avg_color.rgb, 1.0),
		mix(bgcol, center_color, vec4(0.0,0.0, 0.1, 0.1)), dissapate);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
