//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_ROUGH_SEAS
// FUNCTION: Handles Rough Seas.
//           Infinite Team Aura.
//           Damaged enemies are randomly repositioned 1 position.
//           Allied Beasts take 10% increased damage.
//
//===============================================================================//

function scr_status_aura_rough_seas(
	_str_tag,
	_ref_status,
	_val_magnitude=undefined,
	_ref_trigger_target=undefined
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

			//--------------//
			//GET TEAM LIST//
			//--------------//
			var _list_team =
				undefined;

			if (_ref_target._str_team == "PLAYER"){

				_list_team =
					obj_battle_player_controller._list_beasts;
			}
			else{

				_list_team =
					obj_battle_enemy_controller._list_beasts;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_team);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_team,
						_it_beast
					);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				var _ref_existing_status =
					scr_status_check(
						"ROUGH_SEAS",
						_ref_beast
					);

				if (_ref_existing_status != -1){
					return _ref_existing_status;
				}
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
				scr_status_aura_rough_seas;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"AURA";

			_ref_new_status._str_status_name =
				"ROUGH_SEAS";

			_ref_new_status._str_status_desc =
				"ENEMIES MOVE WHEN DAMAGED; ALLIES TAKE 10% MORE DAMAGE";

			_ref_new_status._spr_status =
				spr_status_aura_rough_seas;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				0;

			_ref_new_status._val_aura_damage_taken_bonus =
				10;

			_ref_new_status._str_trigger_region =
				undefined;

			_ref_new_status._str_aura_scope =
				"TEAM";

			_ref_new_status._str_aura_trigger =
				"ENEMY_DAMAGED";

			//------------------------//
			//INCREASE ALLIED DAMAGE//
			//------------------------//
			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_team);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_team,
						_it_beast
					);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				_ref_beast._val_dmg_taken_scalar_bonus +=
					_ref_new_status._val_aura_damage_taken_bonus;
			}

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

			if (!instance_exists(_ref_trigger_target)){
				return false;
			}

			if (_ref_trigger_target._val_cur_hp <= 0){
				return false;
			}

			if (
				_ref_trigger_target._str_team ==
				_ref_host._str_team
			){
				return false;
			}

			//----------------//
			//GET TARGET TEAM//
			//----------------//
			var _list_target_team =
				undefined;

			if (_ref_trigger_target._str_team == "PLAYER"){

				_list_target_team =
					obj_battle_player_controller._list_beasts_alive;
			}
			else{

				_list_target_team =
					obj_battle_enemy_controller._list_beasts_alive;
			}

			var _val_position =
				ds_list_find_index(
					_list_target_team,
					_ref_trigger_target
				);

			if (_val_position == -1){
				return false;
			}

			//----------------------//
			//BUILD VALID MOVEMENTS//
			//----------------------//
			var _arr_moves = [];

			if (_val_position > 0){
				array_push(_arr_moves,-1);
			}

			if (
				_val_position <
				ds_list_size(_list_target_team) - 1
			){
				array_push(_arr_moves,1);
			}

			if (array_length(_arr_moves) <= 0){
				return false;
			}

			//----------------------//
			//SELECT RANDOM MOVEMENT//
			//----------------------//
			var _val_move =
				_arr_moves[
					irandom(
						array_length(_arr_moves) - 1
					)
				];

			//----------//
			//FEEDBACK//
			//----------//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"ROUGH SEAS",
				undefined,
				c_aqua,
				_ref_trigger_target.x,
				_ref_trigger_target.y - 48
			);

			//------------//
			//REPOSITION//
			//------------//
			return scr_battle_reposition_beast(
				_ref_trigger_target,
				_val_move
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (instance_exists(_ref_host)){

				var _list_team =
					undefined;

				if (_ref_host._str_team == "PLAYER"){

					_list_team =
						obj_battle_player_controller._list_beasts;
				}
				else{

					_list_team =
						obj_battle_enemy_controller._list_beasts;
				}

				//-----------------------//
				//RESTORE ALLIED DAMAGE//
				//-----------------------//
				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(_list_team);
					_it_beast++
				){

					var _ref_beast =
						ds_list_find_value(
							_list_team,
							_it_beast
						);

					if (!instance_exists(_ref_beast)){
						continue;
					}

					_ref_beast._val_dmg_taken_scalar_bonus =
						max(
							0,
							_ref_beast._val_dmg_taken_scalar_bonus -
							_ref_status._val_aura_damage_taken_bonus
						);
				}
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}