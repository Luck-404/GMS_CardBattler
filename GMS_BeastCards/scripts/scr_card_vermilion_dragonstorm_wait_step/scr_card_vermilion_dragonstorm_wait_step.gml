//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_DRAGONSTORM_WAIT_STEP
// FUNCTION: Resolves the next Dragonstorm hit after a 5-frame wait.
//           Rearms the wait until all 20 hits have resolved.
//
//===============================================================================//

function scr_card_vermilion_dragonstorm_wait_step(_ref_wait){

	//================//
	//VALIDATE WAIT//
	//================//
	if (!instance_exists(_ref_wait)){
		return false;
	}

	//================//
	//VALIDATE SEQUENCE//
	//================//
	if (!variable_instance_exists(_ref_wait,"_stct_dragonstorm")){
		return false;
	}

	//================//
	//RESOLVE NEXT HIT//
	//================//
	var _flag_more_hits = scr_card_vermilion_dragonstorm_hit(
		_ref_wait._stct_dragonstorm
	);

	//================//
	//REARM WAIT//
	//================//
	if (_flag_more_hits){

		_ref_wait._ct_life = 5;

		return true;
	}

	//================//
	//FINISH SEQUENCE//
	//================//
	return false;
}