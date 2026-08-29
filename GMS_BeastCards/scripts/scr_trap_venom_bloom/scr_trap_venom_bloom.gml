//===============================================================================//
//
// SCRIPT: SCR_TRAP_VENOM_BLOOM
// FUNCTION: Handles Venom Bloom activation.
//           When its host dies, applies Poison to adjacent living Beasts.
//           Summons a Sporeling on each affected Beast.
//           Consumes the Trap after activation.
//
//===============================================================================//
function scr_trap_venom_bloom(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

	switch(_str_tag){

		case "TRIGGER":

			if (!instance_exists(_ref_trap)){
				return false;
			}

			var _ref_host = _ref_trap._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			//--------------------------------//
			//GET HOST TEAM FORMATION DIRECTLY//
			//--------------------------------//
			var _list_team = undefined;

			if (_ref_host._str_team == "PLAYER"){
				_list_team = obj_battle_player_controller._list_beasts_alive;
			}
			else if (_ref_host._str_team == "ENEMY"){
				_list_team = obj_battle_enemy_controller._list_beasts_alive;
			}

			if (_list_team == undefined){
				return false;
			}

			//----------------//
			//GET HOST INDEX//
			//----------------//
			var _it_host = ds_list_find_index(_list_team,_ref_host);

			if (_it_host == -1){
				return false;
			}

			_ref_trap._flag_triggered = true;

			//----------------//
			//REVEAL TRAP//
			//----------------//
			scr_spawn_popup_trigger_banner("TRAP TRIGGERED: VENOM BLOOM");

			//----------------------//
			//GET ADJACENT BEASTS//
			//----------------------//
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

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target = global.ref_target_beast;

			//-----------------------//
			//POISON + SPAWN SPORES//
			//-----------------------//
			for (var _it_target = 0; _it_target < array_length(_arr_targets); _it_target++){

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

				//--------------//
				//APPLY POISON//
				//--------------//
				global.ref_target_beast = _ref_affected_target;

				scr_apply_dot_status("POISON");

				//------------------//
				//SUMMON SPORELING//
				//------------------//
				scr_init_minion("SPORELING",undefined,_ref_trap._ref_owner,_ref_affected_target);
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast = _ref_original_target;

			//-------------//
			//DESTROY TRAP//
			//-------------//
			scr_destroy_trap(_ref_trap);

			return true;

		break;
	}

	return false;
}