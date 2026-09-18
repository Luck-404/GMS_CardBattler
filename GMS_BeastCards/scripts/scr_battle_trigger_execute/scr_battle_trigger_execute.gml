//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_EXECUTE
// FUNCTION: Checks whether a triggering direct attack defeated its target.
//           Plays shared EXECUTE VFX/SFX and trigger feedback on success.
//
// ARGUMENTS: _ref_caster is the Beast responsible for the Execute.
//            _ref_target is the Beast struck by the triggering attack.
//            _flag_target_was_alive records whether the target was alive
//            immediately before the triggering attack.
// RETURNS: True if EXECUTE triggered; otherwise false.
//
//===============================================================================//

function scr_battle_trigger_execute(_ref_caster,_ref_target,_flag_target_was_alive){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return false;
	}

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!_flag_target_was_alive){
		return false;
	}

	//----------------//
	//TARGET SURVIVED//
	//----------------//
	if (_ref_target._val_cur_hp > 0){
		return false;
	}

	//================//
	//EXECUTE VFX//
	//================//
	scr_battle_vfx_execute(_ref_target);

	//================//
	//EXECUTE POPUP//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"EXECUTE",
		undefined,
		c_red,
		_ref_target.x,
		_ref_target.y - 48
	);

	//================//
	//DEBUG EXECUTE//
	//================//
	scr_debug_log_battle_trigger(
		"EXECUTE",
		_ref_caster,
		_ref_target,
		"TARGET DEFEATED",
		"SCR_BATTLE_TRIGGER_EXECUTE"
	);

	return true;
}