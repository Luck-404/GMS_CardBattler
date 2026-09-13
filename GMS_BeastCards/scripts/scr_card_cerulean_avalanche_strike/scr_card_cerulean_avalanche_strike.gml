//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_AVALANCHE_STRIKE
// FUNCTION: Resolves Avalanche Strike.
//           Deals physical damage to the front two living Beasts
//           on the selected enemy team.
//
// ARGUMENTS: _stct_card is the Avalanche Strike card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_avalanche_strike(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET TARGET TEAM LIST//
	//====================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined || !ds_exists(_list_targets,ds_type_list)){
		return;
	}

	var _ct_targets = ds_list_size(_list_targets);

	if (_ct_targets <= 0){
		return;
	}

	//================//
	//GET TARGETS//
	//================//
	var _ref_front_target = ds_list_find_value(_list_targets,0);
	var _ref_second_target = _ct_targets >= 2 ? ds_list_find_value(_list_targets,1) : undefined;

	//===================//
	//DAMAGE FRONT TARGET//
	//===================//
	if (instance_exists(_ref_front_target)){
		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_front_target
		);
	}

	//====================//
	//DAMAGE SECOND TARGET//
	//====================//
	if (instance_exists(_ref_second_target)){
		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_second_target
		);
	}
}