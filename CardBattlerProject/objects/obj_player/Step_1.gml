//////////////////
// CAMERA LOGIC //
//////////////////
if (room == rm_overworld){
	var _cam_width = camera_get_view_width(_camera);
	var _cam_height = camera_get_view_height(_camera);
	// Clamp camera position to room boundaries
	var _cam_x = clamp(x - _cam_width / 2, 0, room_width - _cam_width);
	var _cam_y = clamp(y - _cam_height / 2, 0, room_height - _cam_height);
	
	camera_set_view_pos(_camera, _cam_x, _cam_y);
}