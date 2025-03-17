//////////////////////////////////////////////////////////////////////
//						SCR_DAMAGE_MINIONS							//
//																	//
// > APPLIES X DAMAGE TO A MINION FROM THE UNIT'S LIST			   //
//////////////////////////////////////////////////////////////////////
function scr_damage_minions(_minion, _dmg){
	
	////////////////////
	// DAMAGE SHIELDS //
	////////////////////
	#region DAMAGE SHIELDS
	if (_minion._minion_def != 0){ //if there is a shield
		var _new_shield = _minion._minion_def - _dmg; //calc the shield change
		if (_new_shield <= 0){ //if below or equal to 0, get the damage diff and have that be the damage left
			scr_create_combat_popup(_minion,string(_minion._minion_def),"Shields",0,0);
			_dmg = abs(_minion._minion_def - _dmg);
			_minion._minion_def = 0;
			scr_create_combat_effect(undefined,spr_minion_def_break,_minion.x-16,_minion.y + 40,7,c_white,1,1,0,0,0,"Stationary",undefined,"Effects");
		}
		else if (_new_shield > 0){ //if theres hp left, update shield and no damage left to do
			_minion._minion_def = _minion._minion_def - _dmg;
			scr_create_combat_popup(_minion,string(_dmg),"Shields",0,0);
			_dmg = 0;
		}	
	}
	#endregion
	
	///////////////////
	// DAMAGE HEALTH //
	///////////////////
	if (_dmg != 0){ //if there is dmg left
		var _damage_done = _minion._minion_hp_cur - _dmg;	 //calc the damage done
		if (_damage_done <= 0){ //if below or equal to 0, get the damage diff and have that be the damage left
			_dmg = abs(_minion._minion_hp_cur - _dmg);
			scr_create_combat_popup(_minion,string(_dmg),"Damage",0,0);		
			_minion._minion_hp_cur = 0;
		}
		else if (_damage_done > 0){ //if theres hp left, update shield and no damage left to do
			_minion._minion_hp_cur = _minion._minion_hp_cur - _dmg;
			scr_create_combat_popup(_minion,string(_dmg),"Damage",0,0);
			_dmg = 0;
		}
	}
		
	return _dmg;
}