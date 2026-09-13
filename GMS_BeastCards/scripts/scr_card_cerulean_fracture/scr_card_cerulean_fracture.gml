//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FRACTURE
// FUNCTION: Resolves Fracture.
//           Deals linear magical damage to each enemy Beast.
//           SHATTERS each surviving target, then applies 1 Bleed.
//           Begins Snow Weather.
//
// ARGUMENTS: _stct_card is the Fracture card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_fracture(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET ENEMY TEAM//
	//================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined || !ds_exists(_list_targets,ds_type_list)){
		return;
	}

	//================//
	//COPY TARGETS//
	//================//
	var _arr_targets = [];

	for (var _it_target = 0;_it_target < ds_list_size(_list_targets);_it_target++){

		var _ref_hit_target = ds_list_find_value(_list_targets,_it_target);

		if (instance_exists(_ref_hit_target)){
			array_push(_arr_targets,_ref_hit_target);
		}
	}

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//================//
	//RESOLVE TARGETS//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_hit_target = _arr_targets[_it_target];

		if (
			!instance_exists(_ref_hit_target) ||
			_ref_hit_target._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//DEAL DAMAGE//
		//----------------//
		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_hit_target
		);

		if (
			!instance_exists(_ref_hit_target) ||
			_ref_hit_target._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//SHATTER//
		//----------------//
		scr_battle_trigger_shatter(
			_ref_hit_target
		);

		if (
			!instance_exists(_ref_hit_target) ||
			_ref_hit_target._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//APPLY BLEED//
		//----------------//
		global.ref_target_beast = _ref_hit_target;

		scr_status_apply_dot(
			"BLEED"
		);
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;

	//==================//
	//BEGIN SNOW WEATHER//
	//==================//
	scr_status_apply_weather(
		"SNOW"
	);
}