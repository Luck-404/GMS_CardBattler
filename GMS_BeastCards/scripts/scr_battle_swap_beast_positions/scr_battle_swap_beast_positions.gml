//===============================================================================//
//
// SCRIPT: SCR_BATTLE_SWAP_BEAST_POSITIONS
// FUNCTION: Swaps two living Beasts on the same battle team.
//           Updates active/full battle roster order, synchronizes persistent
//           Player Party order when applicable, then refreshes formation.
//           This structural/manual swap bypasses normal reposition locks.
//
// ARGUMENTS: _ref_beast_a - First living battle Beast.
//            _ref_beast_b - Second living battle Beast.
//            _str_origin  - Optional debug caller.
// RETURNS: True when the formation changed.
//
//===============================================================================//

function scr_battle_swap_beast_positions(_ref_beast_a,_ref_beast_b,_str_origin="SCR_BATTLE_SWAP_BEAST_POSITIONS"){

	#region VALIDATION

	//================//
	//VALIDATE BEASTS//
	//================//
	if (
		!instance_exists(_ref_beast_a) ||
		!instance_exists(_ref_beast_b) ||
		_ref_beast_a == _ref_beast_b
	){
		return false;
	}

	if (
		_ref_beast_a.object_index != obj_battle_beast ||
		_ref_beast_b.object_index != obj_battle_beast ||
		!is_struct(_ref_beast_a._ref_unit) ||
		!is_struct(_ref_beast_b._ref_unit)
	){
		return false;
	}

	var _str_team = string_upper(string(_ref_beast_a._str_team));

	if (_str_team != "PLAYER" && _str_team != "ENEMY"){
		return false;
	}

	if (string_upper(string(_ref_beast_b._str_team)) != _str_team){
		return false;
	}

	if (
		_ref_beast_a._str_list != "ALIVE" ||
		_ref_beast_b._str_list != "ALIVE" ||
		_ref_beast_a._val_cur_hp <= 0 ||
		_ref_beast_b._val_cur_hp <= 0
	){
		return false;
	}

	//================//
	//GET CONTROLLER//
	//================//
	var _ref_controller = undefined;

	if (_str_team == "PLAYER"){
		if (instance_exists(obj_battle_player_controller)){
			_ref_controller = instance_find(obj_battle_player_controller,0);
		}
	}
	else if (instance_exists(obj_battle_enemy_controller)){
		_ref_controller = instance_find(obj_battle_enemy_controller,0);
	}

	if (
		!instance_exists(_ref_controller) ||
		!ds_exists(_ref_controller._list_beasts_alive,ds_type_list)
	){
		return false;
	}

	var _val_slot_a = ds_list_find_index(_ref_controller._list_beasts_alive,_ref_beast_a);
	var _val_slot_b = ds_list_find_index(_ref_controller._list_beasts_alive,_ref_beast_b);

	if (_val_slot_a == -1 || _val_slot_b == -1 || _val_slot_a == _val_slot_b){
		return false;
	}

	#endregion

	#region ACTIVE FORMATION

	//================//
	//SWAP ALIVE LIST//
	//================//
	ds_list_replace(_ref_controller._list_beasts_alive,_val_slot_a,_ref_beast_b);
	ds_list_replace(_ref_controller._list_beasts_alive,_val_slot_b,_ref_beast_a);

	#endregion

	#region FULL ROSTER

	//================//
	//SWAP FULL LIST//
	//================//
	if (ds_exists(_ref_controller._list_beasts,ds_type_list)){

		var _val_roster_a = ds_list_find_index(_ref_controller._list_beasts,_ref_beast_a);
		var _val_roster_b = ds_list_find_index(_ref_controller._list_beasts,_ref_beast_b);

		if (_val_roster_a != -1 && _val_roster_b != -1 && _val_roster_a != _val_roster_b){
			ds_list_replace(_ref_controller._list_beasts,_val_roster_a,_ref_beast_b);
			ds_list_replace(_ref_controller._list_beasts,_val_roster_b,_ref_beast_a);
		}
	}

	#endregion

	#region PLAYER PARTY SYNC

	/*
		Battle initialization can skip defeated Party Beasts, so living battle
		indices are not assumed to match persistent Party indices. Locate the
		backing Beast structs directly before swapping persistent order.
	*/
	if (
		_str_team == "PLAYER" &&
		variable_global_exists("list_player_party") &&
		ds_exists(global.list_player_party,ds_type_list)
	){

		var _val_party_a = ds_list_find_index(global.list_player_party,_ref_beast_a._ref_unit);
		var _val_party_b = ds_list_find_index(global.list_player_party,_ref_beast_b._ref_unit);

		if (_val_party_a != -1 && _val_party_b != -1 && _val_party_a != _val_party_b){
			scr_party_swap_beasts(_val_party_a,_val_party_b,_str_origin);
		}
	}

	#endregion

	#region REFRESH

	//================//
	//REFRESH POSITION//
	//================//
	scr_battle_refresh_formation(_str_team);

	#endregion

	#region DEBUG

	scr_debug_log(
		"BATTLE",
		"FORMATION",
		_ref_beast_a,
		"FORMATION SWAPPED" +
		" | TEAM: " + _str_team +
		" | BEAST: " + string_upper(_ref_beast_a._ref_unit._str_beast_name) +
		" | POSITION: " + string(_val_slot_a + 1) +
		" -> " + string(_val_slot_b + 1) +
		" | SWAPPED WITH: " + string_upper(_ref_beast_b._ref_unit._str_beast_name),
		"INFO",
		_str_origin
	);

	#endregion

	return true;
}