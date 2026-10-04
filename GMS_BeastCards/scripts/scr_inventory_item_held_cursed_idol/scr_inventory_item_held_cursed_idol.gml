//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_CURSED_IDOL
// FUNCTION: Handles Cursed Idol Held Item behavior.
//
//           On battle ENTRY:
//           - Finds all living Beasts on the holder's opposing team.
//           - Selects one valid enemy at random.
//           - Attempts to apply WITHER x3 for 3 turns through the normal Debuff
//             application pipeline.
//
//           WITHER remains subject to normal CON resistance.
//           Cursed Idol is not consumed when it triggers.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Cursed Idol Held Item struct.
//            _ref_target - Persistent Beast struct for EQUIP/UNEQUIP, or the
//                          live battle Beast holder for TRIGGER.
// RETURNS: True when the requested state resolves successfully.
//
//===============================================================================//

function scr_inventory_item_held_cursed_idol(_str_state,_stct_item,_ref_target){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":

			return is_struct(_ref_target);

		case "TRIGGER":

			//================//
			//VALIDATE HOLDER//
			//================//
			if (!instance_exists(_ref_target)){
				return false;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0
			){
				return false;
			}

			//====================//
			//GET OPPOSING TEAM//
			//====================//
			var _list_enemies = undefined;

			switch (
				string_upper(
					string(
						_ref_target._str_team
					)
				)
			){

				case "PLAYER":

					if (
						instance_exists(
							obj_battle_enemy_controller
						)
					){

						_list_enemies =
							obj_battle_enemy_controller
								._list_beasts_alive;
					}

				break;

				case "ENEMY":

					if (
						instance_exists(
							obj_battle_player_controller
						)
					){

						_list_enemies =
							obj_battle_player_controller
								._list_beasts_alive;
					}

				break;
			}

			if (
				_list_enemies == undefined ||
				!ds_exists(
					_list_enemies,
					ds_type_list
				)
			){
				return false;
			}

			//================//
			//BUILD CANDIDATES//
			//================//
			var _arr_candidates = [];

			for (
				var _it_enemy = 0;
				_it_enemy <
					ds_list_size(
						_list_enemies
					);
				_it_enemy++
			){

				var _ref_enemy =
					ds_list_find_value(
						_list_enemies,
						_it_enemy
					);

				if (!instance_exists(_ref_enemy)){
					continue;
				}

				if (
					_ref_enemy._str_list != "ALIVE" ||
					_ref_enemy._val_cur_hp <= 0
				){
					continue;
				}

				array_push(
					_arr_candidates,
					_ref_enemy
				);
			}

			if (
				array_length(
					_arr_candidates
				) <= 0
			){
				return false;
			}

			//================//
			//RANDOM ENEMY//
			//================//
			var _ref_enemy =
				_arr_candidates[
					irandom(
						array_length(
							_arr_candidates
						) - 1
					)
				];

			if (!instance_exists(_ref_enemy)){
				return false;
			}

			//================//
			//APPLY WITHER x3//
			//================//
			var _ref_wither =
				scr_status_apply_debuff(
					"WITHER",
					_ref_enemy,
					3,
					3
				);

			return instance_exists(_ref_wither);

		case "UNEQUIP":

			return is_struct(_ref_target);
	}

	#endregion

	return false;
}