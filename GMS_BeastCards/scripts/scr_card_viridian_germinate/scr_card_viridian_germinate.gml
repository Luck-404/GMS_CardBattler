//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GERMINATE
// FUNCTION: Resolves Germinate.
//           Immediately hatches all existing Dormant Seeds on the target.
//           Then summons 2 fresh Dormant Seeds on the target.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_germinate(_stct_card,_ref_caster,_ref_target){

	//=====================//
	//HATCH EXISTING SEEDS//
	//=====================//
	for (var _it_minion = ds_list_size(_ref_target._list_minions) - 1;_it_minion >= 0;_it_minion--){

		var _ref_minion = ds_list_find_value(_ref_target._list_minions,_it_minion);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		if (_ref_minion._str_name != "DORMANT SEED"){
			continue;
		}

		scr_minion_hatch_dormant_seed(_ref_minion);
	}

	//====================//
	//SUMMON DORMANT SEEDS//
	//====================//
	repeat (2){
		scr_minion_init("DORMANT_SEED",_stct_card,_ref_caster,_ref_target);
	}
}