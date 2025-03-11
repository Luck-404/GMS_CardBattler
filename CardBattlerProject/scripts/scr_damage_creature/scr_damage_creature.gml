//////////////////////////////////////////////////////////////////////
//						SCR_DAMAGE_CREATURE							//
//																	//
// > CLEANUP OF THE DAMAGING SCRIPTS								//
//////////////////////////////////////////////////////////////////////
function scr_damage_creature(_target,_damage_input){
	show_debug_message("DAMAGE = " + string(_damage_input));
	if (_damage_input > 0){ //if the damage reduction debuff was so effective the damage is negative
	//////////////////////////
	// DAMAGE MINIONS FIRST //
	//////////////////////////
	if (_target._creature_minion_count != 0){ //if there is a minion
		var _list = _target._creature_minion_references; 
		var _dmg_divided = _damage_input/_target._creature_minion_count;
		if (_dmg_divided mod 1 == 0){ //whole N
			
		}
		if _dmg_divded
		show_debug_message("DAMAGE DIVIDED = " + string(_dmg_divided));
		for (var _i = 0; _i < ds_list_size(_list); _i++){	
			if (_i == 0){
				var _dmg_after_hit = scr_damage_minions(_target,_dmg_divided,ds_list_find_value(_list,_i));
				show_debug_message("DAMAGE AFTER HIT = " + string(_dmg_after_hit));
				_damage_input = _damage_input - _dmg_divided + _dmg_after_hit;
				show_debug_message("NEW DAMAGE = " + string(_damage_input));
				
			} else {
				var _dmg_after_hit = scr_damage_minions(_target,_dmg_divided-1,ds_list_find_value(_list,_i));
				show_debug_message("DAMAGE AFTER HIT = " + string(_dmg_after_hit));
				_damage_input = _damage_input - _dmg_divided + _dmg_after_hit;
				show_debug_message("NEW DAMAGE = " + string(_damage_input));
			}

		}
	}
	
	////////////////////
	// DAMAGE SHIELDS //
	////////////////////
	if (_target._creature_def != 0){ //if there is a shield
		var _new_shield = _target._creature_def - _damage_input; //calc the shield change
		if (_new_shield <= 0){ //if below or equal to 0, get the damage diff and have that be the damage left
			_damage_input = abs(_target._creature_def - _damage_input);
			_target._creature_def = 0;
		}
		else if (_new_shield > 0){ //if theres hp left, update shield and no damage left to do
			_target._creature_def = _target._creature_def - _damage_input;
			_damage_input = 0;
		}
	}
	
	///////////////////
	// DAMAGE HEALTH //
	///////////////////
	_target._creature_hp_current = _target._creature_hp_current - _damage_input;	
	}
}