//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_POWER_STRIKE
// FUNCTION: Resolves Power Strike.
//           Deals damage using custom hit VFX and SFX.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_power_strike(_stct_card,_ref_caster,_ref_target){

	//=======================//
	//PRESENTATION OVERRIDE//
	//=======================//
	var _stct_presentation = {
		_spr_vfx_override : spr_battle_vfx_power_strike,
		_snd_sfx_override : spr_battle_vfx_power_strike
	};

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target,
		_stct_presentation
	);
}