//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_FORMAT_TIME
// FUNCTION: Formats a World Event timer as MM:SS using a ceiling so the display
//           does not show the next second early.
//
// ARGUMENTS: _val_seconds - Remaining timer seconds.
// RETURNS: MM:SS string.
//
//===============================================================================//

function scr_world_event_format_time(_val_seconds){

	var _ct_total_seconds =
		max(
			0,
			ceil(
				_val_seconds
			)
		);

	var _ct_minutes =
		floor(
			_ct_total_seconds /
			60
		);

	var _ct_seconds =
		_ct_total_seconds mod
		60;

	var _str_seconds =
		(_ct_seconds < 10)
		? "0" +
			string(
				_ct_seconds
			)
		: string(
			_ct_seconds
		);

	return
		string(
			_ct_minutes
		) +
		":" +
		_str_seconds;
}
