self.shader_sway = sh_sway; // Reference the shader by name
self.u_time = shader_get_uniform(self.shader_sway, "u_time");

if (self.u_time == -1) {
    show_debug_message("ERROR: Could not find uniform 'u_time' in shader_sway.");
}