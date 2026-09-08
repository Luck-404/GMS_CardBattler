//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_LEVIATHANS_BLESSING
// FUNCTION: Resolves Leviathan's Blessing.
//           Transforms the target allied Beast into Abyssal Form for 5 rounds.
//           Abyssal Form is drawn deep blue and 25% larger through the shared
//           Beast form-draw system.
//           Fills all available Minion slots with Tentacles.
//
//===============================================================================//

function scr_card_cerulean_leviathans_blessing(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._str_team != _ref_caster._str_team){
		return;
	}

	//-------------------//
	//APPLY ABYSSAL FORM//
	//-------------------//
	scr_apply_buff_status(
		"ABYSSAL_FORM",
		40,
		_stct_card._val_card_magnitude
	);

	//----------------//
	//FILL OPEN SLOTS//
	//----------------//
	repeat (_ref_target._ct_minions_max){

		if (!scr_minion_has_open_slot(_ref_target)){
			break;
		}

		scr_minion_init(
			"TENTACLE",
			_stct_card,
			_ref_caster,
			_ref_target
		);
	}
}