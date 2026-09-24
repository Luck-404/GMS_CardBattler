//===============================================================================//
//
// SCRIPT: SCR_TRAP_THORN_NET
// FUNCTION: Handles Thorn Net activation.
//           Cancels the trapped Beast's next Attack.
//           Deals 4 neutral damage and applies Vulnerable if the Beast survives.
//           Reveals and consumes the Trap after activation.
//
// ARGUMENTS: _str_tag selects the Trap action, _ref_trap is the Trap instance,
//            _ref_attacker is the trapped Beast performing the Attack,
//            _ref_target is unused, and _stct_card is the triggering Attack.
// RETURNS: True when the trap successfully triggers; false otherwise.
//
//===============================================================================//

function scr_trap_thorn_net(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

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

			if (
				_ref_attacker._str_list != "ALIVE" ||
				_ref_attacker._val_cur_hp <= 0
			){
				return false;
			}

			_ref_trap._flag_triggered = true;

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: THORN NET"
			);

			//-----------------------//
			//VALIDATE TRAP CONTEXT//
			//-----------------------//
			if (
				!instance_exists(_ref_trap._ref_owner) ||
				!instance_exists(_ref_trap._ref_source_card) ||
				!is_struct(_ref_trap._ref_source_card._ref_card)
			){

				scr_trap_destroy(_ref_trap);

				return true;
			}

			//=====================//
			//STORE TRAP CONTEXT//
			//=====================//
			var _ref_trap_owner = _ref_trap._ref_owner;
			var _ref_source_card = _ref_trap._ref_source_card;
			var _stct_source_card = _ref_source_card._ref_card;
			var _val_magnitude = _ref_trap._val_magnitude;

			scr_debug_log_trap_trigger(
				_ref_trap,
				_ref_attacker,
				"CANCEL ATTACK: YES" +
				" | NEU DAMAGE: " + string(_val_magnitude) +
				" | VULNERABLE: YES",
				"SCR_TRAP_THORN_NET"
			);

			//======================//
			//STORE GLOBAL CONTEXT//
			//======================//
			var _ref_original_caster = global.ref_caster_beast;
			var _ref_original_card = global.ref_cast_card;
			var _str_original_stat = _stct_source_card._str_card_stat;

			//==================//
			//SET TRAP CONTEXT//
			//==================//
			global.ref_caster_beast = _ref_trap_owner;
			global.ref_cast_card = _ref_source_card;

			_stct_source_card._str_card_stat = "NEU";

			//================//
			//DEAL DAMAGE//
			//================//
			scr_battle_damage_target(
				"LINEAR",
				_ref_trap_owner,
				_ref_attacker,
				_val_magnitude,
				{card: _stct_source_card, card_instance: _ref_source_card}
			);

			//==================//
			//APPLY VULNERABLE//
			//==================//
			if (
				instance_exists(_ref_attacker) &&
				_ref_attacker._str_list == "ALIVE" &&
				_ref_attacker._val_cur_hp > 0
			){


				scr_status_apply_debuff("VULNERABLE", _ref_attacker);
			}

			//====================//
			//RESTORE CARD STAT//
			//====================//
			_stct_source_card._str_card_stat = _str_original_stat;

			//========================//
			//RESTORE GLOBAL CONTEXT//
			//========================//
			global.ref_caster_beast = _ref_original_caster;
			global.ref_cast_card = _ref_original_card;

			//================//
			//DESTROY TRAP//
			//================//
			if (instance_exists(_ref_trap)){
				scr_trap_destroy(_ref_trap);
			}

			//---------------//
			//CANCEL ATTACK//
			//---------------//
			return true;

		break;
	}

	return false;
}
