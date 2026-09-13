//===============================================================================//
//
// SCRIPT: SCR_MINION_GROW
// FUNCTION: Permanently increases a Minion's current HP, Maximum HP,
//           and Magnitude by the supplied amount.
//           Plays shared growth presentation and logs the resulting stats.
//
// ARGUMENTS: _ref_minion is the Minion receiving permanent growth.
//            _val_amount is added to HP, Maximum HP, and Magnitude.
// RETURNS: True when growth successfully resolves; otherwise false.
//
//===============================================================================//

function scr_minion_grow(_ref_minion,_val_amount){

	//-----------------//
	//VALIDATE MINION//
	//-----------------//
	if (!instance_exists(_ref_minion)){
		return false;
	}

	if (_ref_minion._val_cur_hp <= 0){
		return false;
	}

	if (_val_amount <= 0){
		return false;
	}

	//================//
	//STORE OLD STATS//
	//================//
	var _val_old_hp = _ref_minion._val_cur_hp;
	var _val_old_max_hp = _ref_minion._val_max_hp;
	var _val_old_magnitude = _ref_minion._val_magnitude;

	//=============//
	//INCREASE HP//
	//=============//
	_ref_minion._val_cur_hp += _val_amount;
	_ref_minion._val_max_hp += _val_amount;

	//===================//
	//INCREASE MAGNITUDE//
	//===================//
	_ref_minion._val_magnitude += _val_amount;

	//================//
	//GROWTH VFX/SFX//
	//================//
	scr_battle_vfx_minion_growth(_ref_minion);

	//=========================//
	//REFRESH PASSIVE MINIONS//
	//=========================//
	if (_ref_minion._str_name == "BLOOMING SPRITE"){

		scr_status_buff_blooming_sprite(
			"APPLY",
			undefined,
			_ref_minion
		);
	}

	//=============//
	//SPAWN POPUP//
	//=============//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_amount) + "/+" + string(_val_amount),
		undefined,
		c_green,
		_ref_minion.x + irandom_range(-16,16),
		_ref_minion.y - 16 + irandom_range(-16,16)
	);

	//================//
	//DEBUG GROWTH//
	//================//
	scr_debug_log(
		"MINIONS",
		"GROWTH",
		_ref_minion,
		string_upper(_ref_minion._str_team) + " " +
		string_upper(_ref_minion._str_name) +
		" GREW" +
		" | HP: " +
		string(_val_old_hp) +
		" -> " +
		string(_ref_minion._val_cur_hp) +
		" | MAX HP: " +
		string(_val_old_max_hp) +
		" -> " +
		string(_ref_minion._val_max_hp) +
		" | MAGNITUDE: " +
		string(_val_old_magnitude) +
		" -> " +
		string(_ref_minion._val_magnitude),
		"BATTLE",
		"SCR_MINION_GROW"
	);

	return true;
}