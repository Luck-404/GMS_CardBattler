//===============================================================================//
//
// SCRIPT: SCR_BEAST_SOUND_IS_VALID
// FUNCTION: Returns whether a Beast has completed the staged per-Beast sound
//           rollout and may use Cry, Death, and Interact sounds.
//
//           During rollout, add completed Beast names only to _arr_valid_beasts.
//           Beast-specific sound requests for all other species fail silently so
//           placeholder/legacy Beast sounds cannot leak into the new system.
//
// ARGUMENTS: _str_beast_name - Beast ID/name to validate.
// RETURNS: True when the Beast is enabled for the new sound system.
//
//===============================================================================//
function scr_beast_sound_is_valid(_str_beast_name){

	static _arr_valid_beasts = [
		"ARBRAWN",
		"ARGENTBUD",
		"BEAVINE",
		"BRYOBITE",
		"CHITROOPER",
		"CRUSABER",
		"DRYADAE",
		"FIGHTREE",
		"FLITSAGE",
		"FURN",
		"LEPOROOT",
		"LUMBUCK",
		"MAMBARK",
		"MORELUSH",
		"SPOROSE",
		"STRIGIBLOOM",
		"TURFRANTULA"
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
