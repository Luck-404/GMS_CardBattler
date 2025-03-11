//////////////////////////////////////////////////////////////////////
//						SCR_DAMAGE_MINIONS							//
//																	//
// > APPLIES X DAMAGE TO A MINION FROM THE UNIT'S LIST			   //
//////////////////////////////////////////////////////////////////////
function scr_damage_minions(_unit, _dmg, _minion){
	var _orig_dmg = _dmg;
	////////////////////
	// DAMAGE SHIELDS //
	////////////////////
	if (_minion._minion_def != 0){ //if there is a shield
		var _new_shield = _minion._minion_def - _dmg; //calc the shield change
		if (_new_shield <= 0){ //if below or equal to 0, get the damage diff and have that be the damage left
			_dmg = abs(_minion._minion_def - _dmg);
			_minion._minion_def = 0;
		}
		else if (_new_shield > 0){ //if theres hp left, update shield and no damage left to do
			_minion._minion_def = _minion._minion_def - _dmg;
			_dmg = 0;
		}
	}
	
	///////////////////
	// DAMAGE HEALTH //
	///////////////////
	if (_dmg != 0){ //if there is dmg left
		var _damage_done = _minion._minion_hp_cur - _dmg;	 //calc the damage done
		if (_damage_done <= 0){ //if below or equal to 0, get the damage diff and have that be the damage left
			_dmg = abs(_minion._minion_hp_cur - _dmg);
			_minion._minion_hp_cur = 0;
		}
		else if (_damage_done > 0){ //if theres hp left, update shield and no damage left to do
			_minion._minion_hp_cur = _minion._minion_hp_cur - _dmg;
			_dmg = 0;
		}
	}
	
	///////////////////
	// SCROLLING DMG //
	///////////////////
	//popup the reason
	var _popup = instance_create_layer(_minion.x, _minion.y, "GUI", obj_combat_values_popup);
	_popup._text = string(_orig_dmg);
	_popup._type = "Damage";
		
	return _dmg;
}