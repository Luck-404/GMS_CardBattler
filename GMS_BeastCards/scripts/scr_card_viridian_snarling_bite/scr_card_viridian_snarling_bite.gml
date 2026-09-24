//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SNARLING_BITE
// FUNCTION: Resolves Snarling Bite.
//           Deals linear physical damage to the selected target.
//           Applies Vulnerable if the attack damages the target's HP.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_snarling_bite(_stct_card,_ref_caster,_ref_target){

	//===================//
	//SNAPSHOT TARGET HP//
	//===================//
	var _val_hp_before = _ref_target._val_cur_hp;

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

	//=============================//
	//APPLY VULNERABLE IF HP WAS HIT//
	//=============================//
	var _val_hp_after = _ref_target._val_cur_hp;

	if (_val_hp_after < _val_hp_before){
		scr_status_apply_debuff("VULNERABLE", _ref_target);
	}
}