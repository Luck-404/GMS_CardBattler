//===============================================================================//
//
// SCRIPT: SCR_CC_RETURN_BANISHED_BEAST
// FUNCTION: Returns a Banished Beast to active battle.
//           Reinserts it into its previous formation position when possible.
//           Restores attached Statuses, persistent VFX, Minions, and enemy
//           hand visibility.
//
//===============================================================================//

function scr_cc_return_banished_beast(_ref_beast,_val_return_pos){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_ref_beast._str_list != "BANISHED"){
		return false;
	}

	if (_ref_beast._val_cur_hp <= 0){
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
	//RESTORE TO FORMATION//
	//======================//
	var _it_existing = ds_list_find_index(_list_alive,_ref_beast);

	if (_it_existing != -1){
		ds_list_delete(_list_alive,_it_existing);
	}

	if (_val_return_pos == undefined){
		_val_return_pos = ds_list_size(_list_alive);
	}

	_val_return_pos = floor(_val_return_pos);
	_val_return_pos = clamp(_val_return_pos,0,ds_list_size(_list_alive));

	ds_list_insert(
		_list_alive,
		_val_return_pos,
		_ref_beast
	);

	//================//
	//RESTORE BEAST//
	//================//
	_ref_beast._str_list = "ALIVE";
	_ref_beast.visible = true;

	//==================//
	//RESTORE STATUSES//
	//==================//
	if (ds_exists(_ref_beast._list_statuses,ds_type_list)){

		for (var _it_status = 0;_it_status < ds_list_size(_ref_beast._list_statuses);_it_status++){

			var _ref_status = ds_list_find_value(_ref_beast._list_statuses,_it_status);

			if (!instance_exists(_ref_status)){
				continue;
			}

			_ref_status.visible = true;

			//-------------------------//
			//RESTORE PERSISTENT VFX//
			//-------------------------//
			if (
				variable_instance_exists(_ref_status,"_ref_persistent_vfx") &&
				instance_exists(_ref_status._ref_persistent_vfx)
			){
				_ref_status._ref_persistent_vfx.visible = true;
			}
		}
	}

	//================//
	//RESTORE MINIONS//
	//================//
	if (ds_exists(_ref_beast._list_minions,ds_type_list)){

		for (var _it_minion = 0;_it_minion < ds_list_size(_ref_beast._list_minions);_it_minion++){

			var _ref_minion = ds_list_find_value(_ref_beast._list_minions,_it_minion);

			if (instance_exists(_ref_minion)){
				_ref_minion.visible = true;
			}
		}
	}

	//===================//
	//RESTORE ENEMY HAND//
	//===================//
	if (
		_ref_beast._str_team == "ENEMY" &&
		ds_exists(_ref_beast._list_deck,ds_type_list)
	){

		for (var _it_card = 0;_it_card < ds_list_size(_ref_beast._list_deck);_it_card++){

			var _ref_card = ds_list_find_value(_ref_beast._list_deck,_it_card);

			if (!instance_exists(_ref_card)){
				continue;
			}

			if (_ref_card._str_location == "HAND"){
				_ref_card.visible = true;
			}
		}
	}

	//=====================//
	//REFRESH FORMATION//
	//=====================//
	scr_battle_refresh_formation(_ref_beast._str_team);

	if (ds_exists(_ref_beast._list_statuses,ds_type_list)){
		scr_status_reposition(_ref_beast);
	}

	return true;
}