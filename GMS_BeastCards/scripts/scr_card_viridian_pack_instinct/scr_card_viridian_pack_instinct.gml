//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PACK_INSTINCT
// FUNCTION: Resolves Pack Instinct.
//           Applies Pack Instinct to every living allied Beast for 4 rounds.
//           Each affected Beast gains bonuses based on its living Minion count.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_pack_instinct(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET ALLIED TEAM//
	//================//
	var _list_allies = scr_battle_get_target_team_list(_ref_caster);

	if (_list_allies == undefined){
		return;
	}


	//=======================//
	//APPLY TO ALLIED BEASTS//
	//=======================//
	for (var _it_ally = 0; _it_ally < ds_list_size(_list_allies); _it_ally++){

		var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (_ref_ally._val_cur_hp <= 0){
			continue;
		}

		scr_status_apply_buff("PACK_INSTINCT", _ref_ally, 2, 4);
	}

}