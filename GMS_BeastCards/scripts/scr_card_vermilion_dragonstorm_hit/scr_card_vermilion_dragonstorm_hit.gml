//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_DRAGONSTORM_HIT
// FUNCTION: Resolves one Dragonstorm hit.
//           Rebuilds the living-target pool before each attack.
//
// ARGUMENTS: _stct_sequence.
// RETURNS: True if another hit should be scheduled.
//
//===============================================================================//

function scr_card_vermilion_dragonstorm_hit(_stct_sequence){

	#region VALIDATION

	//================//
	//VALIDATE SEQUENCE//
	//================//
	if (!is_struct(_stct_sequence)){
		return false;
	}

	if (_stct_sequence._ct_hits_remaining <= 0){
		return false;
	}

	//================//
	//VALIDATE CASTER//
	//================//
	var _ref_caster = _stct_sequence._ref_caster;

	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (_ref_caster._val_cur_hp <= 0){
		return false;
	}

	//================//
	//VALIDATE CARD//
	//================//
	if (!instance_exists(_stct_sequence._ref_card)){
		return false;
	}

	#endregion

	#region TARGET TEAM

	//================//
	//GET SELECTED TEAM//
	//================//
	var _list_targets = undefined;

	switch (_stct_sequence._str_target_team){

		case "PLAYER":

			if (instance_exists(obj_battle_player_controller)){

				_list_targets =
					obj_battle_player_controller._list_beasts_alive;
			}

		break;

		case "ENEMY":

			if (instance_exists(obj_battle_enemy_controller)){

				_list_targets =
					obj_battle_enemy_controller._list_beasts_alive;
			}

		break;
	}

	if (
		_list_targets == undefined ||
		!ds_exists(_list_targets,ds_type_list)
	){
		return false;
	}

	//================//
	//BUILD LIVING POOL//
	//================//
	var _arr_living_targets = [];

	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_beast = ds_list_find_value(
			_list_targets,
			_it_target
		);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		array_push(
			_arr_living_targets,
			_ref_beast
		);
	}

	//================//
	//NO TARGETS LEFT//
	//================//
	if (array_length(_arr_living_targets) <= 0){
		return false;
	}

	//================//
	//SELECT RANDOM BEAST//
	//================//
	var _ref_hit_target = _arr_living_targets[
		irandom(array_length(_arr_living_targets) - 1)
	];

	#endregion

	#region BURN CHECK

	//================//
	//CHECK BURN BEFORE HIT//
	//================//
	var _ref_burn = scr_status_check(
		"BURN",
		_ref_hit_target
	);

	var _flag_already_burning = (
		_ref_burn != -1 &&
		instance_exists(_ref_burn) &&
		_ref_burn._ct_status_stacks > 0
	);

	#endregion

	#region CAST CONTEXT

	//================//
	//STORE GLOBALS//
	//================//
	var _ref_original_card = global.ref_cast_card;
	var _ref_original_caster = global.ref_caster_beast;

	var _flag_original_resolving =
		global.flag_card_effect_resolving;

	//================//
	//RESTORE CARD CONTEXT//
	//================//
	global.ref_cast_card = _stct_sequence._ref_card;
	global.ref_caster_beast = _ref_caster;

	global.flag_card_effect_resolving = true;

	#endregion

	#region RESOLVE HIT

	//================//
	//DEAL 2 NEU//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_hit_target,
		_stct_sequence._val_hit_damage,
		{card: _stct_sequence._ref_card._ref_card, card_instance: _stct_sequence._ref_card}
	);

	//================//
	//COUNT HIT//
	//================//
	_stct_sequence._ct_hits_remaining--;

	//================//
	//CHECK SURVIVAL//
	//================//
	if (
		instance_exists(_ref_hit_target) &&
		_ref_hit_target._str_list == "ALIVE" &&
		_ref_hit_target._val_cur_hp > 0
	){


		//================//
		//APPLY CHAR//
		//================//
		if (_flag_already_burning){

			scr_status_apply_debuff("CHAR", _ref_hit_target);
		}

		//================//
		//APPLY BURN//
		//================//
		else{

			scr_status_apply_dot("BURN", _ref_hit_target);
		}
	}

	#endregion

	#region CLEANUP

	//================//
	//RESTORE GLOBALS//
	//================//
	global.ref_cast_card = _ref_original_card;
	global.ref_caster_beast = _ref_original_caster;

	global.flag_card_effect_resolving = _flag_original_resolving;

	//================//
	//MORE HITS?//
	//================//
	return (_stct_sequence._ct_hits_remaining > 0);

	#endregion
}
