//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_AGE
// FUNCTION: Resolves Ice Age.
//           Freezes every living Beast.
//           Applies 2 Frostburn to every living enemy Beast.
//
// ARGUMENTS: _stct_card is the Ice Age card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_ice_age(_stct_card,_ref_caster,_ref_target){

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//===================//
	//FREEZE PLAYER TEAM//
	//===================//
	var _list_player = obj_battle_player_controller._list_beasts_alive;

	for (var _it_beast = 0;_it_beast < ds_list_size(_list_player);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_player,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		global.ref_target_beast = _ref_beast;

		scr_status_apply_cc(
			"FROZEN",
			_stct_card._val_card_magnitude
		);
	}

	//==================//
	//FREEZE ENEMY TEAM//
	//==================//
	var _list_enemy = obj_battle_enemy_controller._list_beasts_alive;

	for (var _it_beast = 0;_it_beast < ds_list_size(_list_enemy);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_enemy,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		global.ref_target_beast = _ref_beast;

		scr_status_apply_cc(
			"FROZEN",
			_stct_card._val_card_magnitude
		);
	}

	//=======================//
	//APPLY ENEMY FROSTBURN//
	//=======================//
	var _list_hostile = _ref_caster._str_team == "PLAYER"
		? obj_battle_enemy_controller._list_beasts_alive
		: obj_battle_player_controller._list_beasts_alive;

	for (var _it_beast = 0;_it_beast < ds_list_size(_list_hostile);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_hostile,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		global.ref_target_beast = _ref_beast;

		scr_status_apply_dot("FROSTBURN");
		scr_status_apply_dot("FROSTBURN");
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}