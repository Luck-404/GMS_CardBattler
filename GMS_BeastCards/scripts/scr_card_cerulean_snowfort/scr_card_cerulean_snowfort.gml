//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SNOWFORT
// FUNCTION: Resolves Snowfort.
//           Grants Armor to every living allied Beast.
//
// ARGUMENTS: _stct_card is the Snowfort card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_snowfort(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET ALLIED TEAM LIST//
	//====================//
	var _list_allies = scr_battle_get_target_team_list(_ref_caster);

	if (_list_allies == undefined || !ds_exists(_list_allies,ds_type_list)){
		return;
	}

	//================//
	//GRANT TEAM ARMOR//
	//================//
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

		scr_battle_armor_target(
			"FIXED",
			_stct_card._val_card_magnitude,
			_ref_ally
		);
	}
}