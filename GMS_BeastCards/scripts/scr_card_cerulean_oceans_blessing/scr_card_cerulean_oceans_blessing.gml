//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_OCEANS_BLESSING
// FUNCTION: Resolves Ocean's Blessing.
//           Heals every living allied Beast.
//
// ARGUMENTS: _stct_card is the Ocean's Blessing card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_oceans_blessing(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET ALLIED TEAM//
	//================//
	var _list_allies = scr_battle_get_target_team_list(_ref_caster);

	if (_list_allies == undefined || !ds_exists(_list_allies,ds_type_list)){
		return;
	}

	//================//
	//HEAL ALL ALLIES//
	//================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_allies);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_allies,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		scr_battle_heal_target(
			_stct_card._val_card_magnitude,
			_ref_beast
		);
	}
}