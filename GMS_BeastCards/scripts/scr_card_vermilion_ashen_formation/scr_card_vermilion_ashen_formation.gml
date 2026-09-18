//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_ASHEN_FORMATION
// FUNCTION: Resolves Ashen Formation.
//           Grants every living allied Beast 5 Armor.
//           Applies Burning Thorns to each ally for 3 rounds.
//           Each affected Beast burns the next enemy that directly damages it.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is unused.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_ashen_formation(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//====================//
	//GET ALLIED TEAM LIST//
	//====================//
	var _list_allies = scr_battle_get_target_team_list(_ref_caster);

	if (
		_list_allies == undefined ||
		!ds_exists(_list_allies,ds_type_list)
	){
		return;
	}

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//================//
	//BUFF ALL ALLIES//
	//================//
	for (var _it_ally = 0;_it_ally < ds_list_size(_list_allies);_it_ally++){

		var _ref_ally = ds_list_find_value(
			_list_allies,
			_it_ally
		);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (
			_ref_ally._str_list != "ALIVE" ||
			_ref_ally._val_cur_hp <= 0
		){
			continue;
		}

		//================//
		//GAIN 5 ARMOR//
		//================//
		scr_battle_armor_target(
			5,
			_ref_ally
		);

		//======================//
		//GAIN BURNING THORNS//
		//======================//
		global.ref_target_beast = _ref_ally;

		scr_status_apply_buff(
			"BURNING_THORNS",
			0,
			3
		);
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}