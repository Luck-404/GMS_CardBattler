//////////////////////////////////////////////////////////////////////
//						SCR_DAMAGE_CREATURE							//
//																	//
// > DAMAGE THE CREATURE THROUGH MINION > SHIELD > HP				//
//////////////////////////////////////////////////////////////////////
function scr_damage_creature(_target,_damage_input){
	var _orig_dmg = _damage_input;
    //show_debug_message("DAMAGE = " + string(_damage_input));

    if (_damage_input > 0) { // Prevent negative damage

        //////////////////////////
        // DAMAGE MINIONS FIRST //
        //////////////////////////
        if (_target._creature_minion_count > 0) {
            var _list = _target._creature_minion_references;
            var _list_size = ds_list_size(_list);
            var _damage_divided = _damage_input div _list_size; // Base damage per minion
            var _damage_remainder = _damage_input mod _list_size; // Extra damage to distribute

            //show_debug_message("DAMAGE PER MINION = " + string(_damage_divided));
            //show_debug_message("DAMAGE REMAINDER = " + string(_damage_remainder));

            for (var _i = 0; _i < _list_size; _i++) {
                var _minion = ds_list_find_value(_list, _i);
                var _damage_to_minion = _damage_divided;

                // Distribute remainder among the first few minions
                if (_i < _damage_remainder) {
                    _damage_to_minion += 1;
                }

                var _dmg_after_hit = scr_damage_minions(_target, _damage_to_minion, _minion);
                //show_debug_message("MINION " + string(_i) + " TOOK DAMAGE: " + string(_damage_to_minion));
                //show_debug_message("DAMAGE AFTER HIT = " + string(_dmg_after_hit));

                // Reduce damage input by the actual damage dealt
                _damage_input -= (_damage_to_minion - _dmg_after_hit);
                //show_debug_message("NEW DAMAGE = " + string(_damage_input));
            }
        }

        ////////////////////
        // DAMAGE SHIELDS //
        ////////////////////
        if (_target._creature_def > 0) { // If there is a shield
            var _new_shield = _target._creature_def - _damage_input;
            if (_new_shield <= 0) { // Shield breaks
                _damage_input = abs(_new_shield); // Carry over remaining damage
                _target._creature_def = 0;
            } else { // Shield absorbs all damage
                _target._creature_def = _new_shield;
                _damage_input = 0;
            }
        }

        ///////////////////
        // DAMAGE HEALTH //
        ///////////////////
        _target._creature_hp_current -= _damage_input;
		
		///////////////////
		// SCROLLING DMG //
		///////////////////
		//popup the reason
		var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
		_popup._text = string(_orig_dmg);
		_popup._type = "Damage";
		
    }
}