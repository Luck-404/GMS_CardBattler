//===============================================================================//
//
// SCRIPT: SCR_TRAP_THIN_ICE
// FUNCTION: Handles Thin Ice activation.
//           Applies Frostbite when the trapped Beast performs an Attack.
//           Consumes the Trap without cancelling the triggering Attack.
//
//===============================================================================//

function scr_trap_thin_ice(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

	switch(_str_tag){

		case "TRIGGER":

			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (!instance_exists(_ref_attacker)){
				return false;
			}

			if (
				_stct_card == undefined ||
				_stct_card._str_card_type != "ATTACK"
			){
				return false;
			}

			_ref_trap._flag_triggered =
				true;

			//----------------//
			//REVEAL TRAP//
			//----------------//
			scr_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: THIN ICE"
			);

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//----------------//
			//TARGET ATTACKER//
			//----------------//
			global.ref_target_beast =
				_ref_attacker;

			//----------------//
			//APPLY FROSTBITE//
			//----------------//
			repeat (_ref_trap._val_magnitude){

				scr_apply_dot_status(
					"FROSTBITE"
				);
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

			//-------------//
			//DESTROY TRAP//
			//-------------//
			scr_destroy_trap(
				_ref_trap
			);

			//---------------------//
			//DO NOT CANCEL ATTACK//
			//---------------------//
			return false;

		break;
	}

	return false;
}