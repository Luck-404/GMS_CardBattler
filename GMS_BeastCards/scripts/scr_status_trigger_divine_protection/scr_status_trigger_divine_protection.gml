//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_DIVINE_PROTECTION
// FUNCTION: Checks protection-style Buffs before Attack damage resolves.
//           Burning Parry blocks the next qualifying Melee Attack.
//           Divine Protection otherwise blocks one Attack damage instance.
//           Furnace Heart resolves later after final damage calculation.
//
// ARGUMENTS: _ref_target is the Beast receiving the incoming Attack.
// RETURNS: True if the damage instance should be prevented.
//
//===============================================================================//

function scr_status_trigger_divine_protection(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//---------------//
	//VALIDATE CARD//
	//---------------//
	var _ref_cast_card = global.ref_cast_card;

	if (!instance_exists(_ref_cast_card)){
		return false;
	}

	if (!is_struct(_ref_cast_card._ref_card)){
		return false;
	}

	var _stct_card = _ref_cast_card._ref_card;

	//------------------//
	//ATTACK DAMAGE ONLY//
	//------------------//
	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	//================//
	//BURNING PARRY//
	//================//
	if (_stct_card._str_card_range == "MELEE"){

		var _ref_burning_parry = scr_status_check("BURNING_PARRY",_ref_target);

		if (
			_ref_burning_parry != -1 &&
			instance_exists(_ref_burning_parry)
		){

			if (
				scr_status_buff_burning_parry(
					"TRIGGER",
					_ref_burning_parry
				)
			){
				return true;
			}
		}
	}

	//===================//
	//DIVINE PROTECTION//
	//===================//
	var _ref_divine_protection = scr_status_check("DIVINE_PROTECTION",_ref_target);

	if (_ref_divine_protection == -1){
		return false;
	}

	if (!instance_exists(_ref_divine_protection)){
		return false;
	}

	if (_ref_divine_protection._ct_status_stacks <= 0){
		return false;
	}

	//==========//
	//FEEDBACK//
	//==========//
	scr_battle_vfx_blocked(_ref_target);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"BLOCKED",
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	//===================//
	//CONSUME ONE STACK//
	//===================//
	scr_status_buff_divine_protection(
		"CONSUME",
		_ref_divine_protection
	);

	return true;
}