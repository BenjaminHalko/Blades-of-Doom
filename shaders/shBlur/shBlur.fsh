varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 blur_vector;

const vec2 texel_size = vec2(1.0/480.0,1.0/270.0);
const float blur_steps = 6.0;
const float sigma = 0.6;

float weight(float pos) {
	return  exp(-(pos * pos) / (2.0 * sigma * sigma));
}

void main() {
	vec4 blurred_col = texture2D(gm_BaseTexture, v_vTexcoord);
	
	vec2 sample;
	float offset_L, sample_weight;
	float total_weight = 1.0;
	
	for(float offset = 1.0; offset <= blur_steps; offset ++) {
		sample_weight = weight(offset / (blur_steps + 1.0));
		total_weight += 2.0 * sample_weight;
			
		sample = v_vTexcoord + offset * texel_size * blur_vector;
		blurred_col += texture2D(gm_BaseTexture, sample) * sample_weight;
		
		sample = v_vTexcoord - offset * texel_size * blur_vector;
		blurred_col += texture2D(gm_BaseTexture, sample) * sample_weight;
	}
	
    gl_FragColor = v_vColour * blurred_col / total_weight;
}

