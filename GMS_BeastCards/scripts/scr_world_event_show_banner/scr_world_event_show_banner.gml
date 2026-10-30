//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_SHOW_BANNER
// FUNCTION: Displays one dedicated World Event banner during stable overworld
//           gameplay. If battle/pause/transition state prevents safe display,
//           the banner payload is cached on the persistent controller and shown
//           when gameplay resumes.
//
// ARGUMENTS: _str_title - Banner heading.
//            _str_line_1 - First detail line.
//            _str_line_2 - Second detail line.
// RETURNS: True when displayed immediately; false when queued/failed.
//
//===============================================================================//

function scr_world_event_show_banner(
	_str_title,
	_str_line_1="",
	_str_line_2=""
){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	_str_title =
		string(
			_str_title
		);

	_str_line_1 =
		string(
			_str_line_1
		);

	_str_line_2 =
		string(
			_str_line_2
		);

	//================//
//QUEUE UNTIL SAFE//
//================//
	if (!scr_world_event_can_advance_time()){

		_ref_controller
			._flag_status_banner_pending =
			true;

		_ref_controller
			._str_pending_banner_title =
			_str_title;

		_ref_controller
			._str_pending_banner_line_1 =
			_str_line_1;

		_ref_controller
			._str_pending_banner_line_2 =
			_str_line_2;

		return false;
	}

	//================//
//ONE EVENT BANNER//
//================//
	with (obj_gui_world_event_banner){
		instance_destroy();
	}

	var _ref_banner =
		instance_create_layer(
			display_get_gui_width() *
				0.5,
			80,
			"ily_fx",
			obj_gui_world_event_banner
		);

	if (!instance_exists(_ref_banner)){
		return false;
	}

	_ref_banner._str_title =
		_str_title;

	_ref_banner._str_line_1 =
		_str_line_1;

	_ref_banner._str_line_2 =
		_str_line_2;

	return true;
}
