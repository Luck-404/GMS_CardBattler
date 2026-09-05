//===============================================================================//
//
// SCRIPT: SCR_RETURN_BANISHED_BEAST
// FUNCTION: Returns a Banished Beast to active battle.
//           Reinserts it into its previous formation position when possible.
//           Restores attached statuses, Minions, and enemy hand visibility.
//
//===============================================================================//

function scr_return_banished_beast(_ref_beast,_val_return_pos){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_ref_beast._str_list != "BANISHED"){
		return false;
	}

	if (_ref_beast._val_cur_hp <= 0){
		return false;
	}

	var _list_alive;

	if (_ref_beast._str_team == "PLAYER"){
		_list_alive = obj_battle_player_controller._list_beasts_alive;
	}
	else{
		_list_alive = obj_battle_enemy_controller._list_beasts_alive;
	}

	//-------------------//
	//RESTORE TO FORMATION//
	//-------------------//
_val_return_pos =
		clamp(
			_val_return_pos,
			0,
			ds_list_size(_list_alive)
		);

	ds_list_insert(
		_list_alive,
		_val_return_pos,
		_ref_beast
	);

	_ref_beast._str_list =
		"ALIVE";

	_ref_beast.visible =
		true;

	//----------------//
	//RESTORE STATUSES//
	//----------------//
	for (var _it_status = 0; _it_status < ds_list_size(_ref_beast._list_statuses); _it_status++){

		var _ref_status =
			ds_list_find_value(
				_ref_beast._list_statuses,
				_it_status
			);

		if (instance_exists(_ref_status)){
			_ref_status.visible = true;
		}
	}

	//----------------//
	//RESTORE MINIONS//
	//----------------//
	for (var _it_minion = 0; _it_minion < ds_list_size(_ref_beast._list_minions); _it_minion++){

		var _ref_minion =
			ds_list_find_value(
				_ref_beast._list_minions,
				_it_minion
			);

		if (instance_exists(_ref_minion)){
			_ref_minion.visible = true;
		}
	}

	//-------------------//
	//RESTORE ENEMY HAND//
	//-------------------//
	if (_ref_beast._str_team == "ENEMY"){

		for (var _it_card = 0; _it_card < ds_list_size(_ref_beast._list_deck); _it_card++){

			var _ref_card =
				ds_list_find_value(
					_ref_beast._list_deck,
					_it_card
				);

			if (!instance_exists(_ref_card)){
				continue;
			}

			if (_ref_card._str_location == "HAND"){
				_ref_card.visible = true;
			}
		}
	}

	//-----------------//
	//REFRESH FORMATION//
	//-----------------//
	scr_refresh_battle_formation(_ref_beast._str_team);

	return true;
}