//===============================================================================//
//
// SCRIPT: SCR_TRAP_DISTRACTING_TRAP
// FUNCTION: Handles Distracting Trap activation.
//           Cancels the first enemy Attack targeting its host.
//           Grants Dodge, draws one card for the Trap owner,
//           reveals the Trap, and consumes it.
//
//===============================================================================//
function scr_trap_distracting_trap(
	_str_tag,
	_ref_trap,
	_ref_attacker,
	_ref_target,
	_stct_card
){

	switch(_str_tag){

		case "TRIGGER":

			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (!instance_exists(_ref_target)){
				return false;
			}

			//--------------------------------//
			//ONLY TRIGGER AGAINST ATTACK CARDS//
			//--------------------------------//
			if (_stct_card._str_card_type != "ATTACK"){
				return false;
			}

			_ref_trap._flag_triggered = true;

			//----------------//
			//REVEAL TRAP//
			//----------------//
			scr_spawn_popup("TEXT","DISTRACTING TRAP TRIGGERED",undefined,c_red,room_width/2,room_height/2 - 325);

			//-----------//
			//DRAW CARD//
			//-----------//
			if (_ref_trap._str_owner_team == "PLAYER"){
				scr_draw_cards(1);
			}

			//-------------//
			//DESTROY TRAP//
			//-------------//
			scr_destroy_trap(_ref_trap);

			//---------------//
			//ATTACK MISSES//
			//---------------//
			return true;

		break;
	}

	return false;
}