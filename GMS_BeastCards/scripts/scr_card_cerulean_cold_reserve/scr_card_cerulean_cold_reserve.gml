//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_COLD_RESERVE
// FUNCTION: Resolves Cold Reserve.
//           Consumes up to 10 Armor from the caster.
//           Heals the caster for 1 HP per Armor consumed.
//
//===============================================================================//

function scr_card_cerulean_cold_reserve(_stct_card,_ref_caster,_ref_target){

	//-----------------//
	//VALIDATE CASTER//
	//-----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//---------------------//
	//CALCULATE CONSUMPTION//
	//---------------------//
	var _val_armor_consumed =
		min(
			max(0,_ref_caster._val_armor),
			_stct_card._val_card_magnitude
		);

	//---------------//
	//CONSUME ARMOR//
	//---------------//
	if (_val_armor_consumed > 0){

		_ref_caster._val_armor -=
			_val_armor_consumed;

		_ref_caster._val_armor =
			max(
				0,
				_ref_caster._val_armor
			);

		//-----------//
		//HEAL CASTER//
		//-----------//
		scr_heal_target(
			_val_armor_consumed,
			_ref_caster
		);
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_heal,
		0,
		false
	);
}