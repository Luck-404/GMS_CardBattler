//////////////////////////////////////////////////////////////////////
//						SCR_DAMAGE_CREATURE							//
//																	//
// > DAMAGE THE CREATURE THROUGH MINION > SHIELD > HP				//
//////////////////////////////////////////////////////////////////////
function scr_damage_creature(_target,_damage_input){
	//////////////////////////////////////////////////////////////////////////
	// CHECK IF INPUT WAS NEGATIVE (DUE TO A LARGE DECREASE IN ATTACK POWER //
	//////////////////////////////////////////////////////////////////////////
    if (_damage_input == 0) { // Prevent negative damage
		//////////////////
		// COMBAT POPUP //
		//////////////////
		scr_create_combat_popup(_target,"0","Damage",0,0);
	}
	
	
	
	///////////////////////////////////////////////////////////
	// HANDLE DAMAGE IN ORDER: MINIONS > SHIELDS > TARGET HP //
	///////////////////////////////////////////////////////////
	else {
        //////////////////////////
        // DAMAGE MINIONS FIRST //
        //////////////////////////
		#region DAMAGE MINIONS
        if (_target._creature_minion_count > 0) { //if there is at least 1 minion
            var _list = _target._creature_minion_references;
            var _list_size = ds_list_size(_list);
            var _damage_divided = _damage_input div _list_size; // Base damage per minion
            var _damage_remainder = _damage_input mod _list_size; // Extra damage to distribute
			
			//for every minion, apply the damage
            for (var _i = 0; _i < _list_size; _i++) {
                var _minion = ds_list_find_value(_list, _i);
                var _damage_to_minion = _damage_divided;

                // Distribute remainder among the first few minions
                if (_i < _damage_remainder) {
                    _damage_to_minion += 1;
                }

                var _dmg_after_hit = scr_damage_minions(_minion, _damage_to_minion);
				
                // Reduce damage input by the actual damage dealt
                _damage_input -= (_damage_to_minion - _dmg_after_hit);
            }
        }
		#endregion

        ////////////////////
        // DAMAGE SHIELDS //
        ////////////////////
		#region DAMAGE SHIELDS
        if (_target._creature_def > 0) { // If there is a shield
			_damage_input = scr_damage_shields(_target,_damage_input);
        }
		#endregion

        ///////////////////
        // DAMAGE HEALTH //
        ///////////////////
        _target._creature_hp_current -= _damage_input;
		
		//////////////////
		// COMBAT POPUP //
		//////////////////
		scr_create_combat_popup(_target,string(_damage_input),"Damage",0,0);
		
    }
}