//create
_flag_fullscreen = true;
window_set_fullscreen(_flag_fullscreen);

// Initialize variables
target_x = x; // Current position
target_y = y;
moving = false; // Movement status
// Align the character to the grid at the start
x = round(x / 32) * 32; // Align horizontally
y = round(y / 32) * 32; // Align vertically
x = x-16;
y = y-16;






camera = camera_create(); // Create a camera
var cam_width = 960; // Camera width (match your viewport)
var cam_height = 540; // Camera height (match your viewport)
camera_set_view_size(camera, cam_width, cam_height); // Set camera size
camera_set_view_pos(camera, x - cam_width / 2, y - cam_height / 2); // Center on character
view_set_camera(0, camera); // Attach camera to Viewport 0

instance_create_layer(x,y,"GUI",obj_encounter);