//===============================================================================//
//
// SCRIPT: SCR_TRAP_POWDER_KEG
// FUNCTION: Handles Powder Keg activation.
//           Triggers after the host takes direct damage.
//           Deals Linear PHY damage to its host and adjacent Beasts.
//           Uses the original Trap owner and source Card for damage scaling.
//           Consumes the Trap before dealing damage to prevent self-retriggering.
//
// ARGUMENTS: _str_tag selects the Trap action.
//            _ref_trap is the Powder Keg Trap instance.
//            _ref_attacker is unused.
//            _ref_target is the trapped Beast.
//            _stct_card is unused.
// RETURNS: True when the trap successfully triggers; false otherwise.
//
//===============================================================================//

function scr_trap_powder_keg(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

	switch (_str_tag){

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//================//
			//VALIDATE TRAP//
			//================//
			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (_ref_trap._flag_triggered){
				return false;
			}

			if (!instance_exists(_ref_target)){
				return false;
			}

			if (_ref_trap._ref_host != _ref_target){
				return false;
			}

			//=====================//
			//VALIDATE TRAP SOURCE//
			//=====================//
			if (
				!instance_exists(_ref_trap._ref_owner) ||
				!instance_exists(_ref_trap._ref_source_card) ||
				!is_struct(_ref_trap._ref_source_card._ref_card)
			){

				scr_trap_destroy(_ref_trap);

				return false;
			}

			//================//
			//STORE TRAP DATA//
			//================//
			var _ref_trap_owner = _ref_trap._ref_owner;
			var _ref_source_card = _ref_trap._ref_source_card;
			var _stct_source_card = _ref_source_card._ref_card;

			var _val_magnitude = _ref_trap._val_magnitude;

			//===================//
			//SNAPSHOT ADJACENCY//
			//===================//
			var _arr_targets = [
				_ref_target,
				scr_battle_get_left_target(_ref_target),
				scr_battle_get_right_target(_ref_target)
			];

			//================//
			//MARK TRIGGERED//
			//================//
			_ref_trap._flag_triggered = true;

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup_trigger_banner("TRAP TRIGGERED: POWDER KEG");

			//================//
			//CONSUME TRAP//
			//================//
			// Remove the Trap before applying damage.
			// Its explosion may trigger other damage Traps.

			scr_trap_destroy(_ref_trap);

			//======================//
			//STORE GLOBAL CONTEXT//
			//======================//
			var _ref_original_caster = global.ref_caster_beast;
			var _ref_original_card = global.ref_cast_card;

			var _str_original_stat = _stct_source_card._str_card_stat;

			//================//
			//SET TRAP CONTEXT//
			//================//
			global.ref_caster_beast = _ref_trap_owner;
			global.ref_cast_card = _ref_source_card;

			//--------------------//
			//FORCE PHYSICAL STAT//
			//--------------------//
			_stct_source_card._str_card_stat = "PHY";

			//==================//
			//RESOLVE EXPLOSION//
			//==================//
			for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

				var _ref_hit_target = _arr_targets[_it_target];

				//-----------------------//
				//CHECK REMAINING TARGET//
				//-----------------------//
				if (!instance_exists(_ref_hit_target)){
					continue;
				}

				if (
					_ref_hit_target._str_list != "ALIVE" ||
					_ref_hit_target._val_cur_hp <= 0
				){
					continue;
				}

				//================//
				//DEAL PHY DAMAGE//
				//================//

				scr_battle_damage_target(
					"LINEAR",
					_ref_trap_owner,
					_ref_hit_target,
					_val_magnitude,
					{card: _stct_source_card, card_instance: _ref_source_card}
				);
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

			return true;

		break;
	}

	return false;
}