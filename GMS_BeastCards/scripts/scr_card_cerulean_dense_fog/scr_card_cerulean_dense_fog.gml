//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DENSE_FOG
// FUNCTION: Resolves Dense Fog.
//           Blinds every living Beast on the selected target's team.
//
// ARGUMENTS: _stct_card is the Dense Fog card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_dense_fog(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET TARGET TEAM//
	//================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined || !ds_exists(_list_targets,ds_type_list)){
		return;
	}

	var _ct_targets = ds_list_size(_list_targets);
	var _ref_original_target = global.ref_target_beast;

	//================//
	//BLIND TEAM//
	//================//
	for (var _it_target = 0;_it_target < _ct_targets;_it_target++){

		var _ref_affected_target = ds_list_find_value(_list_targets,_it_target);

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (
			_ref_affected_target._str_list != "ALIVE" ||
			_ref_affected_target._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//TARGET BEAST//
		//----------------//
		global.ref_target_beast = _ref_affected_target;

		//----------------//
		//APPLY BLIND//
		//----------------//
		scr_status_apply_cc(
			"BLIND",
			_stct_card._val_card_magnitude
		);
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}