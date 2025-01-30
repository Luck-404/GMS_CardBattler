// Set the shader before drawing the tilemap
shader_set(self._shader_sway);

// Pass a time variable to the shader (normalized)
shader_set_uniform_f(self._u_time, current_time / 1000.0);

// Get the tilemap layer ID
var _layer_id = layer_get_id("tl_grass"); 
var _tilemap_id = layer_tilemap_get_id(_layer_id);

// Draw the tilemap at its default position (0,0)
draw_tilemap(_tilemap_id, 0, 0);

// Reset shader so it doesn’t affect other objects
shader_reset();