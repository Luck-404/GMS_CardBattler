//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_GATHERING_STORM
// FUNCTION: Resolves Gathering Storm.
//           Transfers all Stormstruck from the target's living teammates
//           onto the target without treating moved stacks as new applications.
//           The combined Status preserves the greatest current remaining
//           lifetime and stored maximum lifetime among all combined Statuses.
//           Checks DISCHARGE after every transfer has completed.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_cerulean_gathering_storm(_stct_card,_ref_caster,_ref_target){

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return;
	}

	//================//
	//GET TARGET TEAM//
	//================//
	var _list_team =
		scr_battle_get_target_team_list(_ref_target);

	if (
		_list_team == undefined ||
		!ds_exists(_list_team,ds_type_list)
	){
		return;
	}

	//================//
	//GATHER STACKS//
	//================//
	var _ct_gathered_stacks = 0;

	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(_list_team);
		_it_beast++
	){
		var _ref_beast =
			ds_list_find_value(
				_list_team,
				_it_beast
			);

		if (
			!instance_exists(_ref_beast) ||
			_ref_beast == _ref_target
		){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		_ct_gathered_stacks +=
			scr_status_transfer_stormstruck(
				_ref_beast,
				_ref_target
			);
	}

	//==========//
	//FEEDBACK//
	//==========//
	if (_ct_gathered_stacks > 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"+" +
			string(_ct_gathered_stacks) +
			" GATHERED",
			undefined,
			c_aqua,
			_ref_target.x,
			_ref_target.y - 48
		);
	}

	//================//
	//CHECK DISCHARGE//
	//================//
	scr_battle_trigger_discharge(_ref_target);
}