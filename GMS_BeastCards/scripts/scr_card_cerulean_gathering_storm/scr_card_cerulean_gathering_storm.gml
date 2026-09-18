//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_GATHERING_STORM
// FUNCTION: Resolves Gathering Storm.
//           Removes all Stormstruck stacks from the target's living teammates
//           and transfers them onto the target without treating the transfer
//           as new Status applications.
//           After all stacks are gathered, checks the target for DISCHARGE.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_gathering_storm(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return;
	}

	//================//
	//GET TARGET TEAM//
	//================//
	var _list_team = scr_battle_get_target_team_list(
		_ref_target
	);

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

	for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

		var _ref_beast = ds_list_find_value(
			_list_team,
			_it_beast
		);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast == _ref_target){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		//-------------------//
		//CHECK STORMSTRUCK//
		//-------------------//
		var _ref_stormstruck = scr_status_check(
			"STORMSTRUCK",
			_ref_beast
		);

		if (
			_ref_stormstruck == -1 ||
			!instance_exists(_ref_stormstruck)
		){
			continue;
		}

		//----------------//
		//GATHER STACKS//
		//----------------//
		_ct_gathered_stacks +=
			_ref_stormstruck._ct_status_stacks;

		//---------------------//
		//REMOVE DONOR STATUS//
		//---------------------//
		scr_status_dot_stormstruck(
			"DEATH",
			_ref_stormstruck
		);
	}

	//================//
	//TRANSFER STACKS//
	//================//
	if (_ct_gathered_stacks > 0){

		var _ref_target_stormstruck = scr_status_check(
			"STORMSTRUCK",
			_ref_target
		);

		//----------------//
		//STACK EXISTING//
		//----------------//
		if (
			_ref_target_stormstruck != -1 &&
			instance_exists(_ref_target_stormstruck)
		){

			_ref_target_stormstruck._ct_status_stacks +=
				_ct_gathered_stacks;
		}

		//----------------//
		//CREATE STATUS//
		//----------------//
		else{

			var _ref_original_target =
				global.ref_target_beast;

			global.ref_target_beast =
				_ref_target;

			_ref_target_stormstruck =
				scr_status_dot_stormstruck(
					"APPLY",
					undefined,
					3
				);

			global.ref_target_beast =
				_ref_original_target;

			if (instance_exists(_ref_target_stormstruck)){

				_ref_target_stormstruck._ct_status_stacks +=
					_ct_gathered_stacks - 1;
			}
		}

		//----------------//
		//REFRESH STATUS//
		//----------------//
		if (instance_exists(_ref_target_stormstruck)){

			scr_status_refresh_lifetime(
				_ref_target_stormstruck,
				3
			);

			scr_status_reposition(
				_ref_target
			);
		}

		//==========//
		//FEEDBACK//
		//==========//
		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"+" + string(_ct_gathered_stacks) + " GATHERED",
			undefined,
			c_aqua,
			_ref_target.x,
			_ref_target.y - 48
		);
	}

	//================//
	//CHECK DISCHARGE//
	//================//
	scr_battle_trigger_discharge(
		_ref_target
	);
}