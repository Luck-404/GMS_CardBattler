//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_WILDWARD
// FUNCTION: Resolves the Wildward card effect.
//           Grants PHY-scaled linear Armor to every living allied Beast.
//
//===============================================================================//

function scr_card_viridian_wildward(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET CASTER TEAM LIST//
	//--------------------//
	var _list_targets =
		scr_battle_get_target_team_list(_ref_caster);

	if (_list_targets == undefined){
		return;
	}

	//-----------------------//
	//GRANT TEAMWIDE ARMOR//
	//-----------------------//
	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_affected_target =
			ds_list_find_value(
				_list_targets,
				_it_target
			);

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		scr_battle_armor_target(
			"LINEAR",
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);
	}
}