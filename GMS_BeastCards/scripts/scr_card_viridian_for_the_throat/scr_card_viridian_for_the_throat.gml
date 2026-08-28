//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_FOR_THE_THROAT
// FUNCTION: Resolves the For the Throat Archetype card.
//           Deals percentage-based PHY damage equal to 30% of the target's
//           maximum HP before normal PHY scaling and mitigation.
//           Applies 5 Bleed if the target survives.
//           Stuns the caster for 2 rounds without a resistance check.
//           EXECUTE: If the direct attack defeats the target, heals the caster
//           for 30% of its maximum HP.
//
//===============================================================================//

function scr_card_viridian_for_the_throat(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//------------------//
	//TARGET WAS ALIVE//
	//------------------//
	var _flag_target_alive =
		_ref_target._val_cur_hp > 0;

	//-------------------------//
	//DEAL 30% MAX-HP PHY DMG//
	//-------------------------//
	scr_damage_target_percent(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	//CHECK EXECUTE//
	//----------------//
	var _flag_execute =
		_flag_target_alive &&
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp <= 0;

	//===============================//
	//TARGET SURVIVED — APPLY 5 BLEED//
	//===============================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		global.ref_target_beast =
			_ref_target;

		repeat (5){

			scr_apply_dot_status(
				"BLEED"
			);
		}
	}

	//================//
	//STUN THE CASTER//
	//================//
	if (
		instance_exists(_ref_caster) &&
		_ref_caster._val_cur_hp > 0
	){

		global.ref_target_beast =
			_ref_caster;

		// Guaranteed self-inflicted Stun.
		scr_apply_cc_status(
			"STUN",
			2,
			true
		);
	}

	//================//
	//EXECUTE — HEAL//
	//================//
	if (
		_flag_execute &&
		instance_exists(_ref_caster) &&
		_ref_caster._val_cur_hp > 0
	){

		var _val_execute_healing =
			ceil(
				_ref_caster._val_max_hp *
				0.30
			);

		scr_heal_target(
			_val_execute_healing,
			_ref_caster
		);

		scr_spawn_popup_scrolling(
			"TEXT",
			"EXECUTE",
			undefined,
			c_green,
			_ref_caster.x,
			_ref_caster.y - 48
		);
	}

	//----------------//
	//RESTORE TARGET//
	//----------------//
	if (instance_exists(_ref_original_target)){

		global.ref_target_beast =
			_ref_original_target;
	}
	else{

		global.ref_target_beast =
			_ref_target;
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_attack,
		0,
		false
	);
}