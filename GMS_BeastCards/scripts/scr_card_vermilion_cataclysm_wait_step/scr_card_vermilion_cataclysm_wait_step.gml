//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CATACLYSM_WAIT_STEP
// FUNCTION: Advances Cataclysm after a 10-frame wait.
//           Rearms the same wait object until all stages finish.
//
//===============================================================================//

function scr_card_vermilion_cataclysm_wait_step(_ref_wait){

	//================//
	//VALIDATE WAIT//
	//================//
	if (!instance_exists(_ref_wait)){
		return false;
	}

	//================//
	//GET SEQUENCE//
	//================//
	if (!variable_instance_exists(_ref_wait,"_stct_cataclysm")){
		return false;
	}

	//================//
	//RESOLVE NEXT STAGE//
	//================//
	var _flag_more_stages = scr_card_vermilion_cataclysm_resolve_stage(
		_ref_wait._stct_cataclysm
	);

	//================//
	//REARM WAIT//
	//================//
	if (_flag_more_stages){

		_ref_wait._ct_life = 10;

		return true;
	}

	return false;
}
