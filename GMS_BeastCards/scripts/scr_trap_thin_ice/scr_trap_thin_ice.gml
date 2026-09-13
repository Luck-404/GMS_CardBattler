//===============================================================================//
//
// SCRIPT: SCR_TRAP_THIN_ICE
// FUNCTION: Handles Thin Ice activation.
//           Applies Frostbite when the trapped Beast performs an Attack.
//           Reveals and consumes the Trap without cancelling the Attack.
//
// ARGUMENTS: _str_tag selects the Trap action, _ref_trap is the Trap instance,
//            _ref_attacker is the trapped Beast performing the Attack,
//            _ref_target is unused, and _stct_card is the triggering card.
// RETURNS: False because Thin Ice does not cancel the triggering Attack.
//
//===============================================================================//

function scr_trap_thin_ice(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

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

			if (!instance_exists(_ref_attacker)){
				return false;
			}

			if (!is_struct(_stct_card)){
				return false;
			}

			if (_stct_card._str_card_type != "ATTACK"){
				return false;
			}

			if (_ref_attacker != _ref_trap._ref_host){
				return false;
			}

			var _ct_frostbite = max(0,floor(_ref_trap._val_magnitude));

			_ref_trap._flag_triggered = true;

			scr_debug_log_trap_trigger(
				_ref_trap,
				_ref_attacker,
				"FROSTBITE: +" + string(_ct_frostbite) +
				" | CANCEL ATTACK: NO",
				"SCR_TRAP_THIN_ICE"
			);

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: THIN ICE"
			);

			//======================//
			//STORE GLOBAL TARGET//
			//======================//
			var _ref_original_target = global.ref_target_beast;

			global.ref_target_beast = _ref_attacker;

			//================//
			//APPLY FROSTBITE//
			//================//
			repeat (_ct_frostbite){
				scr_status_apply_dot("FROSTBITE");
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

			//-------------------//
			//DO NOT CANCEL ATTACK//
			//-------------------//
			return false;

		break;
	}

	return false;
}