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
// RETURNS: No value.
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

	var _flag_target_alive = _ref_target._val_cur_hp > 0;

	//=========================//
	//DEAL 30% MAX-HP PHY DMG//
	//=========================//
	scr_battle_damage_target(
		"PERCENT",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//===============================//
	//TARGET SURVIVED — APPLY 5 BLEED//
	//===============================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){


		repeat (5){
			scr_status_apply_dot("BLEED", _ref_target);
		}
	}

	//================//
	//STUN THE CASTER//
	//================//
	if (
		instance_exists(_ref_caster) &&
		_ref_caster._val_cur_hp > 0
	){


		scr_status_apply_cc("STUN", _ref_caster, 2, true);
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
			"FIXED",
			_val_execute_healing,
			_ref_caster
		);

	}

}