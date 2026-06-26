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
	    if (global.ref_camera != undefined){
	        camera_destroy(global.ref_camera);
	    }

		//—------------------------------------------------------------------------------//
		// SET CAMERA SIZE TO STORED WIDTH AND HEIGHT
		//—------------------------------------------------------------------------------//
	    global.val_cam_width  = global.val_cam_target_width;
	    global.val_cam_height = global.val_cam_target_height;

		//—------------------------------------------------------------------------------//
		// CREATE NEW VIEWPORT WITH APPROPRIATE SIZING
		//—------------------------------------------------------------------------------//
	    global.ref_camera = camera_create_view(0,0,global.val_cam_width,global.val_cam_height,0,noone,-1,-1,-1,-1);
	    view_set_camera(0, global.ref_camera);
	}
#endregion

#region SMOOTH CAMERA ZOOMING
	//—------------------------------------------------------------------------------//
	// SMOOTH CAMERA ZOOMING
	//—------------------------------------------------------------------------------//
	global.val_cam_width = lerp(global.val_cam_width,global.val_cam_target_width,0.08);
	global.val_cam_height = lerp(global.val_cam_height,global.val_cam_target_height,0.08);

	//SNAP TO TARGET WIDTH/HEIGHT ONCE CLOSE ENOUGH
	if (abs(global.val_cam_width - global.val_cam_target_width) < 0.5){
	    global.val_cam_width = global.val_cam_target_width;
	}
	if (abs(global.val_cam_height - global.val_cam_target_height) < 0.5){
	    global.val_cam_height = global.val_cam_target_height;
	}

	//SET THE NEW VIEW SIZE BASED ONTHE ZOOM LEVEL
	camera_set_view_size(global.ref_camera,global.val_cam_width,global.val_cam_height);
#endregion

#region UPDATE
	//—------------------------------------------------------------------------------//
	// UPDATE CAMERA POSITIONING, CLAMP TO ROOM BOUNDS
	//—------------------------------------------------------------------------------//
	var _val_half_w = global.val_cam_width  * 0.5;
	var _val_half_h = global.val_cam_height * 0.5;

	var _val_cam_x = clamp(x - _val_half_w,0,room_width - global.val_cam_width);
	var _val_cam_y = clamp(y - _val_half_h,0,room_height - global.val_cam_height);

	camera_set_view_pos(global.ref_camera,_val_cam_x,_val_cam_y);
#endregion