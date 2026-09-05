//===============================================================================//
//
// SCRIPT: SCR_TRAP_STORM_BEACON
// FUNCTION: Handles Storm Beacon activation.
//           Applies 3 Stormstruck when the trapped Beast successfully casts.
//           Consumes the Trap after activation.
//
//===============================================================================//

function scr_trap_storm_beacon(_str_tag,_ref_trap,_ref_caster,_ref_target,_stct_card){

	switch(_str_tag){

		case "TRIGGER":

			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (!instance_exists(_ref_caster)){
				return false;
			}

			_ref_trap._flag_triggered =
				true;

			//----------------//
			//REVEAL TRAP//
			//----------------//
			scr_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: STORM BEACON"
			);

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//--------------//
			//TARGET CASTER//
			//--------------//
			global.ref_target_beast =
				_ref_caster;

			//-------------------//
			//APPLY STORMSTRUCK//
			//-------------------//
			repeat (_ref_trap._val_magnitude){
				scr_apply_dot_status("STORMSTRUCK");
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

			return true;

		break;
	}

	return false;
}