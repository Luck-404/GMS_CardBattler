//===============================================================================//
//
// SCRIPT: SCR_APPLY_CC_STATUS
// FUNCTION: Attempts to apply a crowd-control status to the current target.
//           Checks target resistance from CON before applying.
//           Accepts an optional lifetime override.
//           Spawns feedback popup text for successful applications.
//
//===============================================================================//
function scr_apply_cc_status(
	_str_status_name,
	_val_lifetime=undefined,
	_flag_ignore_resistance=false
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
	if (
		scr_check_con_resistance(
			_ref_target,
			_flag_ignore_resistance
		)
	){
		return undefined;
	}

	//--------------//
	//APPLY STATUS//
	//--------------//
	var _ref_status = undefined;

	switch(_str_status_name){
		//--------//
		//FROZEN//
		//--------//
		case "FROZEN":

			_ref_status =
				scr_status_cc_frozen(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"FROZEN",
					undefined,
					c_aqua,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//-----//
		//SLEEP//
		//-----//
		case "SLEEP":

			_ref_status =
				scr_status_cc_sleep(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"ASLEEP",
					undefined,
					c_black,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;		
		
case "BLIND":

	_ref_status =
		scr_status_cc_blind(
			"APPLY",
			undefined,
			_val_lifetime
		);

	if (_ref_status != undefined){

		scr_spawn_popup_scrolling(
			"TEXT",
			"BLINDED",
			undefined,
			c_black,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

break;

		case "STUN":

			_ref_status =
				scr_status_cc_stun(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"STUNNED",
					undefined,
					c_black,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}

	return _ref_status;
}