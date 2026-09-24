//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_HUNGERING_FLAMES
// FUNCTION: Applies Hungering Flames to every living Beast on the selected team.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_hungering_flames(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET TARGET TEAM//
	//================//
	var _list_team = scr_battle_get_target_team_list(_ref_target);

	if (_list_team == undefined){
		return;
	}


	//================//
	//APPLY TEAM AURA//
	//================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_team,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		//-------------------//
		//SET AURA RECIPIENT//
		//-------------------//

		//-------------------//
		//APPLY HUNGERING FLAMES//
		//-------------------//
		scr_status_apply_aura("HUNGERING_FLAMES", _ref_beast, _stct_card._val_card_magnitude);
	}

}