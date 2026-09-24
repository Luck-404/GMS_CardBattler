//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THORN_STORM
// FUNCTION: Resolves Thorn Storm.
//           Deals 2 separate magical damage hits to every living Beast
//           on the selected enemy team.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_thorn_storm(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET TARGET TEAM LIST//
	//====================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//==================//
	//DAMAGE ENEMY TEAM//
	//==================//
	for (var _it_target = 0; _it_target < ds_list_size(_list_targets); _it_target++){

		var _ref_hit_target = ds_list_find_value(_list_targets,_it_target);

		if (!instance_exists(_ref_hit_target)){
			continue;
		}

		if (_ref_hit_target._val_cur_hp <= 0){
			continue;
		}

		//----------------//
		//HIT TARGET TWICE//
		//----------------//
		repeat (2){

			if (!instance_exists(_ref_hit_target) || _ref_hit_target._val_cur_hp <= 0){
				break;
			}

			scr_battle_damage_target(
				"LINEAR",
				_ref_caster,
				_ref_hit_target,
				_stct_card._val_card_magnitude,
				{card: _stct_card, card_instance: global.ref_cast_card}
			);
		}
	}
}
