//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_OATH
// FUNCTION: Resolves Blood Oath.
//           Redirects the target allied Beast's next incoming damage instance
//           to the caster.
//           When that Redirect triggers, the caster gains 2 Rage.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the protected allied Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_blood_oath(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY REDIRECT//
	//================//
	var _ref_redirect = scr_status_apply_buff("REDIRECT");

	if (!instance_exists(_ref_redirect)){
		return;
	}

	//=====================//
	//SET BLOOD OATH PAYOFF//
	//=====================//
	_ref_redirect._ct_redirect_rage_gain = 2;
	_ref_redirect._str_status_desc = "NEXT DAMAGE INSTANCE IS REDIRECTED. GUARD GAINS 2 RAGE";

	//========================//
	//UPDATE GUARD DESCRIPTION//
	//========================//
	if (
		variable_instance_exists(_ref_redirect,"_ref_redirect_guard_status") &&
		instance_exists(_ref_redirect._ref_redirect_guard_status)
	){
		_ref_redirect._ref_redirect_guard_status._str_status_desc = "NEXT DAMAGE TO LINKED ALLY IS REDIRECTED HERE. GAIN 2 RAGE";
	}
}