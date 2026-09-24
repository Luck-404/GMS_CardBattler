//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SPIT_VENOM
// FUNCTION: Resolves Spit Venom.
//           Deals linear physical damage to the selected target.
//           Applies 1 Venom stack if the target survives.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_spit_venom(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//================//
	//APPLY VENOM//
	//================//
	if (instance_exists(_ref_target) && _ref_target._val_cur_hp > 0){
		scr_status_apply_dot("VENOM", _ref_target);
	}
}