//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ANCIENT_GROVE
// FUNCTION: Resolves Ancient Grove.
//           Summons one Grove Spirit on every living allied Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_ancient_grove(_stct_card,_ref_caster,_ref_target){

	//======================//
	//GET ALLIED TEAM LIST//
	//======================//
	var _list_allies = scr_battle_get_target_team_list(_ref_caster);

	if (_list_allies == undefined){
		return;
	}

	//======================//
	//SUMMON GROVE SPIRITS//
	//======================//
	for (var _it_ally = 0;_it_ally < ds_list_size(_list_allies);_it_ally++){

		var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (_ref_ally._str_list != "ALIVE" || _ref_ally._val_cur_hp <= 0){
			continue;
		}

		scr_minion_init(
			"GROVE_SPIRIT",
			_stct_card,
			_ref_caster,
			_ref_ally
		);
	}
}