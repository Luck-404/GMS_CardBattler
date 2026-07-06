//===============================================================================//
//
// SCRIPT: SCR_BATTLE_MARK_ENEMY_CAPTURED_AS_DEAD
// FUNCTION: Marks a captured enemy battle beast as dead without destroying it.
//           Moves it from the enemy alive list to the graveyard.
//           Hides the instance after bookkeeping so battle end detection works.
//
//===============================================================================//

function scr_battle_mark_enemy_captured_as_dead(_ref_enemy){

	if (!instance_exists(_ref_enemy)){
		return false;
	}

	if (_ref_enemy._str_team != "ENEMY"){
		return false;
	}

	//—------------------------------------------------------------------------------//
	// DESTROY ATTACHED MINIONS
	//—------------------------------------------------------------------------------//
	for (var _it_minion = ds_list_size(_ref_enemy._list_minions) - 1; _it_minion >= 0; _it_minion--){

		var _ref_minion = ds_list_find_value(_ref_enemy._list_minions,_it_minion);

		if (instance_exists(_ref_minion)){
			instance_destroy(_ref_minion);
		}
	}

	//—------------------------------------------------------------------------------//
	// TRIGGER ATTACHED STATUS DEATH COMMANDS
	//—------------------------------------------------------------------------------//
	for (var _it_status = ds_list_size(_ref_enemy._list_statuses) - 1; _it_status >= 0; _it_status--){

		var _ref_status = ds_list_find_value(_ref_enemy._list_statuses,_it_status);

		if (instance_exists(_ref_status)){
			_ref_status._str_status_command = "DEATH";
		}
	}

	//—------------------------------------------------------------------------------//
	// HIDE ENEMY CARDS ATTACHED TO THIS BEAST
	//—------------------------------------------------------------------------------//
	for (var _it_card = 0; _it_card < ds_list_size(_ref_enemy._list_deck); _it_card++){

		var _ref_card = ds_list_find_value(_ref_enemy._list_deck,_it_card);

		if (instance_exists(_ref_card)){
			_ref_card.visible = false;
			_ref_card._str_location = "CAPTURED";
		}
	}

	//—------------------------------------------------------------------------------//
	// REMOVE FROM ALIVE LIST
	//—------------------------------------------------------------------------------//
	var _it_alive = ds_list_find_index(obj_battle_enemy_controller._list_beasts_alive,_ref_enemy);

	if (_it_alive != -1){
		ds_list_delete(obj_battle_enemy_controller._list_beasts_alive,_it_alive);
	}

	//—------------------------------------------------------------------------------//
	// ADD TO GRAVEYARD LIST
	//—------------------------------------------------------------------------------//
	if (ds_list_find_index(obj_battle_enemy_controller._list_beasts_graveyard,_ref_enemy) == -1){
		ds_list_add(obj_battle_enemy_controller._list_beasts_graveyard,_ref_enemy);
	}

	//—------------------------------------------------------------------------------//
	// REPOSITION REMAINING ALIVE ENEMIES
	//—------------------------------------------------------------------------------//
	for (var _it_beast = 0; _it_beast < ds_list_size(obj_battle_enemy_controller._list_beasts_alive); _it_beast++){

		var _ref_beast = ds_list_find_value(obj_battle_enemy_controller._list_beasts_alive,_it_beast);

		_ref_beast._val_pos = _it_beast;
		_ref_beast.x = _ref_beast.hscr_get_battle_x(_ref_beast._str_team,_it_beast);

		scr_reposition_minions(_ref_beast);
		scr_reposition_statuses(_ref_beast);
	}

	//—------------------------------------------------------------------------------//
	// REPOSITION GRAVEYARD ENEMIES
	//—------------------------------------------------------------------------------//
	var _ct_alive = ds_list_size(obj_battle_enemy_controller._list_beasts_alive);

	for (var _it_dead = 0; _it_dead < ds_list_size(obj_battle_enemy_controller._list_beasts_graveyard); _it_dead++){

		var _ref_dead = ds_list_find_value(obj_battle_enemy_controller._list_beasts_graveyard,_it_dead);

		_ref_dead._val_pos = _ct_alive + _it_dead;
		_ref_dead.x = _ref_dead.hscr_get_dead_x(_ref_dead._str_team,_ct_alive,_it_dead);
	}

	//—------------------------------------------------------------------------------//
	// UPDATE DEAD STATE
	//—------------------------------------------------------------------------------//
	_ref_enemy._val_cur_hp = 0;
	_ref_enemy._str_list = "DEAD";
	_ref_enemy._flag_death_handled = true;
	_ref_enemy._flag_captured = true;

	//—------------------------------------------------------------------------------//
	// CAPTURED VISUAL STATE
	//—------------------------------------------------------------------------------//
	_ref_enemy.visible = true;
	_ref_enemy.image_alpha = 1;

	return true;
}