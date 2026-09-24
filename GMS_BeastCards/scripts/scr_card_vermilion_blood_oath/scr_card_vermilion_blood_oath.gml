
//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_OATH
// FUNCTION: Redirects the protected ally's next damage instance to the caster.
//           Replaces the caster's previous protection relationship.
//           Grants the caster 2 Rage when this specific link triggers.
//           Preserves relationship labels and tooltip descriptions.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_blood_oath(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY REDIRECT//
	//================//
	var _ref_redirect = scr_status_apply_buff(
		"REDIRECT",
		_ref_target
	);

	if (!instance_exists(_ref_redirect)){
		return;
	}

	//=====================//
	//SET BLOOD OATH PAYOFF//
	//=====================//
	_ref_redirect._ct_redirect_rage_gain = 2;

	//=======================//
	//PRESERVE REDIRECT LABEL//
	//=======================//
	_ref_redirect._str_status_desc +=
		" | GUARD GAINS 2 RAGE";

	//========================//
	//UPDATE GUARD DESCRIPTION//
	//========================//
	if (
		variable_instance_exists(
			_ref_redirect,
			"_ref_redirect_guard_status"
		) &&
		instance_exists(_ref_redirect._ref_redirect_guard_status)
	){

		_ref_redirect._ref_redirect_guard_status._str_status_desc +=
			" | GAIN 2 RAGE ON REDIRECT";
	}
}