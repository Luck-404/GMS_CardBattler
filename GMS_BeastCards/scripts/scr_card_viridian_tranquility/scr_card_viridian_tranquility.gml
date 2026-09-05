//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_TRANQUILITY
// FUNCTION: Resolves Tranquility.
//           Adds 1 Echo to the global Echo Buff.
//           Heals every living allied Beast for 3 HP.
//
//===============================================================================//

function scr_card_viridian_tranquility(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//GAIN ECHO//
	//-----------//
	scr_gain_echo(1);

	//--------------------//
	//GET CASTER TEAM LIST//
	//--------------------//
	var _list_targets =
		scr_get_target_team_list(
			_ref_caster
		);

	if (_list_targets == undefined){
		return;
	}

	//----------------//
	//HEAL ALL ALLIES//
	//----------------//
	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_affected_target =
			ds_list_find_value(
				_list_targets,
				_it_target
			);

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		scr_heal_target(
			3,
			_ref_affected_target
		);
	}
}