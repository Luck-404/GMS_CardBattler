//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FLAMESPAWN
// FUNCTION: Resolves Flamespawn.
//           Summons up to 3 Cinderlings into available allied Minion slots.
//           Prioritizes the selected allied Beast, then other living allies.
//           Never replaces existing Minions.
//
// ARGUMENTS: _stct_card is the Flamespawn Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected allied Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_flamespawn(_stct_card,_ref_caster,_ref_target){

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (
		_ref_target._str_team != _ref_caster._str_team ||
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return;
	}

	//================//
	//GET ALLIED TEAM//
	//================//
	var _list_allies = scr_battle_get_target_team_list(
		_ref_caster
	);

	if (
		_list_allies == undefined ||
		!ds_exists(_list_allies,ds_type_list)
	){
		return;
	}

	//================//
	//TRACK SUMMONS//
	//================//
	var _ct_summoned = 0;
	var _ct_summon_max = 3;

	//========================//
	//PRIORITIZE SELECTED HOST//
	//========================//
	while (
		_ct_summoned < _ct_summon_max &&
		scr_minion_has_open_slot(_ref_target)
	){

		var _ref_cinderling = scr_minion_init(
			"CINDERLING",
			_stct_card,
			_ref_caster,
			_ref_target
		);

		if (!instance_exists(_ref_cinderling)){
			break;
		}

		_ct_summoned++;
	}

	//=======================//
	//FILL OTHER ALLIED SLOTS//
	//=======================//
	for (
		var _it_ally = 0;
		_it_ally < ds_list_size(_list_allies);
		_it_ally++
	){

		//----------------//
		//SUMMON LIMIT//
		//----------------//
		if (_ct_summoned >= _ct_summon_max){
			break;
		}

		var _ref_ally = ds_list_find_value(
			_list_allies,
			_it_ally
		);

		//----------------//
		//VALIDATE ALLY//
		//----------------//
		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (_ref_ally == _ref_target){
			continue;
		}

		if (
			_ref_ally._str_list != "ALIVE" ||
			_ref_ally._val_cur_hp <= 0
		){
			continue;
		}

		//======================//
		//SUMMON INTO OPEN SLOTS//
		//======================//
		while (
			_ct_summoned < _ct_summon_max &&
			scr_minion_has_open_slot(_ref_ally)
		){

			var _ref_cinderling = scr_minion_init(
				"CINDERLING",
				_stct_card,
				_ref_caster,
				_ref_ally
			);

			if (!instance_exists(_ref_cinderling)){
				break;
			}

			_ct_summoned++;
		}
	}

	//================//
	//NO OPEN SLOTS//
	//================//
	if (_ct_summoned <= 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NO OPEN MINION SLOTS",
			undefined,
			c_ltgray,
			_ref_caster.x,
			_ref_caster.y - 48
		);
	}
}