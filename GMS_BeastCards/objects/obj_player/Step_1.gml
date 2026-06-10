//===============================================================================//
//
// BEGIN STEP: OBJ_PLAYER
// FUNCTION: Creates and manages the player's camera.
//           Smoothly interpolates camera zoom toward target values.
//           Centers the camera on the player.
//           Clamps the camera within room boundaries.
//
//===============================================================================//

#region CREATE CAMERA ONCE PER ROOM
	if (!_flag_created_camera){ //IF A CAMERA HAS NOT BEEN MADE YET FOR THE CURRENT ROOM
		_flag_created_camera = true;
	
		//—------------------------------------------------------------------------------//
		// DESTROY OLD CAMERA
		//—------------------------------------------------------------------------------//
	    if (global.camera != undefined){
	        camera_destroy(global.camera);
	    }

		//—------------------------------------------------------------------------------//
		// SET CAMERA SIZE TO STORED WIDTH AND HEIGHT
		//—------------------------------------------------------------------------------//
	    global.cam_width  = global.cam_target_width;
	    global.cam_height = global.cam_target_height;

		//—------------------------------------------------------------------------------//
		// CREATE NEW VIEWPORT WITH APPROPRIATE SIZING
		//—------------------------------------------------------------------------------//
	    global.camera = camera_create_view(0,0,global.cam_width,global.cam_height,0,noone,-1,-1,-1,-1);
	    view_set_camera(0, global.camera);
	}
#endregion

#region SMOOTH CAMERA ZOOMING
	//—------------------------------------------------------------------------------//
	// SMOOTH CAMERA ZOOMING
	//—------------------------------------------------------------------------------//
	global.cam_width = lerp(global.cam_width,global.cam_target_width,0.08);
	global.cam_height = lerp(global.cam_height,global.cam_target_height,0.08);

	//SNAP TO TARGET WIDTH/HEIGHT ONCE CLOSE ENOUGH
	if (abs(global.cam_width - global.cam_target_width) < 0.5){
	    global.cam_width = global.cam_target_width;
	}
	if (abs(global.cam_height - global.cam_target_height) < 0.5){
	    global.cam_height = global.cam_target_height;
	}

	//SET THE NEW VIEW SIZE BASED ONTHE ZOOM LEVEL
	camera_set_view_size(global.camera,global.cam_width,global.cam_height);
#endregion

#region UPDATE
	//—------------------------------------------------------------------------------//
	// UPDATE CAMERA POSITIONING, CLAMP TO ROOM BOUNDS
	//—------------------------------------------------------------------------------//
	var _half_w = global.cam_width  * 0.5;
	var _half_h = global.cam_height * 0.5;

	var _cam_x = clamp(x - _half_w,0,room_width - global.cam_width);
	var _cam_y = clamp(y - _half_h,0,room_height - global.cam_height);

	camera_set_view_pos(global.camera,_cam_x,_cam_y);
#endregion