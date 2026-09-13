//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DROP_ANCHOR
// FUNCTION: Resolves Drop Anchor.
//           Grants all living allied Beasts Immovable for 2 rounds.
//
// ARGUMENTS: _stct_card is the Drop Anchor card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_drop_anchor(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//================//
	//GET ALLIED TEAM//
	//================//
	var _list_targets = scr_battle_get_target_team_list(_ref_caster);

	if (_list_targets == undefined || !ds_exists(_list_targets,ds_type_list)){
		return;
	}

	var _ct_targets = ds_list_size(_list_targets);
	var _ref_original_target = global.ref_target_beast;

	//================//
	//APPLY IMMOVABLE//
	//================//
	for (var _it_target = 0;_it_target < _ct_targets;_it_target++){

		var _ref_affected_target = ds_list_find_value(_list_targets,_it_target);

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		global.ref_target_beast = _ref_affected_target;

		scr_status_apply_buff(
			"IMMOVABLE",
			0,
			2
		);
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}