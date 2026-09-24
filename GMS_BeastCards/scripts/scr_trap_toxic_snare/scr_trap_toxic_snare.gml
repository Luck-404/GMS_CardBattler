//===============================================================================//
//
// SCRIPT: SCR_TRAP_TOXIC_SNARE
// FUNCTION: Handles Toxic Snare activation.
//           Triggers when its host reaches 5 total DoT stacks or 3 different DoTs.
//           Stuns the host and applies 2 Poison to each adjacent living Beast.
//           Reveals and consumes the Trap before applying adjacent Poison.
//
// ARGUMENTS: _str_tag selects the Trap action, _ref_trap is the Trap instance,
//            _ref_target is the trapped Beast whose DoTs reached the threshold,
//            while _ref_attacker and _stct_card are unused.
// RETURNS: True when the trap successfully triggers; false otherwise.
//
//===============================================================================//

function scr_trap_toxic_snare(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

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

			if (_ref_target != _ref_trap._ref_host){
				return false;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0
			){
				return false;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return false;
			}

			//==================//
			//COUNT ACTIVE DOTS//
			//==================//
			var _ct_dot_types = 0;
			var _ct_dot_stacks = 0;

			for (var _it_status = 0;_it_status < ds_list_size(_ref_target._list_statuses);_it_status++){

				var _ref_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

				if (!instance_exists(_ref_status)){
					continue;
				}

				if (_ref_status._str_status_type != "DOT"){
					continue;
				}

				_ct_dot_types++;
				_ct_dot_stacks += max(0,_ref_status._ct_status_stacks);
			}

			//================//
			//CHECK THRESHOLD//
			//================//
			if (
				_ct_dot_stacks < 5 &&
				_ct_dot_types < 3
			){
				return false;
			}

			_ref_trap._flag_triggered = true;

			scr_debug_log_trap_trigger(
				_ref_trap,
				_ref_target,
				"DOT STACKS: " + string(_ct_dot_stacks) +
				" | DOT TYPES: " + string(_ct_dot_types) +
				" | STUN: 1 ROUND" +
				" | ADJACENT POISON: +2",
				"SCR_TRAP_TOXIC_SNARE"
			);

			//==================//
			//TRAP TRIGGER VFX//
			//==================//
			scr_battle_vfx_trap_trigger(_ref_trap);

			//================//
			//REVEAL TRAP//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: TOXIC SNARE"
			);

			//======================//
			//GET ADJACENT TARGETS//
			//======================//
			var _ref_left_target = scr_battle_get_left_target(_ref_target);
			var _ref_right_target = scr_battle_get_right_target(_ref_target);

			//=====================//
			//STORE TRAP CONTEXT//
			//=====================//
			var _ref_trap_owner = _ref_trap._ref_owner;
			var _ref_source_card = _ref_trap._ref_source_card;

			//======================//
			//STORE GLOBAL CONTEXT//
			//======================//
			var _ref_original_caster = global.ref_caster_beast;
			var _ref_original_card = global.ref_cast_card;

			//================//
			//STUN HOST//
			//================//

			scr_status_apply_cc("STUN", _ref_target, 1);

			//================//
			//DESTROY TRAP//
			//================//
			scr_trap_destroy(_ref_trap);

			//==================//
			//SET TRAP CONTEXT//
			//==================//
			if (instance_exists(_ref_trap_owner)){
				global.ref_caster_beast = _ref_trap_owner;
			}

			if (instance_exists(_ref_source_card)){
				global.ref_cast_card = _ref_source_card;
			}

			//====================//
			//POISON LEFT TARGET//
			//====================//
			if (
				instance_exists(_ref_left_target) &&
				_ref_left_target._str_list == "ALIVE" &&
				_ref_left_target._val_cur_hp > 0
			){


				repeat (2){
					scr_status_apply_dot("POISON", _ref_left_target);
				}
			}

			//=====================//
			//POISON RIGHT TARGET//
			//=====================//
			if (
				instance_exists(_ref_right_target) &&
				_ref_right_target._str_list == "ALIVE" &&
				_ref_right_target._val_cur_hp > 0
			){


				repeat (2){
					scr_status_apply_dot("POISON", _ref_right_target);
				}
			}

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
