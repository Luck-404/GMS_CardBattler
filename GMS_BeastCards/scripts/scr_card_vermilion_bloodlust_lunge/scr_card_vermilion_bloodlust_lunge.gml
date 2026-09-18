//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODLUST_LUNGE
// FUNCTION: Resolves Bloodlust Lunge.
//           Requires and consumes 3 Rage.
//           Deals linear Physical damage plus 12 additional damage.
//           EXECUTE heals the caster for 5 HP.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_bloodlust_lunge(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
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
		_ref_rage._ct_status_stacks < 3
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
	//CONSUME 3 RAGE//
	//================//
	scr_status_consume_rage(
		_ref_caster,
		3
	);

	//================//
	//STORE EXECUTE STATE//
	//================//
	var _flag_target_alive = _ref_target._val_cur_hp > 0;

	//================//
	//DEAL DAMAGE//
	//================//
	var _val_damage =
		_stct_card._val_card_magnitude +
		12;

	scr_battle_damage_target(
		_val_damage,
		_ref_target
	);

	//================//
	//EXECUTE//
	//================//
	if (
		scr_battle_trigger_execute(
			_ref_caster,
			_ref_target,
			_flag_target_alive
		)
	){
		scr_battle_heal_target(
			5,
			_ref_caster
		);
	}
}