//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEEP_CURRENT
// FUNCTION: Resolves Deep Current.
//           Deals linear Magical damage to the selected target, then draws
//           1 card. If the surviving target has Stormstruck, gathers all
//           adjacent Stormstruck onto it while preserving the greatest
//           remaining lifetime among the combined Statuses.
//           Checks DISCHARGE only after the complete transfer finishes.
//
// ARGUMENTS: _stct_card is the Deep Current card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//
function scr_card_cerulean_deep_current(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{
			card: _stct_card,
			card_instance: global.ref_cast_card
		}
	);

	//================//
	//DRAW CARD//
	//================//
	scr_battle_draw_cards(1);

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (
		!instance_exists(_ref_target) ||
		_ref_target._val_cur_hp <= 0
	){
		return;
	}

	//===================//
	//CHECK STORMSTRUCK//
	//===================//
	var _ref_stormstruck =
		scr_status_check(
			"STORMSTRUCK",
			_ref_target
		);

	if (
		_ref_stormstruck == -1 ||
		!instance_exists(_ref_stormstruck)
	){
		return;
	}

	//======================//
	//GET ADJACENT TARGETS//
	//======================//
	var _arr_adjacent_targets = [
		scr_battle_get_left_target(_ref_target),
		scr_battle_get_right_target(_ref_target)
	];

	var _ct_gathered_stacks = 0;

	//=========================//
	//GATHER STORMSTRUCK STACKS//
	//=========================//
	for (
		var _it_target = 0;
		_it_target < array_length(_arr_adjacent_targets);
		_it_target++
	){
		var _ref_adjacent_target =
			_arr_adjacent_targets[_it_target];

		if (!instance_exists(_ref_adjacent_target)){
			continue;
		}

		if (
			_ref_adjacent_target._str_list != "ALIVE" ||
			_ref_adjacent_target._val_cur_hp <= 0
		){
			continue;
		}

		_ct_gathered_stacks +=
			scr_status_transfer_stormstruck(
				_ref_adjacent_target,
				_ref_target
			);
	}

	if (_ct_gathered_stacks <= 0){
		return;
	}

	//================//
	//CHECK DISCHARGE//
	//================//
	scr_battle_trigger_discharge(_ref_target);
}