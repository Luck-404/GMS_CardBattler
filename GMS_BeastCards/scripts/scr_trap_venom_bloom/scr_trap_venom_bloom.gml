//===============================================================================//
//
// SCRIPT: SCR_TRAP_VENOM_BLOOM
// FUNCTION: Handles Venom Bloom activation.
//           When its host dies, applies 1 Poison to each adjacent living Beast.
//           Summons 1 Sporeling on each affected Beast.
//           Reveals and consumes the Trap before resolving those effects.
//
// ARGUMENTS: _str_tag selects the Trap action, _ref_trap is the Trap instance,
//            while _ref_attacker, _ref_target, and _stct_card are unused.
// RETURNS: True when Venom Bloom successfully triggers; otherwise false.
//
//===============================================================================//

function scr_trap_venom_bloom(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

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

			var _ref_host = _ref_trap._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			//================//
			//GET TEAM LIST//
			//================//
			var _list_team = undefined;

			if (_ref_host._str_team == "PLAYER"){

				if (!instance_exists(obj_battle_player_controller)){
					return false;
				}

				_list_team = obj_battle_player_controller._list_beasts_alive;
			}
			else if (_ref_host._str_team == "ENEMY"){

				if (!instance_exists(obj_battle_enemy_controller)){
					return false;
				}

				_list_team = obj_battle_enemy_controller._list_beasts_alive;
			}
			else{
				return false;
			}

			if (!ds_exists(_list_team,ds_type_list)){
				return false;
			}

			//================//
			//GET HOST INDEX//
			//================//
			var _it_host = ds_list_find_index(_list_team,_ref_host);

			if (_it_host == -1){
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
				"TRAP TRIGGERED: VENOM BLOOM"
			);

			//======================//
			//GET ADJACENT BEASTS//
			//======================//
			var _ref_left_target = undefined;
			var _ref_right_target = undefined;

			if (_it_host > 0){
				_ref_left_target = ds_list_find_value(_list_team,_it_host - 1);
			}

			if (_it_host < ds_list_size(_list_team) - 1){
				_ref_right_target = ds_list_find_value(_list_team,_it_host + 1);
			}

			var _arr_targets = [
				_ref_left_target,
				_ref_right_target
			];

			//=====================//
			//STORE TRAP CONTEXT//
			//=====================//
			var _ref_trap_owner = _ref_trap._ref_owner;
			var _ref_source_card = _ref_trap._ref_source_card;

			//======================//
			//STORE GLOBAL CONTEXT//
			//======================//
			var _ref_original_caster = global.ref_caster_beast;
			var _ref_original_target = global.ref_target_beast;
			var _ref_original_card = global.ref_cast_card;

			var _ct_affected_targets = 0;

			for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

				var _ref_affected_target = _arr_targets[_it_target];

				if (
					instance_exists(_ref_affected_target) &&
					_ref_affected_target._str_list == "ALIVE" &&
					_ref_affected_target._val_cur_hp > 0
				){
					_ct_affected_targets++;
				}
			}

			scr_debug_log_trap_trigger(
				_ref_trap,
				_ref_host,
				"HOST DEATH" +
				" | ADJACENT TARGETS: " + string(_ct_affected_targets) +
				" | EACH: +1 POISON + 1 SPORELING",
				"SCR_TRAP_VENOM_BLOOM"
			);

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

			//==========================//
			//POISON + SUMMON SPORELING//
			//==========================//
			for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

				var _ref_affected_target = _arr_targets[_it_target];

				if (!instance_exists(_ref_affected_target)){
					continue;
				}

				if (
					_ref_affected_target._str_list != "ALIVE" ||
					_ref_affected_target._val_cur_hp <= 0
				){
					continue;
				}

				//----------------//
				//APPLY POISON//
				//----------------//
				global.ref_target_beast = _ref_affected_target;

				scr_status_apply_dot("POISON");

				//------------------//
				//SUMMON SPORELING//
				//------------------//
				scr_minion_init(
					"SPORELING",
					undefined,
					_ref_trap_owner,
					_ref_affected_target
				);
			}

			//========================//
			//RESTORE GLOBAL CONTEXT//
			//========================//
			global.ref_caster_beast = _ref_original_caster;
			global.ref_target_beast = _ref_original_target;
			global.ref_cast_card = _ref_original_card;

			return true;

		break;
	}

	return false;
}