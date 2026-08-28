//===============================================================================//
//
// SCRIPT: SCR_GROW_MINION
// FUNCTION: Permanently increases a Minion's current HP, maximum HP,
//           and Magnitude by the supplied amount.
//           Refreshes Minion-dependent passive effects after Magnitude changes.
//
//===============================================================================//

function scr_grow_minion(_ref_minion,_val_amount){

	if (!instance_exists(_ref_minion)){
		return false;
	}

	if (_val_amount <= 0){
		return false;
	}

	//-------------//
	//INCREASE HP//
	//-------------//
	_ref_minion._val_cur_hp +=
		_val_amount;

	_ref_minion._val_max_hp +=
		_val_amount;

	//-------------------//
	//INCREASE MAGNITUDE//
	//-------------------//
	_ref_minion._val_magnitude +=
		_val_amount;

	//-------------------------//
	//REFRESH PASSIVE MINIONS//
	//-------------------------//
	if (
		_ref_minion._str_name ==
		"BLOOMING SPRITE"
	){
		scr_status_buff_blooming_sprite(
			"APPLY",
			undefined,
			_ref_minion
		);
	}

	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"+" +
			string(_val_amount) +
			"/+" +
			string(_val_amount),
		undefined,
		c_green,
		_ref_minion.x + irandom_range(-16,16),
		_ref_minion.y - 16 + irandom_range(-16,16)
	);

	return true;
}