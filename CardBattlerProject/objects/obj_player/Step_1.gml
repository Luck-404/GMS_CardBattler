//////////////////////////////////////////////////////////////////////
//					OBJ_PLAYER BEGIN STEP							//
//																	//
// > HANDLE CAMERA LOGIC											//
//////////////////////////////////////////////////////////////////////

if (room != rm_encounter){
	if (_flag_created_camera == false){
		if (global.camera != undefined){
			camera_destroy(global.camera);
		}
		global.camera = camera_create(); // Create a camera
		global._cam_width = 960; // Camera width (match your viewport)
		global._cam_height = 540; // Camera height (match your viewport)
		camera_set_view_size(global.camera, global._cam_width, global._cam_height); // Set camera size
		camera_set_view_pos(global.camera, x - global._cam_width / 2, y - global._cam_height / 2); // Center on character
		view_set_camera(0, global.camera); // Attach camera to Viewport 0
		_flag_created_camera = true;			
	}
	
	else if (_flag_created_camera == true){	
		camera_set_view_target(global.camera,obj_player);		
		// Clamp camera position to room boundaries
		var _cam_x = clamp(x - global._cam_width / 2, 0, room_width - global._cam_width);
		var _cam_y = clamp(y - global._cam_height / 2, 0, room_height - global._cam_height);
	
		camera_set_view_pos(global.camera, _cam_x, _cam_y);
	}
}