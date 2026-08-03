//===============================================================================//
//
// SCRIPT: SCR_HATCH_DORMANT_SEED
// FUNCTION: Hatches a Dormant Seed into a random Viridian minion.
//           Removes the Seed from its host before spawning the replacement.
//           Preserves other minions already attached to the host.
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

	//--------------------//
	//ROLL HATCHED MINION//
	//--------------------//
	var _it_minion = irandom(ds_list_size(global.list_pool_viridian_minions) - 1);
	var _str_minion = ds_list_find_value(global.list_pool_viridian_minions,_it_minion);

	//----------------------//
	//REMOVE SEED FROM HOST//
	//----------------------//
	var _it_seed = ds_list_find_index(_ref_host._list_minions,_ref_seed);

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
	var _ref_new_minion = scr_init_minion(_str_minion,undefined,undefined,_ref_host);

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