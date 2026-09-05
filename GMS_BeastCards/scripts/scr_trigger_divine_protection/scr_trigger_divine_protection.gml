//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_DIVINE_PROTECTION
// FUNCTION: Blocks one damage instance from an Attack card.
//           Consumes one Divine Protection stack when triggered.
//           Returns true if the damage instance should be prevented.
//
//===============================================================================//

function scr_trigger_divine_protection(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//----------------//
	//VALIDATE CARD//
	//----------------//
	var _ref_cast_card =
		global.ref_cast_card;

	if (!instance_exists(_ref_cast_card)){
		return false;
	}

	if (!is_struct(_ref_cast_card._ref_card)){
		return false;
	}

	var _stct_card =
		_ref_cast_card._ref_card;

	//------------------//
	//ATTACK DAMAGE ONLY//
	//------------------//
	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	//--------------------------//
	//CHECK DIVINE PROTECTION//
	//--------------------------//
	var _ref_divine_protection =
		scr_check_for_status(
			"DIVINE_PROTECTION",
			_ref_target
		);

	if (_ref_divine_protection == -1){
		return false;
	}

	//----------//
	//FEEDBACK//
	//----------//
	scr_battle_vfx_blocked(
		_ref_target
	);

	scr_spawn_popup_scrolling(
		"TEXT",
		"BLOCKED",
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	//--------------------//
	//CONSUME ONE STACK//
	//--------------------//
	scr_status_buff_divine_protection(
		"CONSUME",
		_ref_divine_protection
	);

	return true;
}