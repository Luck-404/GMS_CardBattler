//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_FOR_THE_THROAT
// FUNCTION: Resolves For the Throat.
//           Deals percentage-based PHY damage equal to 30% of the target's
//           Maximum HP before normal PHY scaling and mitigation.
//           Applies 5 Bleed if the target survives.
//           Stuns the caster for 2 rounds without a resistance check.
//           EXECUTE heals the caster for 30% of its Maximum HP.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_for_the_throat(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//======================//
	//STORE ORIGINAL TARGET//
	//======================//
	var _ref_original_target = global.ref_target_beast;
	var _flag_target_alive = _ref_target._val_cur_hp > 0;

	//=========================//
	//DEAL 30% MAX-HP PHY DMG//
	//=========================//
	scr_battle_damage_target_percent(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//===============================//
	//TARGET SURVIVED — APPLY 5 BLEED//
	//===============================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		global.ref_target_beast = _ref_target;

		repeat (5){
			scr_status_apply_dot("BLEED");
		}
	}

	//================//
	//STUN THE CASTER//
	//================//
	if (
		instance_exists(_ref_caster) &&
		_ref_caster._val_cur_hp > 0
	){

		global.ref_target_beast = _ref_caster;

		scr_status_apply_cc(
			"STUN",
			2,
			true
		);
	}

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

		var _val_execute_healing =
			ceil(_ref_caster._val_max_hp * 0.30);

		scr_battle_heal_target(
			_val_execute_healing,
			_ref_caster
		);
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}