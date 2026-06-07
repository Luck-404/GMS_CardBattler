//////////////////////////////////////////////////////////////////////
// CAMERA
//////////////////////////////////////////////////////////////////////

if (!_flag_created_camera)
{
    if (global.camera != undefined)
    {
        camera_destroy(global.camera);
    }

    global._cam_width  = 500;
    global._cam_height = 500;

    global.camera = camera_create_view(
        0,
        0,
        global._cam_width,
        global._cam_height,
        0,
        noone,
        -1,
        -1,
        -1,
        -1
    );

    view_set_camera(0, global.camera);

    _flag_created_camera = true;
}

//----------------------------------------------------
// SMOOTH CAMERA ZOOM
//----------------------------------------------------

global._cam_width = lerp(
    global._cam_width,
    global._cam_target_width,
    0.12
);

global._cam_height = lerp(
    global._cam_height,
    global._cam_target_height,
    0.12
);

// snap near destination
if (abs(global._cam_width - global._cam_target_width) < 0.5)
{
    global._cam_width = global._cam_target_width;
}

if (abs(global._cam_height - global._cam_target_height) < 0.5)
{
    global._cam_height = global._cam_target_height;
}

camera_set_view_size(
    global.camera,
    global._cam_width,
    global._cam_height
);

//update
var _half_w = global._cam_width  * 0.5;
var _half_h = global._cam_height * 0.5;

var _cam_x = clamp(
    x - _half_w,
    0,
    room_width - global._cam_width
);

var _cam_y = clamp(
    y - _half_h,
    0,
    room_height - global._cam_height
);

camera_set_view_pos(
    global.camera,
    _cam_x,
    _cam_y
);