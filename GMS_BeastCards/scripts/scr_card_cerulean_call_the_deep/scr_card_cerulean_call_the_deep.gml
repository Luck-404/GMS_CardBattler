//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CALL_THE_DEEP
// FUNCTION: Resolves Call the Deep.
//           Fills every available Minion slot on the selected team with Tentacles.
//           Each affected Beast gains an expendable +5 direct damage Buff.
//
// ARGUMENTS: _stct_card is the Call the Deep card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_call_the_deep(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET SELECTED TEAM//
	//====================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined || !ds_exists(_list_targets,ds_type_list)){
		return;
	}

	var _ct_targets = ds_list_size(_list_targets);


	//==================//
	//AFFECT EACH BEAST//
	//==================//
	for (var _it_target = 0;_it_target < _ct_targets;_it_target++){

		var _ref_beast = ds_list_find_value(_list_targets,_it_target);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//FILL OPEN SLOTS//
		//----------------//
		repeat (_ref_beast._ct_minions_max){

			if (!scr_minion_has_open_slot(_ref_beast)){
				break;
			}

			scr_minion_init(
				"TENTACLE",
				_stct_card,
				_ref_caster,
				_ref_beast
			);
		}


		//----------------------//
		//GRANT DAMAGE CHARGE//
		//----------------------//
		scr_status_apply_buff("CALL_THE_DEEP", _ref_beast, 5);
	}

}