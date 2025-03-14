//////////////////////////////////////////////////////////////////////
//						SCR_DAMAGE_CREATURE							//
//																	//
// > DAMAGE THE CREATURE THROUGH MINION > SHIELD > HP				//
//////////////////////////////////////////////////////////////////////
function scr_heal_creature(_target,_heal_linear,_heal_percent){
	var _p = 0;
	
	/////////////////
	// HEAL LINEAR //
	/////////////////
	if (_heal_linear != 0){
		_target._creature_hp_current += _heal_linear; //add the hp
	
		if (_target._creature_hp_current > _target._creature_hp_max){ //check for overflow
			_target._creature_hp_current = _target._creature_hp_max;
		}
	} 
	
	//////////////////
	// HEAL PERCENT //
	//////////////////
	else {
		_p = ceil((_host._creature_hp_max)*_heal_percent); //get 5% of max hp

		_target._creature_hp_current += _p; //add the hp
	
		if (_target._creature_hp_current > _target._creature_hp_max){ //check for overflow
			_target._creature_hp_current = _target._creature_hp_max;
		}
	
	}
	
	//////////////////
	// COMBAT POPUP //
	//////////////////
	if (_heal_linear != 0){
		scr_create_combat_popup(_target,string(_heal_linear),"Healing",0,0);
	} else {
		scr_create_combat_popup(_target,string(_p),"Healing",0,0);
	}
		
}