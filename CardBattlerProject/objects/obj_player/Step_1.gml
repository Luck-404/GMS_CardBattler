if (room == rm_overworld){
	var cam_width = camera_get_view_width(camera);
	var cam_height = camera_get_view_height(camera);
	var cam_x = x - cam_width / 2;
	var cam_y = y - cam_height / 2;

	camera_set_view_pos(camera, cam_x, cam_y);

	var cam_width = camera_get_view_width(camera);
	var cam_height = camera_get_view_height(camera);

	// Clamp camera position to room boundaries
	var cam_x = clamp(x - cam_width / 2, 0, room_width - cam_width);
	var cam_y = clamp(y - cam_height / 2, 0, room_height - cam_height);

	camera_set_view_pos(camera, cam_x, cam_y);
}