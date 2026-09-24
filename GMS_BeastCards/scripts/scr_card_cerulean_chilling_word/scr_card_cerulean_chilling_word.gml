//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CHILLING_WORD
// FUNCTION: Resolves Chilling Word.
//           Applies 1 Frostburn to every living Beast on the selected enemy team.
//
// ARGUMENTS: _stct_card is the Chilling Word card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_cerulean_chilling_word(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET TARGET TEAM//
	//================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined || !ds_exists(_list_targets,ds_type_list)){
		return;
	}

	var _ct_targets = ds_list_size(_list_targets);

	//================//
	//APPLY FROSTBURN//
	//================//
	for (var _it_target = 0;_it_target < _ct_targets;_it_target++){

		var _ref_affected_target = ds_list_find_value(_list_targets,_it_target);

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}


		scr_status_apply_dot("FROSTBURN", _ref_affected_target);
	}

}