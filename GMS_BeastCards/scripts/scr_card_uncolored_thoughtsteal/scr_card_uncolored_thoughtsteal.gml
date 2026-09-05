//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_THOUGHTSTEAL
// FUNCTION: Resolves Thoughtsteal.
//           Gains Mana equal to the selected enemy card's Mana Cost.
//           Disables that card for its next attempted cast.
//           Uses the shared Mana Gain system for resource presentation.
//
//===============================================================================//

function scr_card_uncolored_thoughtsteal(
	_stct_card,
	_ref_caster,
	_ref_target_card
){

	//---------------//
	//VALIDATE TARGET//
	//---------------//
	if (!instance_exists(_ref_target_card)){
		return false;
	}

	if (
		_ref_target_card._str_team != "ENEMY" ||
		_ref_target_card._str_location != "HAND"
	){
		return false;
	}

	if (_ref_target_card._flag_card_disabled){
		return false;
	}

	if (_ref_target_card._ref_card == undefined){
		return false;
	}

	//------------//
	//STEAL MANA//
	//------------//
	var _val_mana_stolen =
		max(
			0,
			_ref_target_card
				._ref_card
				._val_card_mana_cost
		);

	scr_gain_mana(
		_val_mana_stolen
	);

	//--------------//
	//DISABLE CARD//
	//--------------//
	_ref_target_card._flag_card_disabled =
		true;

	//-------------------//
	//DISABLE FEEDBACK//
	//-------------------//
	audio_play_sound(
		snd_debuff,
		0,
		false
	);

	scr_spawn_popup_scrolling(
		"TEXT",
		"CARD DISABLED",
		undefined,
		c_black,
		_ref_target_card.x,
		_ref_target_card.y - 48
	);

	return true;
}