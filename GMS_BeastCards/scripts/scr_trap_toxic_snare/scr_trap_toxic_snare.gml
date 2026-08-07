//===============================================================================//
//
// SCRIPT: SCR_TRAP_TOXIC_SNARE
// FUNCTION: Handles Toxic Snare activation.
//           Triggers when its host reaches five total DoT stacks
//           or three different active DoTs.
//           Stuns the host and applies two Poison to adjacent Beasts.
//
//===============================================================================//
function scr_trap_toxic_snare(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

	switch(_str_tag){

		case "TRIGGER":

			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (!instance_exists(_ref_target)){
				return false;
			}

			//----------------//
			//COUNT ACTIVE DOTS//
			//----------------//
			var _ct_dot_types = 0;
			var _ct_dot_stacks = 0;

			for (
				var _it_status = 0;
				_it_status < ds_list_size(_ref_target._list_statuses);
				_it_status++
			){

				var _ref_status = ds_list_find_value(
					_ref_target._list_statuses,
					_it_status
				);

				if (!instance_exists(_ref_status)){
					continue;
				}

				if (_ref_status._str_status_type != "DOT"){
					continue;
				}

				_ct_dot_types++;

				_ct_dot_stacks +=
					_ref_status._ct_status_stacks;
			}

			//----------------//
			//CHECK THRESHOLD//
			//----------------//
			if (
				_ct_dot_stacks < 5 &&
				_ct_dot_types < 3
			){
				return false;
			}

			_ref_trap._flag_triggered =
				true;

			//----------------//
			//REVEAL TRAP//
			//----------------//
			scr_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: TOXIC SNARE"
			);

			//----------------------//
			//GET ADJACENT TARGETS//
			//----------------------//
			var _ref_left_target =
				scr_get_left_target(_ref_target);

			var _ref_right_target =
				scr_get_right_target(_ref_target);

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//-----------//
			//STUN HOST//
			//-----------//
			global.ref_target_beast =
				_ref_target;

			scr_apply_cc_status("STUN");

			//-------------------//
			//DESTROY TRAP FIRST//
			//-------------------//
			scr_destroy_trap(
				_ref_trap
			);

			//--------------------//
			//POISON LEFT TARGET//
			//--------------------//
			if (
				instance_exists(_ref_left_target) &&
				_ref_left_target._val_cur_hp > 0
			){

				global.ref_target_beast =
					_ref_left_target;

				repeat (2){
					scr_apply_dot_status("POISON");
				}
			}

			//---------------------//
			//POISON RIGHT TARGET//
			//---------------------//
			if (
				instance_exists(_ref_right_target) &&
				_ref_right_target._val_cur_hp > 0
			){

				global.ref_target_beast =
					_ref_right_target;

				repeat (2){
					scr_apply_dot_status("POISON");
				}
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

			return true;

		break;
	}

	return false;
}