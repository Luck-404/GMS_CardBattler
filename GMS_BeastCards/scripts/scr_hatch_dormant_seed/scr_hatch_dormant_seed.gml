//===============================================================================//
//
// SCRIPT: SCR_HATCH_DORMANT_SEED
// FUNCTION: Hatches a Dormant Seed into a random Viridian minion.
//           Transfers the Seed's HP and Magnitude bonuses to the new minion.
//           Preserves damage already taken by the Seed when transferring HP.
//           Removes only the hatching Seed from its host.
//
//===============================================================================//
function scr_hatch_dormant_seed(_ref_seed){

	if (!instance_exists(_ref_seed)){
		return undefined;
	}

	var _ref_host = _ref_seed._ref_host;

	if (!instance_exists(_ref_host)){
		instance_destroy(_ref_seed);
		return undefined;
	}

	if (ds_list_size(global.list_pool_viridian_minions) <= 0){
		return undefined;
	}

	//-----------------------//
	//CALCULATE SEED BONUSES//
	//-----------------------//
	var _val_cur_hp_bonus =
		max(0,_ref_seed._val_cur_hp - 1);

	var _val_max_hp_bonus =
		max(0,_ref_seed._val_max_hp - 1);

	var _val_magnitude_bonus =
		max(0,_ref_seed._val_magnitude);

	//--------------------//
	//ROLL HATCHED MINION//
	//--------------------//
	var _it_minion =
		irandom(
			ds_list_size(global.list_pool_viridian_minions) - 1
		);

	var _str_minion =
		ds_list_find_value(
			global.list_pool_viridian_minions,
			_it_minion
		);

	//----------------------//
	//REMOVE SEED FROM HOST//
	//----------------------//
	var _it_seed =
		ds_list_find_index(
			_ref_host._list_minions,
			_ref_seed
		);

	if (_it_seed != -1){
		ds_list_delete(_ref_host._list_minions,_it_seed);
	}

	//--------------//
	//DESTROY SEED//
	//--------------//
	instance_destroy(_ref_seed);

	//--------------------//
	//SUMMON HATCH RESULT//
	//--------------------//
	var _ref_new_minion =
		scr_init_minion(
			_str_minion,
			undefined,
			undefined,
			_ref_host
		);

	if (!instance_exists(_ref_new_minion)){
		return undefined;
	}

	//-------------------//
	//TRANSFER HP BONUS//
	//-------------------//
	_ref_new_minion._val_cur_hp +=
		_val_cur_hp_bonus;

	_ref_new_minion._val_max_hp +=
		_val_max_hp_bonus;

	_ref_new_minion._val_cur_hp =
		min(
			_ref_new_minion._val_cur_hp,
			_ref_new_minion._val_max_hp
		);

	//--------------------------//
	//TRANSFER MAGNITUDE BONUS//
	//--------------------------//
	_ref_new_minion._val_magnitude +=
		_val_magnitude_bonus;

	//------------------------//
	//REFRESH PASSIVE EFFECT//
	//------------------------//
	if (_ref_new_minion._str_name == "BLOOMING SPRITE"){
		scr_status_buff_blooming_sprite("APPLY",undefined,_ref_new_minion);
	}

	//-------------//
	//HATCH POPUP//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"SEED HATCHED: " + string_upper(_str_minion),
		undefined,
		c_green,
		_ref_host.x + irandom_range(-32,32),
		_ref_host.y - 24 + irandom_range(-32,32)
	);

	return _ref_new_minion;
}