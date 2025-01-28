// Decrement life
if (_life > 0) {
    // Draw the banner sprite
	image_speed = 1;
    draw_sprite_ext(spr_banner, image_index, display_get_width()/2, display_get_height()/8, 2, 2, 0, _ban_color, 1);
    // Decrease life
    _life--;

    // Draw text in the center of the screen
    if (_life < 115) { // Show text for the last 100 frames
		image_speed = 0;
		image_index = 7;
        draw_set_color(c_white); // Set text color
        draw_text(display_get_width()/2-(8*string_length(_ban_text)), display_get_height()/8-10, _ban_text); // Draw centered text
    }
} else {
    instance_destroy(); // Destroy the banner instance when life reaches 0
}