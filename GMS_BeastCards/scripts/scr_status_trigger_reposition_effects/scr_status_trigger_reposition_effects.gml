//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_REPOSITION_EFFECTS
// FUNCTION: Resolves Status effects caused by a successful gameplay
//           reposition of a Beast.
//
// ARGUMENTS: _ref_beast is the Beast that changed formation position.
// RETURNS: True if at least one Status effect triggered.
//
//===============================================================================//

function scr_status_trigger_reposition_effects(_ref_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_ref_beast._val_cur_hp <= 0){
		return false;
	}

	var _flag_triggered = false;

	//==================//
	//STATIC RESONANCE//
	//==================//
	var _ref_static_resonance = scr_status_check(
		"STATIC_RESONANCE",
		_ref_beast
	);

	if (
		_ref_static_resonance != -1 &&
		instance_exists(_ref_static_resonance)
	){

		var _ref_original_target =
			global.ref_target_beast;

		global.ref_target_beast =
			_ref_beast;

		var _ref_stormstruck =
			scr_status_apply_dot("STORMSTRUCK");

		global.ref_target_beast =
			_ref_original_target;

		if (instance_exists(_ref_stormstruck)){

			_flag_triggered = true;

			scr_debug_log_battle_trigger(
				"STATIC RESONANCE",
				global.ref_caster_beast,
				_ref_beast,
				"REPOSITIONED | STORMSTRUCK: +1",
				"SCR_STATUS_TRIGGER_REPOSITION_EFFECTS"
			);
		}
	}

	return _flag_triggered;
}