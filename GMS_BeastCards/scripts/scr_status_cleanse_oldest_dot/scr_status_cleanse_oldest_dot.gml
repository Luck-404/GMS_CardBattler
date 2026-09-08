//===============================================================================//
//
// SCRIPT: scr_status_cleanse_oldest_dot
// FUNCTION: Cleanses the oldest cleansable DoT from a target Beast.
//           Removes the full status including all stacks.
//           Returns 1 when a DoT was cleansed, otherwise 0.
//
//===============================================================================//

function scr_status_cleanse_oldest_dot(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	//================//
	//FIND OLDEST DOT//
	//================//
	var _ref_dot =
		undefined;

	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_target._list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_target._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "DOT"){
			continue;
		}

		if (_ref_status._flag_status_uncleansable){
			continue;
		}

		_ref_dot =
			_ref_status;

		break;
	}

	//--------------//
	//NO DOT FOUND//
	//--------------//
	if (!instance_exists(_ref_dot)){
		return 0;
	}

	var _str_status_name =
		_ref_dot._str_status_name;

	//----------------//
	//CLEANSE STATUS//
	//----------------//
	if (_ref_dot._scr_status != undefined){

		_ref_dot._scr_status(
			"DEATH",
			_ref_dot
		);
	}
	else{

		scr_status_destroy(_ref_dot);
	}

	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"CLEANSED " + _str_status_name,
		undefined,
		c_green,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);
	//----------------------//
	//CLEANSE PRESENTATION//
	//----------------------//
		scr_battle_vfx_cleanse(
			_ref_target
		);
	return 1;
}