//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_OPEN_VEIN
// FUNCTION: Resolves Open Vein.
//           Deals linear Physical damage to the selected target.
//           Applies 1 Bleed, then triggers HEMORRHAGE.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_open_vein(_stct_card,_ref_caster,_ref_target){

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

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//APPLY 1 BLEED//
	//================//


	scr_status_apply_dot("BLEED", _ref_target);


	//================//
	//HEMORRHAGE//
	//================//
	scr_battle_trigger_hemorrhage(_ref_target);
}