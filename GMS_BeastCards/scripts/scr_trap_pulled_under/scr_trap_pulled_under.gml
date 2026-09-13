//===============================================================================//
//
// SCRIPT: SCR_TRAP_PULLED_UNDER
// FUNCTION: Handles Pulled Under activation.
//           Banishes the first Beast on the trapped team that receives healing.
//           Resolves after the healing event and then consumes the team Trap.
//
// ARGUMENTS: _str_tag selects the Trap action, _ref_trap is the Trap instance,
//            _ref_attacker is unused, _ref_target is the healed Beast, and
//            _stct_card is unused.
// RETURNS: False because Pulled Under does not cancel the healing event.
//
//===============================================================================//

function scr_trap_pulled_under(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

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

			if (!instance_exists(_ref_target)){
				return false;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0
			){
				return false;
			}

			if (_ref_target._str_team != _ref_trap._str_target_team){
				return false;
			}

			_ref_trap._flag_triggered = true;

			scr_debug_log_trap_trigger(
				_ref_trap,
				_ref_target,
				"BANISH: 1 ROUND | CANCEL HEAL: NO",
				"SCR_TRAP_PULLED_UNDER"
			);

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//TRAP FEEDBACK//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: PULLED UNDER"
			);

			//======================//
			//STORE GLOBAL TARGET//
			//======================//
			var _ref_original_target = global.ref_target_beast;

			global.ref_target_beast = _ref_target;

			//================//
			//APPLY BANISH//
			//================//
			scr_status_apply_cc(
				"BANISH",
				1
			);

			//================//
			//RESTORE TARGET//
			//================//
			global.ref_target_beast = _ref_original_target;

			//================//
			//DESTROY TRAP//
			//================//
			scr_trap_destroy(_ref_trap);

			//--------------------//
			//DO NOT CANCEL HEAL//
			//--------------------//
			return false;

		break;
	}

	return false;
}