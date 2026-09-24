//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_TOXIC_HIDE
// FUNCTION: Checks a defending Beast for Toxic Hide.
//           Applies Poison to an enemy Melee attacker based on the Buff's
//           active stacks and stored Magnitude.
//           Uses explicit effect-target references without changing battle selection.
//
// ARGUMENTS: _ref_defender, _ref_attacker.
// RETURNS: True when Toxic Hide triggers; false otherwise.
//
//===============================================================================//

function scr_status_trigger_toxic_hide(_ref_defender,_ref_attacker){

	//-------------------//
	//VALIDATE DEFENDER//
	//-------------------//
	if (!instance_exists(_ref_defender)){
		return false;
	}

	//-------------------//
	//VALIDATE ATTACKER//
	//-------------------//
	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._val_cur_hp <= 0){
		return false;
	}

	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//==================//
	//CHECK TOXIC HIDE//
	//==================//
	var _ref_toxic_hide = scr_status_check("TOXIC_HIDE",_ref_defender);

	if (_ref_toxic_hide == -1){
		return false;
	}

	if (!instance_exists(_ref_toxic_hide)){
		return false;
	}

	//==================//
	//CALCULATE POISON//
	//==================//
	var _ct_poison = _ref_toxic_hide._ct_status_stacks * _ref_toxic_hide._val_status_magnitude;

	if (_ct_poison <= 0){
		return false;
	}

	//==========//
	//FEEDBACK//
	//==========//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"TOXIC HIDE",
		undefined,
		c_green,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//==============//
	//APPLY POISON//
	//==============//
	repeat (_ct_poison){

		if (
			!instance_exists(_ref_attacker) ||
			_ref_attacker._val_cur_hp <= 0
		){
			break;
		}

		scr_status_apply_dot("POISON", _ref_attacker);
	}


	return true;
}
