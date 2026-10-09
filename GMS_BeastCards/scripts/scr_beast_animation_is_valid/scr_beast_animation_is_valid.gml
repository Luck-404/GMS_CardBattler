//===============================================================================//
//
// SCRIPT: SCR_BEAST_ANIMATION_IS_VALID
// FUNCTION: Returns whether a Beast has been updated for the new multi-frame
//           Beast animation layout.
//
//           During the staged art rollout, add completed Beast names only to
//           _arr_valid_beasts below. Beasts not listed here remain locked to
//           sprite subimage 0 by the animation-control compatibility layer.
//
// ARGUMENTS: _str_beast_name - Beast ID/name to validate.
// RETURNS: True when the Beast is enabled for the new animation system.
//
//===============================================================================//
function scr_beast_animation_is_valid(_str_beast_name){

	static _arr_valid_beasts = [
		"ARBRAWN",
		"ARGENTBUD"
	];

	_str_beast_name =
		string_upper(
			string(
				_str_beast_name
			)
		);

	return array_contains(
		_arr_valid_beasts,
		_str_beast_name
	);
}
