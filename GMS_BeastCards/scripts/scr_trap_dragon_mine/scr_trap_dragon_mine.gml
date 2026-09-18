//===============================================================================//
//
// SCRIPT: SCR_TRAP_DRAGON_MINE
// FUNCTION: Handles Dragon Mine activation.
//           Triggers before the trapped Beast's next Attack.
//           Deals Linear MAG damage using the original Dragon Mine Card and
//           Trap owner as the damage source.
//           Applies 3 Burn if the trapped Beast survives.
//           Reveals and consumes the Trap after activation.
//
//           Does not cancel the triggering Attack unless the Trap defeats
//           the attacking Beast.
//
// ARGUMENTS: _str_tag selects the Trap action.
//            _ref_trap is the Dragon Mine Trap instance.
//            _ref_attacker is the trapped Beast performing the Attack.
//            _ref_target is the target of the triggering Attack.
//            _stct_card is the triggering Attack Card.
// RETURNS: True if Dragon Mine defeats the attacker and therefore cancels the
//          Attack; otherwise false.
//
//===============================================================================//

function scr_trap_dragon_mine(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

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

			//-----------------------//
			//VALIDATE TRAP CONTEXT//
			//-----------------------//
			if (
				!instance_exists(_ref_trap._ref_owner) ||
				!instance_exists(_ref_trap._ref_source_card) ||
				!is_struct(_ref_trap._ref_source_card._ref_card)
			){

				scr_trap_destroy(_ref_trap);

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

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(
				_ref_trap
			);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: DRAGON MINE"
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
			global.ref_target_beast = _ref_attacker;
			global.ref_cast_card = _ref_source_card;

			// Dragon Mine's Card STAT remains NEU in its data,
			// but its triggered damage explicitly resolves as MAG.
			_stct_source_card._str_card_stat = "MAG";

			//===================//
			//DEAL MAGICAL DAMAGE//
			//===================//
			scr_battle_damage_target(
				_val_magnitude,
				_ref_attacker
			);

			//================//
			//APPLY 3 BURN//
			//================//
			if (
				instance_exists(_ref_attacker) &&
				_ref_attacker._str_list == "ALIVE" &&
				_ref_attacker._val_cur_hp > 0
			){

				global.ref_target_beast = _ref_attacker;

				repeat (3){
					scr_status_apply_dot("BURN");
				}
			}

			//=====================//
			//CHECK ATTACKER STATE//
			//=====================//
			var _flag_cancel_attack = (
				!instance_exists(_ref_attacker) ||
				_ref_attacker._str_list != "ALIVE" ||
				_ref_attacker._val_cur_hp <= 0
			);

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

			return _flag_cancel_attack;

		break;
	}

	return false;
}