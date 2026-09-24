//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CAUTERIZED_WOUND
// FUNCTION: Applies Antiheal for 2 rounds.
//           If the target is Burning, applies Antiheal for 3 rounds instead.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_cauterized_wound(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET LIFETIME//
	//================//
	var _val_lifetime = 2;

	//================//
	//CHECK BURN//
	//================//
	var _ref_burn = scr_status_check("BURN",_ref_target);

	if (
		_ref_burn != -1 &&
		instance_exists(_ref_burn) &&
		_ref_burn._ct_status_stacks > 0
	){
		_val_lifetime = 3;
	}

	//================//
	//APPLY ANTIHEAL//
	//================//
	scr_status_apply_debuff("ANTIHEAL", _ref_target, _val_lifetime);
}