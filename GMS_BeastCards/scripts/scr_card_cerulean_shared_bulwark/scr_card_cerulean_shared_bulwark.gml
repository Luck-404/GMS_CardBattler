//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SHARED_BULWARK
// FUNCTION: Redistributes the caster's existing Armor among the original
//           living-allied-team snapshot. Preserves integer shares, list order,
//           remainder assignment and caster participation without grant triggers.
//
// ARGUMENTS: _stct_card - Shared Bulwark card struct (unused for quantity).
//            _ref_caster - source Beast; _ref_target - unused team selection.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_shared_bulwark(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET ALLIED TEAM LIST//
	//====================//
	var _list_allies = scr_battle_get_target_team_list(_ref_caster);

	if (_list_allies == undefined || !ds_exists(_list_allies,ds_type_list)){
		return;
	}

	//================//
	//GET TOTAL ARMOR//
	//================//
	var _val_total_armor = max(0,_ref_caster._val_armor);

	if (_val_total_armor <= 0){
		return;
	}

	//====================//
	//GET LIVING ALLIES//
	//====================//
	var _arr_allies = [];

	for (var _it_ally = 0;_it_ally < ds_list_size(_list_allies);_it_ally++){

		var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (
			_ref_ally._str_list != "ALIVE" ||
			_ref_ally._val_cur_hp <= 0
		){
			continue;
		}

		array_push(_arr_allies,_ref_ally);
	}

	var _ct_allies = array_length(_arr_allies);

	if (_ct_allies <= 0){
		return;
	}

	//===================//
	//CALCULATE SHARES//
	//===================//
	var _val_base_share = floor(_val_total_armor / _ct_allies);
	var _val_remainder = _val_total_armor mod _ct_allies;

	//====================//
	//DISTRIBUTE ARMOR//
	//====================//
	for (var _it_share = 0;_it_share < _ct_allies;_it_share++){

		var _ref_ally = _arr_allies[_it_share];
		var _val_share = _val_base_share;

		if (_it_share < _val_remainder){
			_val_share++;
		}

		// Retain the caster's own share; each other share is an actual transfer.
		if (_ref_ally != _ref_caster && _val_share > 0){
			scr_battle_transfer_armor(_ref_caster,_ref_ally,_val_share);
		}
	}
}
