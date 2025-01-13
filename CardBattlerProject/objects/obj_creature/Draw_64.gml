/////////////////////
// DRAW HEALTH BAR //
/////////////////////
// Set the drawing color for the health bar (green)
draw_set_color(c_green);

// Calculate the width of the health bar based on current health
var _health_bar_width = 100 * (_creature_hp_current / _creature_hp_max);

// Center the health bar above the creature
var _bar_x = x + 64 - _health_bar_width / 2;  // Center bar horizontally (x + 64 for the middle of the creature)
var _bar_y = y - 30;  // Position the bar slightly above the creature

// Draw the health bar
draw_rectangle(_bar_x, _bar_y, _bar_x + _health_bar_width, _bar_y + 10, false);

// Draw the current health number on the left side of the health bar
draw_set_color(c_white);
draw_text(_bar_x + 5, _bar_y + 3, string(_creature_hp_current) + "/" + string(_creature_hp_max));



///////////////////////
// DRAW DEFENSE ICON //
///////////////////////
// Set the drawing color for the defense (blue circle)
draw_set_color(c_blue);

// Draw the blue circle for the defense stat to the right of the health bar
var _defense_circle_radius = 12; // Radius of the circle
var _defense_x = _bar_x + _health_bar_width + 30; // Position the circle 15 pixels to the right of the health bar
var _defense_y = _bar_y + 5; // Vertically align it with the health bar

draw_circle(_defense_x, _defense_y, _defense_circle_radius, false);  // Draw the circle

// Draw the defense number inside the circle
draw_set_color(c_white);
draw_text(_defense_x - 4, _defense_y - 5, string(_creature_def));  // Display the defense value inside the circle



//////////////////////////
// ENLARGE ON MOUSEOVER //
//////////////////////////
// Check if mouse is over the creature (including its enlarged size when hovered)
if (position_meeting(mouse_x,mouse_y,self)) {
    // Enlarge the sprite when hovered
    draw_sprite_ext(sprite_index, image_index, x, y, 1.5, 1.5, image_angle, c_white, 1);  // Enlarged sprite on hover
} else {
    // Draw the sprite normally when not hovered
    draw_sprite(sprite_index, image_index, x, y);
}