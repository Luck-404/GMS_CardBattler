//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CHAIN_COMBUSTION
// FUNCTION: Resolves Chain Combustion.
//           Strikes each living Burning enemy from front to back.
//           The first hit has base 8 MAG damage.
//           Each successive hit loses 1 base damage, to a minimum of 4.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected enemy team target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_chain_combustion(_stct_card,_ref_caster,_ref_target){

	//======================//
	//GET TARGET TEAM LIST//
	//======================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//================//
	//SET BASE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;

	//=====================//
	//STRIKE BURNING BEASTS//
	//=====================//
	for (var _it_target = 0;_it_target < ds_list_size(_list_targets);_it_target++){

		var _ref_hit_target = ds_list_find_value(
			_list_targets,
			_it_target
		);

		if (!instance_exists(_ref_hit_target)){
			continue;
		}

		if (_ref_hit_target._val_cur_hp <= 0){
			continue;
		}

		//----------------//
		//CHECK BURN//
		//----------------//
		var _ref_burn = scr_status_check(
			"BURN",
			_ref_hit_target
		);

		if (
			_ref_burn == -1 ||
			!instance_exists(_ref_burn)
		){
			continue;
		}

		//================//
		//DEAL DAMAGE//
		//================//
		scr_battle_damage_target(
			_val_damage,
			_ref_hit_target
		);

		//================//
		//REDUCE DAMAGE//
		//================//
		_val_damage = max(
			4,
			_val_damage - 1
		);
	}
}