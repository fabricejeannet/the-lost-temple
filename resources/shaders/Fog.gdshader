shader_type canvas_item;

uniform sampler2D noise_texture : hint_albedo;

void fragment() {
	vec2 coord = SCREEN_UV;
	vec4 noise = texture(noise_texture, coord *  TIME * 0.02);
	vec4 final = noise;
	if (final.a > 0.0) {
		final.a = final.r;
	}
	
	COLOR = final;
}