//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_THOUGHTSTEAL
// FUNCTION: Resolves the Thoughtsteal card effect.
//           Gains Mana equal to a selected enemy card's cost.
//           Disables that card for its next attempted cast.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_thoughtsteal(
	_stct_card,
	_ref_caster,
	_ref_target_card
){

	//----------------//
	// VALIDATE TARGET
	//----------------//
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
	// STEAL MANA
	//------------//
	var _val_mana_stolen = max(
		0,
		_ref_target_card
			._ref_card
			._val_card_mana_cost
	);

	obj_battle_player_controller._val_cur_mana +=
		_val_mana_stolen;

	//--------------//
	// DISABLE CARD
	//--------------//
	_ref_target_card._flag_card_disabled = true;

	//----------------//
	// PLAY ANIMATION
	//----------------//

	//-----------//
	// PLAY SOUND
	//-----------//
	audio_play_sound(snd_debuff,0,false);

	//-------------//
	// SPAWN POPUPS
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_mana_stolen) + " MANA",
		undefined,
		c_blue,
		_ref_caster.x,
		_ref_caster.y - 48
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