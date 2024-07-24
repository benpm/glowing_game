shader_type canvas_item;
uniform sampler2D screen_tex : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D background_tex : repeat_enable;

uniform float spacing : hint_range(0.0, 10.0) = 0.1;
uniform float dissapate : hint_range(0.0, 1.0) = 0.01;
uniform float bg_amount : hint_range(0.0, 1.0) = 0.2;
uniform vec2 camera_pos = vec2(0.0);
uniform vec2 camera_delta = vec2(0.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = SCREEN_UV - SCREEN_PIXEL_SIZE * camera_delta * 8.0;
	vec2 cpos = camera_pos * SCREEN_PIXEL_SIZE;
	vec3 center_color = textureLod(screen_tex, uv, 0.0).rgb;
	vec3 avg_color = vec3(0.0);
	vec2 ruv = vec2(0.0, 0.0);
	for (float x = -1.0 ; x <= 1.0 ; x += 1.0) {
		for (float y = -1.0 ; y <= 1.0 ; y += 1.0) {
			avg_color += textureLod(
				screen_tex,
				uv + spacing * SCREEN_PIXEL_SIZE * (vec2(x, y) + ruv), 0.0).rgb / 9.0;
		}
	}

	vec2 bg_uv1 = vec2(cos(TIME * 0.1), sin(TIME * 0.2))
	 + uv * (2.0 + sin(TIME * 0.15)) + vec2(sin((uv.x + TIME) * 0.4), sin(TIME)) * 0.1;
	vec2 bg_uv2 = vec2(cos(TIME * 0.3) * 0.5, sin(TIME * 0.1))
	 + uv * (2.3 + cos((uv.y + TIME) * 0.10)) + vec2(cos(TIME * 0.3), sin(TIME * 0.7)) * 0.1;
	bg_uv2.x = cos(bg_uv1.x + sin(bg_uv2.y));
	bg_uv2.y = sin(bg_uv1.y + cos(bg_uv2.x));
	bg_uv1 += avg_color.xy;
	bg_uv1 += camera_pos * 0.001;
	bg_uv2 += camera_pos * 0.0001;
	vec3 bgcol = texture(background_tex, bg_uv1).rgb + texture(background_tex, bg_uv2).rgb;
	bgcol = max((0.5 + sin(bgcol * 3.0)) * 0.2, vec3(0.0));
	
	COLOR = vec4(mix(
		avg_color + bgcol * 0.1,
		bgcol * bg_amount,
		dissapate
	), 1.0);
}
