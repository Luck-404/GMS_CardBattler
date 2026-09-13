//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BURNING_CLEAVE
// FUNCTION: Resolves Burning Cleave.
//           Deals linear Physical damage to the front two living Beasts
//           on the selected enemy team.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_burning_cleave(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET TARGET TEAM//
	//================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//================//
	//HIT FRONT TWO//
	//================//
	var _ct_targets = min(2,ds_list_size(_list_targets));

	for (var _it_target = 0; _it_target < _ct_targets; _it_target++){

		var _ref_hit_target = ds_list_find_value(_list_targets,_it_target);

		if (!instance_exists(_ref_hit_target)){
			continue;
		}

		if (_ref_hit_target._str_list != "ALIVE" || _ref_hit_target._val_cur_hp <= 0){
			continue;
		}

		scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_hit_target);
	}
}