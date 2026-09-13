//===============================================================================//
//
// SCRIPT: SCR_CC_BANISH_BEAST
// FUNCTION: Temporarily removes a living Beast from active battle.
//           Removes it from the alive formation without treating it as dead.
//           Hides attached Minions, Statuses, persistent VFX, and enemy cards.
//           Preserves all attached effects without decrementing them.
//
//===============================================================================//

function scr_cc_banish_beast(_ref_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (
		_ref_beast._str_list != "ALIVE" ||
		_ref_beast._val_cur_hp <= 0
	){
		return false;
	}

	if (
		_ref_beast._str_team != "PLAYER" &&
		_ref_beast._str_team != "ENEMY"
	){
		return false;
	}

	//================//
	//GET ALIVE LIST//
	//================//
	var _list_alive = undefined;

	if (_ref_beast._str_team == "PLAYER"){

		if (!instance_exists(obj_battle_player_controller)){
			return false;
		}

		_list_alive = obj_battle_player_controller._list_beasts_alive;
	}
	else{

		if (!instance_exists(obj_battle_enemy_controller)){
			return false;
		}

		_list_alive = obj_battle_enemy_controller._list_beasts_alive;
	}

	if (!ds_exists(_list_alive,ds_type_list)){
		return false;
	}

	//======================//
	//REMOVE FROM FORMATION//
	//======================//
	var _it_beast = ds_list_find_index(_list_alive,_ref_beast);

	if (_it_beast != -1){
		ds_list_delete(_list_alive,_it_beast);
	}

	//================//
	//BANISHED STATE//
	//================//
	_ref_beast._str_list = "BANISHED";
	_ref_beast.visible = false;

	//================//
	//PAUSE STATUSES//
	//================//
	if (ds_exists(_ref_beast._list_statuses,ds_type_list)){

		for (var _it_status = 0;_it_status < ds_list_size(_ref_beast._list_statuses);_it_status++){

			var _ref_status = ds_list_find_value(_ref_beast._list_statuses,_it_status);

			if (!instance_exists(_ref_status)){
				continue;
			}

			_ref_status._str_status_command = "WAIT";
			_ref_status.visible = false;

			//----------------------//
			//HIDE PERSISTENT VFX//
			//----------------------//
			if (
				variable_instance_exists(_ref_status,"_ref_persistent_vfx") &&
				instance_exists(_ref_status._ref_persistent_vfx)
			){
				_ref_status._ref_persistent_vfx.visible = false;
			}
		}
	}

	//================//
	//HIDE MINIONS//
	//================//
	if (ds_exists(_ref_beast._list_minions,ds_type_list)){

		for (var _it_minion = 0;_it_minion < ds_list_size(_ref_beast._list_minions);_it_minion++){

			var _ref_minion = ds_list_find_value(_ref_beast._list_minions,_it_minion);

			if (instance_exists(_ref_minion)){
				_ref_minion.visible = false;
			}
		}
	}

	//==================//
	//HIDE ENEMY CARDS//
	//==================//
	if (
		_ref_beast._str_team == "ENEMY" &&
		ds_exists(_ref_beast._list_deck,ds_type_list)
	){

		for (var _it_card = 0;_it_card < ds_list_size(_ref_beast._list_deck);_it_card++){

			var _ref_card = ds_list_find_value(_ref_beast._list_deck,_it_card);

			if (instance_exists(_ref_card)){
				_ref_card.visible = false;
			}
		}
	}

	//=====================//
	//CLOSE FORMATION GAP//
	//=====================//
	scr_battle_refresh_formation(_ref_beast._str_team);

	return true;
}