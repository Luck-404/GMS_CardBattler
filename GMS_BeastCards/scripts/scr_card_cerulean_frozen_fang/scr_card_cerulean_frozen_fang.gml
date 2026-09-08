//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_FANG
// FUNCTION: Resolves the Frozen Fang card effect.
//           Deals linear physical damage to the selected target.
//           Applies 1 Frostbite if the target survives.
//
//===============================================================================//

function scr_card_cerulean_frozen_fang(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//DEAL DAMAGE//
	//-----------//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//---------------//
	//APPLY FROSTBITE//
	//---------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_status_apply_dot("FROSTBITE");
	}

}