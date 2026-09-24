//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WINTERS_HOUR
// FUNCTION: Resolves Winter's Hour.
//           Begins Snow Weather.
//           Heals every living allied Beast.
//           Applies 1 Frostbite to every living enemy Beast.
//
// ARGUMENTS: _stct_card is the Winter's Hour card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_winters_hour(_stct_card,_ref_caster,_ref_target){

	//==================//
	//BEGIN SNOW WEATHER//
	//==================//
	scr_status_apply_weather(
		"SNOW"
	);

	//================//
	//GET TEAM LISTS//
	//================//
	var _list_allies = undefined;
	var _list_enemies = undefined;

	if (_ref_caster._str_team == "PLAYER"){
		_list_allies = obj_battle_player_controller._list_beasts_alive;
		_list_enemies = obj_battle_enemy_controller._list_beasts_alive;
	}
	else{
		_list_allies = obj_battle_enemy_controller._list_beasts_alive;
		_list_enemies = obj_battle_player_controller._list_beasts_alive;
	}

	//================//
	//HEAL ALL ALLIES//
	//================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_allies);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_allies,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

	scr_battle_heal_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_beast
	);
	}


	//=======================//
	//FROSTBITE ALL ENEMIES//
	//=======================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_enemies);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_enemies,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}


		scr_status_apply_dot("FROSTBITE", _ref_beast);
	}

}