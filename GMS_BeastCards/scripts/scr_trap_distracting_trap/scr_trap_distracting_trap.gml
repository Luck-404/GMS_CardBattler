//===============================================================================//
//
// SCRIPT: SCR_TRAP_DISTRACTING_TRAP
// FUNCTION: Handles Distracting Trap activation.
//           Cancels the first Attack targeting its host.
//           Draws 1 card for the player Trap owner.
//           Reveals and consumes the Trap.
//
// ARGUMENTS: _str_tag selects the Trap action, _ref_trap is the Trap instance,
//            _ref_attacker is the acting Beast, _ref_target is the trapped Beast,
//            and _stct_card is the incoming card.
// RETURNS: True when the Trap triggers and cancels the Attack; otherwise false.
//
//===============================================================================//

function scr_trap_distracting_trap(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

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

			if (!is_struct(_stct_card)){
				return false;
			}

			//-------------------------//
			//ONLY TRIGGER ON ATTACKS//
			//-------------------------//
			if (_stct_card._str_card_type != "ATTACK"){
				return false;
			}

			_ref_trap._flag_triggered = true;

			scr_debug_log_trap_trigger(
				_ref_trap,
				_ref_target,
				"CANCEL ATTACK: YES" +
				(_ref_trap._str_owner_team == "PLAYER" ? " | DRAW: 1" : ""),
				"SCR_TRAP_DISTRACTING_TRAP"
			);

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup(
				"TEXT",
				"DISTRACTING TRAP TRIGGERED",
				undefined,
				c_red,
				room_width / 2,
				room_height / 2 - 325
			);

			//================//
			//DRAW CARD//
			//================//
			if (_ref_trap._str_owner_team == "PLAYER"){
				scr_battle_draw_cards(1);
			}

			//================//
			//DESTROY TRAP//
			//================//
			scr_trap_destroy(_ref_trap);

			//----------------//
			//CANCEL ATTACK//
			//----------------//
			return true;

		break;
	}

	return false;
}