//===============================================================================//
//
// SCRIPT: SCR_TRAP_ROTTING_SPORES
// FUNCTION: Handles Rotting Spores activation.
//           Cancels the next healing received by its host.
//           Deals 5 magical damage and applies 1 Venom if the host survives.
//           Reveals and consumes the Trap after activation.
//
// ARGUMENTS: _str_tag selects the Trap action, _ref_trap is the Trap instance,
//            _ref_attacker is unused, _ref_target is the Beast being healed,
//            and _stct_card is unused.
// RETURNS: True when Rotting Spores triggers and cancels the heal; otherwise false.
//
//===============================================================================//

function scr_trap_rotting_spores(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

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

			if (_ref_target != _ref_trap._ref_host){
				return false;
			}

			if (!instance_exists(_ref_trap._ref_owner)){
				return false;
			}

			if (!instance_exists(_ref_trap._ref_source_card)){
				return false;
			}

			if (!is_struct(_ref_trap._ref_source_card._ref_card)){
				return false;
			}

			//=====================//
			//STORE TRAP CONTEXT//
			//=====================//
			var _ref_trap_owner = _ref_trap._ref_owner;
			var _ref_source_card = _ref_trap._ref_source_card;
			var _stct_source_card = _ref_source_card._ref_card;
			var _val_magnitude = _ref_trap._val_magnitude;

			_ref_trap._flag_triggered = true;
			
			scr_debug_log_trap_trigger(
				_ref_trap,
				_ref_target,
				"CANCEL HEAL: YES" +
				" | MAG DAMAGE: " + string(_val_magnitude) +
				" | VENOM: +1",
				"SCR_TRAP_ROTTING_SPORES"
			);

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: ROTTING SPORES"
			);

			//======================//
			//STORE GLOBAL CONTEXT//
			//======================//
			var _ref_original_caster = global.ref_caster_beast;
			var _ref_original_target = global.ref_target_beast;
			var _ref_original_card = global.ref_cast_card;
			var _str_original_stat = _stct_source_card._str_card_stat;

			//==================//
			//SET TRAP CONTEXT//
			//==================//
			global.ref_caster_beast = _ref_trap_owner;
			global.ref_target_beast = _ref_target;
			global.ref_cast_card = _ref_source_card;

			_stct_source_card._str_card_stat = "MAG";

			//=====================//
			//DEAL MAGICAL DAMAGE//
			//=====================//
			scr_battle_damage_target(
				_val_magnitude,
				_ref_target
			);

			//================//
			//APPLY VENOM//
			//================//
			if (
				instance_exists(_ref_target) &&
				_ref_target._str_list == "ALIVE" &&
				_ref_target._val_cur_hp > 0
			){

				global.ref_target_beast = _ref_target;

				scr_status_apply_dot("VENOM");
			}

			//====================//
			//RESTORE CARD STAT//
			//====================//
			_stct_source_card._str_card_stat = _str_original_stat;

			//========================//
			//RESTORE GLOBAL CONTEXT//
			//========================//
			global.ref_caster_beast = _ref_original_caster;
			global.ref_target_beast = _ref_original_target;
			global.ref_cast_card = _ref_original_card;

			//================//
			//DESTROY TRAP//
			//================//
			if (instance_exists(_ref_trap)){
				scr_trap_destroy(_ref_trap);
			}

			//----------------//
			//CANCEL HEALING//
			//----------------//
			return true;

		break;
	}

	return false;
}