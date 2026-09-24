//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RAZOR_FIN
// FUNCTION: Resolves Razor Fin.
//           Deals linear physical damage to the selected target.
//           Applies 1 Bleed if the target survives.
//
// ARGUMENTS: _stct_card is the Razor Fin card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_razor_fin(_stct_card,_ref_caster,_ref_target){

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
	//APPLY BLEED//
	//================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_status_apply_dot("BLEED", _ref_target);
	}
}