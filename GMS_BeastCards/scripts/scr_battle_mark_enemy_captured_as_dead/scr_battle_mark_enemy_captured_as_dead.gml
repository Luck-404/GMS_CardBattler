//===============================================================================//
//
// SCRIPT: SCR_BATTLE_MARK_ENEMY_CAPTURED_AS_DEAD
// FUNCTION: Removes a successfully captured enemy from active combat, cleans
//           attached battle state, moves it into the graveyard presentation
//           lane, and refreshes the complete enemy/player formation geometry.
//
//===============================================================================//
function scr_battle_mark_enemy_captured_as_dead(_ref_enemy){

	#region VALIDATION

	//----------------//
	//VALIDATE ENEMY//
	//----------------//
	if (!instance_exists(_ref_enemy)){
		return false;
	}

	if (_ref_enemy._str_team != "ENEMY"){
		return false;
	}

	#endregion

	#region CLEANUP

	//-------------------------//
	//DESTROY ATTACHED MINIONS//
	//-------------------------//
	for (var _it_minion = ds_list_size(_ref_enemy._list_minions) - 1; _it_minion >= 0; _it_minion--){

		var _ref_minion = ds_list_find_value(_ref_enemy._list_minions,_it_minion);

		if (instance_exists(_ref_minion)){
			instance_destroy(_ref_minion);
		}
	}

	//------------------------------//
	//TRIGGER STATUS DEATH COMMANDS//
	//------------------------------//
	for (var _it_status = ds_list_size(_ref_enemy._list_statuses) - 1; _it_status >= 0; _it_status--){

		var _ref_status = ds_list_find_value(_ref_enemy._list_statuses,_it_status);

		if (instance_exists(_ref_status)){
			_ref_status._str_status_command = "DEATH";
		}
	}

	//-------------------------//
	//HIDE ATTACHED ENEMY CARDS//
	//-------------------------//
	for (var _it_card = 0; _it_card < ds_list_size(_ref_enemy._list_deck); _it_card++){

		var _ref_card = ds_list_find_value(_ref_enemy._list_deck,_it_card);

		if (!instance_exists(_ref_card)){
			continue;
		}

		_ref_card.visible = false;
		_ref_card._str_location = "CAPTURED";
	}

	#endregion

	#region CONTROLLER LISTS

	//----------------------//
	//REMOVE FROM ALIVE LIST//
	//----------------------//
	var _it_alive_beast = ds_list_find_index(obj_battle_enemy_controller._list_beasts_alive,_ref_enemy);

	if (_it_alive_beast != -1){
		ds_list_delete(obj_battle_enemy_controller._list_beasts_alive,_it_alive_beast);
	}

	//---------------------//
	//ADD TO GRAVEYARD LIST//
	//---------------------//
	if (ds_list_find_index(obj_battle_enemy_controller._list_beasts_graveyard,_ref_enemy) == -1){
		ds_list_add(obj_battle_enemy_controller._list_beasts_graveyard,_ref_enemy);
	}

	#endregion

	#region CAPTURE STATE / FORMATION

	//-------------------//
	//UPDATE BEAST STATE//
	//-------------------//
	/*
		Set the captured/dead state BEFORE formation refresh so the shared layout
		sees this instance as a graveyard presentation slot rather than a living
		Elite/targetable unit.
	*/
	_ref_enemy._val_cur_hp = 0;
	_ref_enemy._str_list = "DEAD";

	_ref_enemy._flag_death_handled = true;
	_ref_enemy._flag_captured = true;

	//---------------------//
	//SET CAPTURED VISUALS//
	//---------------------//
	_ref_enemy.visible = true;
	_ref_enemy.image_alpha = 1;

	//=============================//
	//REFRESH LIVING + GRAVEYARD//
	//=============================//
	scr_battle_refresh_formation(
		"ENEMY",
		true
	);

	#endregion


	return true;
}
