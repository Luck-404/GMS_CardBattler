//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FUEL_THE_FIRE
// FUNCTION: Resolves Fuel the Fire.
//           Requires and consumes 2 Rage.
//           Heals the caster for 5 HP.
//           Generates 1 Mana after Card resolution.
//           If the caster has insufficient Rage, nothing happens.
//
// ARGUMENTS: _stct_card is the Fuel the Fire Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_fuel_the_fire(_stct_card,_ref_caster,_ref_target){

	if (
		_ref_caster._str_list != "ALIVE" ||
		_ref_caster._val_cur_hp <= 0
	){
		return;
	}

	//================//
	//CHECK RAGE//
	//================//
	var _ref_rage = scr_status_check(
		"RAGE",
		_ref_caster
	);

	if (
		_ref_rage == -1 ||
		!instance_exists(_ref_rage) ||
		_ref_rage._ct_status_stacks < 2
	){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NOT ENOUGH RAGE",
			undefined,
			c_white,
			_ref_caster.x,
			_ref_caster.y - 48
		);

		return;
	}

	//================//
	//CONSUME 2 RAGE//
	//================//
	var _ct_rage_consumed = scr_status_consume_rage(
		_ref_caster,
		2
	);

	if (_ct_rage_consumed < 2){
		return;
	}

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_caster
	);

	//================//
	//GENERATE 1 MANA//
	//================//
	scr_battle_queue_mana_gain(
		1
	);
}
