//===============================================================================//
//
// SCRIPT: SCR_BATTLE_REFRESH_FORMATION
// FUNCTION: Reindexes and repositions all active Beasts on one battle team.
//           Used after structural formation changes such as Banish and bypasses
//           normal gameplay reposition restrictions.
//
// INPUT:    _str_team - Team whose active formation should be refreshed.
// USES:     Player/enemy living-Beast lists, battle position helpers,
//           Minion positioning, and Status positioning.
//
//===============================================================================//

function scr_battle_refresh_formation(_str_team){

	#region FORMATION DATA

	//----------------//
	//GET BEAST LIST//
	//----------------//
	var _list_beasts;

	if (_str_team == "PLAYER"){
		_list_beasts = obj_battle_player_controller._list_beasts_alive;
	}
	else{
		_list_beasts = obj_battle_enemy_controller._list_beasts_alive;
	}

	var _ct_beasts = ds_list_size(_list_beasts);

	#endregion

	#region FORMATION REFRESH

	//-------------------//
	//REPOSITION BEASTS//
	//-------------------//
	for (var _it_beast = 0; _it_beast < _ct_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		//----------------//
		//UPDATE POSITION//
		//----------------//
		_ref_beast._val_pos = _it_beast;

		_ref_beast.x = _ref_beast.hscr_battle_get_active_x(_ref_beast._str_team,_it_beast);

		//----------------------//
		//REFRESH ATTACHMENTS//
		//----------------------//
		scr_minion_reposition(_ref_beast);
		scr_status_reposition(_ref_beast);
	}

	#endregion
}