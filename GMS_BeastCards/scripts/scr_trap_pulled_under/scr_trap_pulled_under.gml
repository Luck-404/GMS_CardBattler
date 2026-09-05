//===============================================================================//
//
// SCRIPT: SCR_TRAP_PULLED_UNDER
// FUNCTION: Handles Pulled Under activation.
//           Banished the first Beast on the trapped team that receives healing.
//           Consumes the team Trap after the healing event.
//
//===============================================================================//

function scr_trap_pulled_under(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

	switch(_str_tag){

		case "TRIGGER":

			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (!instance_exists(_ref_target)){
				return false;
			}

			_ref_trap._flag_triggered =
				true;

			//-------------//
			//TRAP FEEDBACK//
			//-------------//
			scr_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: PULLED UNDER"
			);

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//----------------//
			//TARGET HEALED BEAST//
			//----------------//
			global.ref_target_beast =
				_ref_target;

			//--------------//
			//APPLY BANISH//
			//--------------//
			scr_apply_cc_status(
				"BANISH",
				1
			);

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

			//--------------------//
			//DO NOT CANCEL HEAL//
			//--------------------//
			return false;

		break;
	}

	return false;
}