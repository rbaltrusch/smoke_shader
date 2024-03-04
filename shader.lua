return [[
// newest GLSL syntax
#pragma language glsl3

uniform float u_decay_rate;
uniform float u_time;
uniform float u_colour_decay_rate;

// gives funny-looking shader but not very random
float random2(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

const float PHI = 1.61803398874989484820459;  // Golden Ratio   
float random3(in vec2 xy, in float seed) {
    return fract(tan(distance(xy *PHI, xy) * seed) * xy.x);
}

float sum(vec4 rgb) {
    return rgb.r + rgb.g + rgb.b;
}

vec4 effect(vec4 color, Image image, vec2 uvs, vec2 texture_coords) {
    vec4 texture = Texel(image, uvs);
    vec2 random_offset = vec2(random3(uvs, u_time) - 0.5, random3(uvs, u_time + 1));
    vec4 below = Texel(image, uvs + 0.01 * random_offset);
    vec4 tex = sum(below) > sum(texture) ? (below * u_colour_decay_rate) : texture;
    return vec4(tex.rgb - u_decay_rate,  texture.a);
}
]]
