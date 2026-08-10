//===============================================================================//
//
// SCRIPT: SCR_APPLY_AURA_STATUS
// FUNCTION: Applies an Aura status to the current target Beast.
//           Auras are host-bound persistent statuses.
//           Passes card-controlled magnitude into the Aura callback.
//
//===============================================================================//
function scr_apply_aura_status(_str_status_name,_val_magnitude=0){

	var _ref_target =
		global.ref_target_beast;

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	var _ref_status =
		undefined;

	switch(_str_status_name){

		//------------------//
		//BURGEONING BLOOM//
		//------------------//
		case "BURGEONING_BLOOM":

			_ref_status =
				scr_status_aura_burgeoning_bloom(
					"APPLY",
					undefined,
					_val_magnitude
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"BURGEONING BLOOM",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}

	return _ref_status;
}