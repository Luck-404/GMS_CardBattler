//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DECAYING_TOUCH
// FUNCTION: Resolves Decaying Touch.
//           Applies Wither for 3 rounds.
//           Increases Wither duration to 5 rounds if the target is Poisoned.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_decaying_touch(_stct_card,_ref_caster,_ref_target){

	//================//
	//BASE DURATION//
	//================//
	var _ct_wither_lifetime = 3;

	//================//
	//CHECK POISON//
	//================//
	var _ref_poison = scr_status_check("POISON",_ref_target);

	if (_ref_poison != -1){
		_ct_wither_lifetime = 5;
	}

	//================//
	//APPLY WITHER//
	//================//
	scr_status_apply_debuff("WITHER", _ref_target, _ct_wither_lifetime);
}