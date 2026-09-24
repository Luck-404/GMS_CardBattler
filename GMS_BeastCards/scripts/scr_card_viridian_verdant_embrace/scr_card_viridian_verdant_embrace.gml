//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VERDANT_EMBRACE
// FUNCTION: Resolves Verdant Embrace.
//           Heals every living Beast on the caster's team with linearly
//           scaled MAG healing.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_verdant_embrace(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET ALLIED TEAM LIST//
	//====================//
	var _list_targets = scr_battle_get_target_team_list(_ref_caster);

	if (_list_targets == undefined){
		return;
	}

	//================//
	//HEAL ALL ALLIES//
	//================//
	for (var _it_target = 0; _it_target < ds_list_size(_list_targets); _it_target++){

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

		scr_battle_heal_target(
			"LINEAR",
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);
	}
}
