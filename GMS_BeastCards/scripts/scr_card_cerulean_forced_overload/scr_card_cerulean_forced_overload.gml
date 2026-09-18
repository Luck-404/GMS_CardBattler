//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FORCED_OVERLOAD
// FUNCTION: Resolves Forced Overload.
//           Deals linear Magical damage.
//           If the surviving target has at least 4 Stormstruck, removes half
//           of its current stacks and applies half the removed amount
//           to each adjacent living Beast, minimum 1.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_forced_overload(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (
		!instance_exists(_ref_target) ||
		_ref_target._val_cur_hp <= 0
	){
		return;
	}

	//================//
	//GET STORMSTRUCK//
	//================//
	var _ref_stormstruck = scr_status_check(
		"STORMSTRUCK",
		_ref_target
	);

	if (
		_ref_stormstruck == -1 ||
		!instance_exists(_ref_stormstruck)
	){
		return;
	}

	var _ct_stacks_before =
		_ref_stormstruck._ct_status_stacks;

	if (_ct_stacks_before < 4){
		return;
	}

	//================//
	//WEAK OVERLOAD//
	//================//
	var _ct_removed = max(
		1,
		floor(_ct_stacks_before * 0.5)
	);

	var _ct_spread = max(
		1,
		floor(_ct_removed * 0.5)
	);

	_ref_stormstruck._ct_status_stacks -=
		_ct_removed;

	scr_status_refresh_lifetime(
		_ref_stormstruck,
		3
	);

	scr_status_reposition(_ref_target);

	//================//
	//OVERLOAD FEEDBACK//
	//================//
	scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_discharge,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_discharge
	);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"FORCED OVERLOAD",
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	//================//
	//GET ADJACENT//
	//================//
	var _arr_adjacent_targets = [
		scr_battle_get_left_target(_ref_target),
		scr_battle_get_right_target(_ref_target)
	];

	var _ref_original_target =
		global.ref_target_beast;

	//================//
	//SPREAD STACKS//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_adjacent_targets);_it_target++){

		var _ref_adjacent =
			_arr_adjacent_targets[_it_target];

		if (!instance_exists(_ref_adjacent)){
			continue;
		}

		if (
			_ref_adjacent._str_list != "ALIVE" ||
			_ref_adjacent._val_cur_hp <= 0
		){
			continue;
		}

		global.ref_target_beast = _ref_adjacent;

		repeat (_ct_spread){
			scr_status_apply_dot("STORMSTRUCK");
		}
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast =
		_ref_original_target;

	//================//
	//DEBUG TRIGGER//
	//================//
	scr_debug_log_battle_trigger(
		"FORCED OVERLOAD",
		_ref_caster,
		_ref_target,
		"STORMSTRUCK: " +
		string(_ct_stacks_before) +
		" -> " +
		string(_ref_stormstruck._ct_status_stacks) +
		" | REMOVED: " +
		string(_ct_removed) +
		" | SPREAD EACH: " +
		string(_ct_spread),
		"SCR_CARD_CERULEAN_FORCED_OVERLOAD"
	);
}