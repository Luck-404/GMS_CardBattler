//===============================================================================//
//
// BEGIN STEP: OBJ_PLAYER
// FUNCTION: Creates and manages the player's overworld camera.
//           Smoothly interpolates camera zoom toward target dimensions.
//           Centers and clamps the camera within room boundaries.
//
//===============================================================================//

//================//
//CREATE CAMERA//
//================//
if (!_flag_camera_created){

	_flag_camera_created = true;

	//----------------//
	//DESTROY OLD CAMERA//
	//----------------//
	if (global.ref_camera != undefined){
		camera_destroy(global.ref_camera);
	}

	//----------------//
	//SET CAMERA SIZE//
	//----------------//
	global.val_cam_width = global.val_cam_target_width;
	global.val_cam_height = global.val_cam_target_height;

	//----------------//
	//CREATE CAMERA//
	//----------------//
	global.ref_camera = camera_create_view(
		0,
		0,
		global.val_cam_width,
		global.val_cam_height,
		0,
		noone,
		-1,
		-1,
		-1,
		-1
	);

	view_set_camera(0,global.ref_camera);
}

//================//
//SMOOTH CAMERA ZOOM//
//================//
global.val_cam_width = lerp(
	global.val_cam_width,
	global.val_cam_target_width,
	0.08
);

global.val_cam_height = lerp(
	global.val_cam_height,
	global.val_cam_target_height,
	0.08
);

if (abs(global.val_cam_width - global.val_cam_target_width) < 0.5){
	global.val_cam_width = global.val_cam_target_width;
}

if (abs(global.val_cam_height - global.val_cam_target_height) < 0.5){
	global.val_cam_height = global.val_cam_target_height;
}

camera_set_view_size(
	global.ref_camera,
	global.val_cam_width,
	global.val_cam_height
);

//================//
//UPDATE CAMERA POSITION//
//================//
var _val_half_width = global.val_cam_width * 0.5;
var _val_half_height = global.val_cam_height * 0.5;

var _val_cam_max_x = max(0,room_width - global.val_cam_width);
var _val_cam_max_y = max(0,room_height - global.val_cam_height);

var _val_cam_x = clamp(x - _val_half_width,0,_val_cam_max_x);
var _val_cam_y = clamp(y - _val_half_height,0,_val_cam_max_y);

camera_set_view_pos(
	global.ref_camera,
	_val_cam_x,
	_val_cam_y
);