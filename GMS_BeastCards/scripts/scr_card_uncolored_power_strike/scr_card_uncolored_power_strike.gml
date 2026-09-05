//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_POWER_STRIKE
// FUNCTION: Resolves the Power Strike card effect.
//           Deals damage using custom hit VFX and SFX.
//
//===============================================================================//

function scr_card_uncolored_power_strike(_stct_card,_ref_caster,_ref_target){

	//---------------------//
	//PRESENTATION OVERRIDE//
	//---------------------//
	var _stct_presentation = {
		_spr_vfx_override : spr_battle_vfx_power_strike,
		_snd_sfx_override : snd_power_strike
	};

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target,
		_stct_presentation
	);
}