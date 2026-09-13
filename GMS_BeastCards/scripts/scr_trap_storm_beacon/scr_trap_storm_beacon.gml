//===============================================================================//
//
// SCRIPT: SCR_TRAP_STORM_BEACON
// FUNCTION: Handles Storm Beacon activation.
//           Applies Stormstruck to the trapped Beast after it successfully casts.
//           Reveals and consumes the Trap after activation.
//
// ARGUMENTS: _str_tag selects the Trap action, _ref_trap is the Trap instance,
//            _ref_caster is the trapped Beast that successfully cast,
//            while _ref_target and _stct_card are unused.
// RETURNS: True when Storm Beacon successfully triggers; otherwise false.
//
//===============================================================================//

function scr_trap_storm_beacon(_str_tag,_ref_trap,_ref_caster,_ref_target,_stct_card){

	switch (_str_tag){

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//-----------------//
			//VALIDATE CONTEXT//
			//-----------------//
			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (!instance_exists(_ref_caster)){
				return false;
			}

			var _ct_stormstruck = max(0,floor(_ref_trap._val_magnitude));

			_ref_trap._flag_triggered = true;
			
			scr_debug_log_trap_trigger(
				_ref_trap,
				_ref_caster,
				"STORMSTRUCK: +" + string(_ct_stormstruck) +
				" | CANCEL CAST: NO",
				"SCR_TRAP_STORM_BEACON"
			);

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: STORM BEACON"
			);

			//======================//
			//STORE GLOBAL TARGET//
			//======================//
			var _ref_original_target = global.ref_target_beast;

			global.ref_target_beast = _ref_caster;

			//===================//
			//APPLY STORMSTRUCK//
			//===================//
			repeat (_ct_stormstruck){
				scr_status_apply_dot("STORMSTRUCK");
			}

			//================//
			//RESTORE TARGET//
			//================//
			global.ref_target_beast = _ref_original_target;

			//================//
			//DESTROY TRAP//
			//================//
			if (instance_exists(_ref_trap)){
				scr_trap_destroy(_ref_trap);
			}

			return true;

		break;
	}

	return false;
}