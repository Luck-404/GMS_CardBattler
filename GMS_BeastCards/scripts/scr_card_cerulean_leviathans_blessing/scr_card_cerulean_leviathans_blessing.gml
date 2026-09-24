//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_LEVIATHANS_BLESSING
// FUNCTION: Resolves Leviathan's Blessing.
//           Transforms the selected allied Beast into Abyssal Form.
//           Abyssal Form is drawn deep blue and 25% larger through the shared
//           Beast form-draw system.
//           Fills all available Minion slots with Tentacles.
//
// ARGUMENTS: _stct_card is the Leviathan's Blessing card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_leviathans_blessing(_stct_card,_ref_caster,_ref_target){

	//===================//
	//APPLY ABYSSAL FORM//
	//===================//
	scr_status_apply_buff("ABYSSAL_FORM", _ref_target, 40, _stct_card._val_card_magnitude);

	//================//
	//FILL OPEN SLOTS//
	//================//
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
