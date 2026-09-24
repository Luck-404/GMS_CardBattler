//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_WAR_CRY
// FUNCTION: Grants 2 Rage to every living Beast on the selected team.
//
//===============================================================================//

function scr_card_vermilion_war_cry(_stct_card,_ref_caster,_ref_target){

	//===================//
	//GET SELECTED TEAM//
	//===================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	if (!ds_exists(_list_targets,ds_type_list)){
		return;
	}

	//================//
	//GAIN RAGE//
	//================//
	for (var _it_target = 0;_it_target < ds_list_size(_list_targets);_it_target++){

		var _ref_affected_target = ds_list_find_value(
			_list_targets,
			_it_target
		);

		//----------------//
		//VALIDATE BEAST//
		//----------------//
		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (
			_ref_affected_target._str_list != "ALIVE" ||
			_ref_affected_target._val_cur_hp <= 0
		){
			continue;
		}

		//================//
		//GRANT 2 RAGE//
		//================//
		scr_status_gain_rage(
			_ref_affected_target,
			_stct_card._val_card_magnitude
		);
	}
}
