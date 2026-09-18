//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_BLOODMIST_BLIND
// FUNCTION: Ensures every living Beast has the generic BLIND Crowd Control
//           Status while Bloodmist is active.
//
//           Uses the normal BLIND Status rather than a Bloodmist-specific
//           variant. Bloodmist temporarily converts that Blind to Infinite.
//
//           If the Beast was already Blind before Bloodmist, its previous
//           lifetime data is stored so it can be restored when Bloodmist ends.
//
// RETURNS: Number of living Beasts currently affected by Bloodmist Blind.
//
//===============================================================================//

function scr_status_apply_bloodmist_blind(){

	//================//
	//GET BEAST LISTS//
	//================//
	var _arr_beast_lists = [];

	if (instance_exists(obj_battle_player_controller)){
		array_push(
			_arr_beast_lists,
			obj_battle_player_controller._list_beasts_alive
		);
	}

	if (instance_exists(obj_battle_enemy_controller)){
		array_push(
			_arr_beast_lists,
			obj_battle_enemy_controller._list_beasts_alive
		);
	}

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	var _ct_blinded = 0;

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

			if (
				_ref_beast._str_list != "ALIVE" ||
				_ref_beast._val_cur_hp <= 0
			){
				continue;
			}

			//================//
			//CHECK BLIND//
			//================//
			var _ref_blind = scr_status_check(
				"BLIND",
				_ref_beast
			);

			//===================//
			//APPLY NORMAL BLIND//
			//===================//
			if (
				_ref_blind == -1 ||
				!instance_exists(_ref_blind)
			){

				global.ref_target_beast = _ref_beast;

				_ref_blind = scr_status_cc_blind(
					"APPLY",
					undefined,
					1
				);

				if (!instance_exists(_ref_blind)){
					continue;
				}

				_ref_blind._flag_bloodmist_created = true;
				_ref_blind._flag_bloodmist_override = true;

				_ref_blind._flag_bloodmist_previous_infinite = false;
				_ref_blind._val_bloodmist_previous_lifetime = undefined;
				_ref_blind._val_bloodmist_previous_lifetime_max = undefined;
			}
			else{

				//================================//
				//STORE PRE-BLOODMIST BLIND DATA//
				//================================//
				if (
					!variable_instance_exists(
						_ref_blind,
						"_flag_bloodmist_override"
					) ||
					!_ref_blind._flag_bloodmist_override
				){

					_ref_blind._flag_bloodmist_created = false;
					_ref_blind._flag_bloodmist_override = true;

					_ref_blind._flag_bloodmist_previous_infinite =
						_ref_blind._flag_status_infinite;

					_ref_blind._val_bloodmist_previous_lifetime =
						_ref_blind._val_status_lifetime;

					_ref_blind._val_bloodmist_previous_lifetime_max =
						_ref_blind._val_status_lifetime_max;
				}
			}

			//========================//
			//MAKE BLIND INFINITE//
			//========================//
			_ref_blind._flag_status_infinite = true;

			_ref_blind._val_status_lifetime = -1;
			_ref_blind._val_status_lifetime_max = -1;

			_ref_blind._str_status_command = "WAIT";

			_ct_blinded++;
		}
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;

	return _ct_blinded;
}