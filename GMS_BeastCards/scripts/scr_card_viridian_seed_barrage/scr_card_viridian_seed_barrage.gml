//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SEED_BARRAGE
// FUNCTION: Resolves Seed Barrage.
//           Fires 4 magical attacks at random living Beasts
//           on the selected target's team.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_seed_barrage(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET TARGET TEAM LIST//
	//====================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//================//
	//FIRE FOUR BOLTS//
	//================//
	repeat (4){

		var _arr_living_targets = [];

		for (var _it_target = 0; _it_target < ds_list_size(_list_targets); _it_target++){

			var _ref_team_target = ds_list_find_value(_list_targets,_it_target);

			if (!instance_exists(_ref_team_target)){
				continue;
			}

			if (_ref_team_target._val_cur_hp <= 0){
				continue;
			}

			array_push(_arr_living_targets,_ref_team_target);
		}

		if (array_length(_arr_living_targets) <= 0){
			break;
		}

		var _ref_hit_target = _arr_living_targets[irandom(array_length(_arr_living_targets) - 1)];

		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_hit_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}
}