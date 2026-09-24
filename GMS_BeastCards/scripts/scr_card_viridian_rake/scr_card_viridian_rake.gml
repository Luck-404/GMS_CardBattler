//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_RAKE
// FUNCTION: Deals Linear PHY damage to a single target.
//           Applies 1 Bleed to the surviving target.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_rake(_stct_card,_ref_caster,_ref_target){

	//================//
	//DAMAGE TARGET//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//================//
	//APPLY BLEED//
	//================//
	if (instance_exists(_ref_target) && _ref_target._val_cur_hp > 0){
		scr_status_dot_bleed("APPLY",_ref_target,1);
	}
}