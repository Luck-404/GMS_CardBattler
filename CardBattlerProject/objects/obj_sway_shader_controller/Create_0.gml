self._shader_sway = sh_sway; // Reference the shader by name
self._u_time = shader_get_uniform(self._shader_sway, "u_time");

if (self._u_time == -1) {
    show_debug_message("ERROR: Could not find uniform 'u_time' in shader_sway.");
}

depth = 201;

show_debug_message("SWAY_CONTROLLER: ... SUCCESS");
global.overworld_pipeline_state = PIPELINE_STATE.CHECK_NPC;