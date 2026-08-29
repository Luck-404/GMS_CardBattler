//===============================================================================//
//
// SCRIPT: SCR_APPLY_DOT_STATUS
// FUNCTION: Attempts to apply a damage-over-time status to the current target.
//           Checks target resistance from CON before applying.
//           Accepts an optional lifetime override.
//           Spawns feedback popup text for resisted or successful applications.
//
//===============================================================================//
function scr_apply_dot_status(
	_str_status_name,
	_val_lifetime=undefined,
	_flag_trigger_plague_garden=true
){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	var _ref_target =
		global.ref_target_beast;

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	if (_ref_target._ref_unit == undefined){
		return undefined;
	}

	//--------------//
	//RESIST CHECK//
	//--------------//
	if (scr_check_con_resistance(_ref_target)){
		return undefined;
	}

	//--------------//
	//APPLY STATUS//
	//--------------//
	var _ref_status =
		undefined;

	switch(_str_status_name){

		//-------//
		//BLEED//
		//-------//
		case "BLEED":

		_ref_status = scr_status_dot_bleed(
		"APPLY",
		undefined,
		_val_lifetime,
		_flag_trigger_plague_garden
	);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+1 BLEED",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//------//
		//BURN//
		//------//
		case "BURN":

			_ref_status =
				scr_status_dot_burn(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+1 BURN",
					undefined,
					c_red,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//--------//
		//POISON//
		//--------//
		case "POISON":

			_ref_status =
				scr_status_dot_poison(
					"APPLY",
					undefined,
					_val_lifetime,
					_flag_trigger_plague_garden
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+1 POISON",
					undefined,
					c_lime,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;


		//-------//
		//VENOM//
		//-------//
		case "VENOM":

			_ref_status =
				scr_status_dot_venom(
					"APPLY",
					undefined,
					_val_lifetime,
					_flag_trigger_plague_garden
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"+1 VENOM",
					undefined,
					c_purple,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}
	

	//------------------//
	//CHECK DOT TRAPS//
	//------------------//
	scr_trigger_dot_traps(
		global.ref_target_beast
	);		

	return _ref_status;
}