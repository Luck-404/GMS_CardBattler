varying vec2 v_vTexcoord;
uniform float u_time;

void main() {
    vec2 uv = v_vTexcoord;
    
    // Apply a sine wave effect to shift the texture horizontally
    uv.x += sin(uv.y * 1.0 + u_time) * 0.001; 

    // Sample the texture with the modified UV coordinates
    gl_FragColor = texture2D(gm_BaseTexture, uv);
}