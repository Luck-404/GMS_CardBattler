//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_APEX_PREDATOR
// FUNCTION: Resolves Apex Predator.
//           Removes all cleansable DoTs, Debuffs, and CC from allied Beasts.
//           Gains 1 permanent Apex stack per negative stack removed.
//           Each Apex stack grants +2 linear damage.
//           Heals the caster for 2 HP per negative stack removed.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: True if the card resolves, otherwise false.
//
//===============================================================================//

function scr_card_viridian_apex_predator(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return false;
	}

	//======================//
	//GET ALLIED TEAM LIST//
	//======================//
	var _list_allies = scr_battle_get_target_team_list(_ref_caster);

	if (_list_allies == undefined){
		return false;
	}

	var _ct_total_stacks = 0;

	//========================//
	//CLEANSE THE ENTIRE TEAM//
	//========================//
	for (var _it_ally = 0;_it_ally < ds_list_size(_list_allies);_it_ally++){

		var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (_ref_ally._str_list != "ALIVE" || _ref_ally._val_cur_hp <= 0){
			continue;
		}

		_ct_total_stacks += scr_status_cleanse_negative_stacks(_ref_ally);
	}

	//================//
	//NO STACKS FOUND//
	//================//
	if (_ct_total_stacks <= 0){
		return true;
	}

	//================//
	//STORE OLD TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//================//
	//TARGET CASTER//
	//================//
	global.ref_target_beast = _ref_caster;

	//================//
	//GAIN APEX STACKS//
	//================//
	scr_status_apply_buff(
		"APEX_PREDATOR",
		_ct_total_stacks,
		-1
	);

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(_ct_total_stacks * 2,_ref_caster);

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;

	return true;
}