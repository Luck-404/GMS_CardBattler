//===============================================================================//
//
// SCRIPT: SCR_STATUS_REMOVE_BLOODMIST_BLIND
// FUNCTION: Removes Bloodmist's Infinite override from the generic BLIND Status.
//
//           Blind created solely by Bloodmist is removed.
//           Blind that existed before Bloodmist has its previous lifetime and
//           Infinite state restored.
//
// RETURNS: Number of Blind Statuses changed.
//
//===============================================================================//

function scr_status_remove_bloodmist_blind(){

	//================//
	//GET BEAST LISTS//
	//================//
	var _arr_beast_lists = [];

	if (instance_exists(obj_battle_player_controller)){
		array_push(
			_arr_beast_lists,
			obj_battle_player_controller._list_beasts
		);
	}

	if (instance_exists(obj_battle_enemy_controller)){
		array_push(
			_arr_beast_lists,
			obj_battle_enemy_controller._list_beasts
		);
	}

	var _ct_changed = 0;

	//================//
	//CHECK ALL BEASTS//
	//================//
	for (var _it_team = 0;_it_team < array_length(_arr_beast_lists);_it_team++){

		var _list_beasts = _arr_beast_lists[_it_team];

		if (!ds_exists(_list_beasts,ds_type_list)){
			continue;
		}

		for (var _it_beast = 0;_it_beast < ds_list_size(_list_beasts);_it_beast++){

			var _ref_beast = ds_list_find_value(
				_list_beasts,
				_it_beast
			);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			var _ref_blind = scr_status_check(
				"BLIND",
				_ref_beast
			);

			if (
				_ref_blind == -1 ||
				!instance_exists(_ref_blind)
			){
				continue;
			}

			//-------------------------//
			//NOT BLOODMIST CONTROLLED//
			//-------------------------//
			if (
				!variable_instance_exists(
					_ref_blind,
					"_flag_bloodmist_override"
				) ||
				!_ref_blind._flag_bloodmist_override
			){
				continue;
			}

			//=========================//
			//REMOVE BLOODMIST BLIND//
			//=========================//
			if (
				variable_instance_exists(
					_ref_blind,
					"_flag_bloodmist_created"
				) &&
				_ref_blind._flag_bloodmist_created
			){

				scr_status_cc_blind(
					"DEATH",
					_ref_blind
				);

				_ct_changed++;

				continue;
			}

			//========================//
			//RESTORE EXISTING BLIND//
			//========================//
			_ref_blind._flag_status_infinite =
				_ref_blind._flag_bloodmist_previous_infinite;

			_ref_blind._val_status_lifetime =
				_ref_blind._val_bloodmist_previous_lifetime;

			_ref_blind._val_status_lifetime_max =
				_ref_blind._val_bloodmist_previous_lifetime_max;

			_ref_blind._flag_bloodmist_override = false;
			_ref_blind._flag_bloodmist_created = false;

			_ref_blind._flag_bloodmist_previous_infinite = undefined;
			_ref_blind._val_bloodmist_previous_lifetime = undefined;
			_ref_blind._val_bloodmist_previous_lifetime_max = undefined;

			_ref_blind._str_status_command = "WAIT";

			_ct_changed++;
		}
	}

	return _ct_changed;
}