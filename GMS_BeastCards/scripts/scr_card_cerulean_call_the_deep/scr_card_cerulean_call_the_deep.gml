//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CALL_THE_DEEP
// FUNCTION: Resolves Call the Deep.
//           Fills every available Minion slot on the selected team
//           with Tentacles.
//           Each affected Beast gains an expendable +5 direct damage Buff.
//
//===============================================================================//

function scr_card_cerulean_call_the_deep(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET SELECTED TEAM//
	//--------------------//
	var _list_targets =
		scr_battle_get_target_team_list(
			_ref_target
		);

	if (_list_targets == undefined){
		return;
	}

	//----------------//
	//STORE TARGET//
	//----------------//
	var _ref_original_target =
		global.ref_target_beast;

	//==================//
	//AFFECT EACH BEAST//
	//==================//
	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_beast =
			ds_list_find_value(
				_list_targets,
				_it_target
			);

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

		//----------------//
		//TARGET BEAST//
		//----------------//
		global.ref_target_beast =
			_ref_beast;

		//----------------------//
		//GRANT DAMAGE CHARGE//
		//----------------------//
		scr_apply_buff_status(
			"CALL_THE_DEEP",
			5
		);
	}

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;
}