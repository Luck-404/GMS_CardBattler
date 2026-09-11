//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_KRAKENS_CHOSEN
// FUNCTION: Handles Kraken's Chosen.
//           Infinite ST Aura.
//           Host is immune to CC.
//           Host summons Tentacles each round.
//           Host Attacks apply 2 Stormstruck.
//           Host Attacks may deal NEU splash to adjacent enemies.
//           Host loses 10% Maximum HP each round.
//           Host gains 1 Kraken's Wither each round.
//
//===============================================================================//

function scr_status_aura_krakens_chosen(
	_str_tag,
	_ref_status,
	_val_magnitude=undefined,
	_ref_attack_target=undefined
){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target =
				global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_status_check(
					"KRAKENS_CHOSEN",
					_ref_target
				);

			if (_ref_existing_status != -1){
				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			_ref_new_status._scr_status =
				scr_status_aura_krakens_chosen;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"AURA";

			_ref_new_status._str_status_name =
				"KRAKENS_CHOSEN";

			_ref_new_status._str_status_desc =
				"CC IMMUNE; SUMMONS TENTACLES; ATTACKS APPLY STORMSTRUCK";

			_ref_new_status._spr_status =
				spr_status_aura_krakens_chosen;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._flag_status_cc_immunity =
				true;

			_ref_new_status._val_hp_loss_percent =
				10;

			/*
				NOT DEFINED IN CURRENT CARD DATA.

				Set this later when the intended adjacent
				NEU damage value is finalized.
			*/
			_ref_new_status._val_adjacent_damage =
				undefined;

			_ref_new_status._str_aura_scope =
				"SELF";

			_ref_new_status._str_aura_trigger =
				"ATTACK";

			_ref_new_status._str_trigger_region =
				"END";

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;


		//---------//
		//TRIGGER//
		//---------//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (!instance_exists(_ref_attack_target)){
				return false;
			}

			if (
				_ref_attack_target._str_team ==
				_ref_host._str_team
			){
				return false;
			}

			if (_ref_attack_target._val_cur_hp <= 0){
				return false;
			}

			//----------------------//
			//STORE ORIGINAL TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//--------------//
			//TARGET ENEMY//
			//--------------//
			global.ref_target_beast =
				_ref_attack_target;

			//-------------------//
			//APPLY STORMSTRUCK//
			//-------------------//
			repeat (2){

				scr_status_apply_dot(
					"STORMSTRUCK"
				);
			}

			//-------------------//
			//ADJACENT NEU DAMAGE//
			//-------------------//
			if (
				_ref_status._val_adjacent_damage != undefined &&
				_ref_status._val_adjacent_damage > 0
			){

				var _arr_adjacent = [
					scr_battle_get_left_target(_ref_attack_target),
					scr_battle_get_right_target(_ref_attack_target)
				];

				for (
					var _it_target = 0;
					_it_target < array_length(_arr_adjacent);
					_it_target++
				){

					var _ref_adjacent_target =
						_arr_adjacent[_it_target];

					if (!instance_exists(_ref_adjacent_target)){
						continue;
					}

					if (
						_ref_adjacent_target._str_team ==
						_ref_host._str_team
					){
						continue;
					}

					if (_ref_adjacent_target._val_cur_hp <= 0){
						continue;
					}

					global.ref_target_beast =
						_ref_adjacent_target;

					scr_battle_damage_target(
						_ref_status._val_adjacent_damage,
						_ref_adjacent_target
					);
				}
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

			return true;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_status_destroy(_ref_status);

				return undefined;
			}

			if (_ref_host._val_cur_hp <= 0){
				return undefined;
			}

			//----------------//
			//SUMMON TENTACLE//
			//----------------//
			if (scr_minion_has_open_slot(_ref_host)){

				scr_minion_init(
					"TENTACLE",
					undefined,
					_ref_host,
					_ref_host
				);
			}

			//----------------------//
			//LOSE 10% MAXIMUM HP//
			//----------------------//
			var _val_hp_loss =
				max(
					1,
					ceil(
						_ref_host._val_max_hp *
						(_ref_status._val_hp_loss_percent / 100)
					)
				);

			var _val_actual_hp_loss =
				min(
					_ref_host._val_cur_hp,
					_val_hp_loss
				);

			_ref_host._val_cur_hp -=
				_val_actual_hp_loss;

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_actual_hp_loss),
				undefined,
				c_maroon,
				_ref_host.x + irandom_range(-32,32),
				_ref_host.y - 24 + irandom_range(-32,32)
			);

			if (_ref_host._val_cur_hp <= 0){
				return undefined;
			}

			//----------------------//
			//STORE ORIGINAL TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//--------------//
			//TARGET HOST//
			//--------------//
			global.ref_target_beast =
				_ref_host;

			//--------------//
			//APPLY WITHER//
			//--------------//
			scr_status_apply_debuff(
				"WITHER",
				3
			);

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}