//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BRAMBLE_ERUPTION
// FUNCTION: Resolves the Bramble Eruption card effect.
//           Damages the selected target and adjacent living Beasts.
//           Hits up to three targets.
//
//===============================================================================//

function scr_card_viridian_bramble_eruption(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET ADJACENT TARGETS//
	//--------------------//
	var _ref_left_target = scr_get_left_target(_ref_target);
	var _ref_right_target = scr_get_right_target(_ref_target);

	//------------------//
	//HIT LEFT ADJACENT//
	//------------------//
	if (_ref_left_target != undefined){

		scr_damage_target(
			_stct_card._val_card_magnitude,
			_ref_left_target
		);
	}

	//---------------//
	//HIT MAIN TARGET//
	//---------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//-------------------//
	//HIT RIGHT ADJACENT//
	//-------------------//
	if (_ref_right_target != undefined){

		scr_damage_target(
			_stct_card._val_card_magnitude,
			_ref_right_target
		);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}