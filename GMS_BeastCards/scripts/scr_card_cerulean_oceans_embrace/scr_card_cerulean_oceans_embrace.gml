//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_OCEANS_EMBRACE
// FUNCTION: Resolves Ocean's Embrace.
//           Heals every living allied Beast for a percentage of Maximum HP.
//           Removes all cleansable DoTs and Debuffs from them.
//
// ARGUMENTS: _stct_card is the Ocean's Embrace card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_oceans_embrace(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET CASTER TEAM LIST//
	//====================//
	var _list_allies = scr_battle_get_target_team_list(_ref_caster);

	if (_list_allies == undefined || !ds_exists(_list_allies,ds_type_list)){
		return;
	}

	//==================//
	//AFFECT EACH ALLY//
	//==================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_allies);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_allies,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		//----------------//
		//HEAL MAX HP %//
		//----------------//
		var _val_heal = ceil(_ref_beast._val_max_hp * (_stct_card._val_card_magnitude / 100));

		scr_battle_heal_target(
			"FIXED",
			_val_heal,
			_ref_beast
		);


		//----------------------------//
		//REMOVE ALL DOTS AND DEBUFFS //
		//----------------------------//
		scr_status_cleanse(
			_ref_beast,
			["DOT","DEBUFF"],
			"ALL"
		);
	}
}