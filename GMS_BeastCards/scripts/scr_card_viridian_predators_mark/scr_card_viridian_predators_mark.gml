//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PREDATORS_MARK
// FUNCTION: Resolves Predator's Mark.
//           Applies Vulnerable to the selected Beast.
//           Extends the application by 1 round if the target has
//           Bleed, Poison, or Venom.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_predators_mark(_stct_card,_ref_caster,_ref_target){

	//=======================//
	//SET VULNERABLE DURATION//
	//=======================//
	var _ct_vulnerable_lifetime = 3;

	//====================//
	//CHECK VIRIDIAN DOTS//
	//====================//
	var _flag_has_dot =
		scr_status_check("BLEED",_ref_target) != -1 ||
		scr_status_check("POISON",_ref_target) != -1 ||
		scr_status_check("VENOM",_ref_target) != -1;

	if (_flag_has_dot){
		_ct_vulnerable_lifetime++;
	}

	//================//
	//APPLY VULNERABLE//
	//================//
	scr_status_apply_debuff("VULNERABLE", _ref_target, _ct_vulnerable_lifetime);
}