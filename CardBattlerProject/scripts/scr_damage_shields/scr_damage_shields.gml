//////////////////////////////////////////////////////////////////////
//						SCR_DAMAGE_SHIELDS							//
//																	//
// > APPLIES X DAMAGE TO AN ENEMY SHIELD			    			//
//////////////////////////////////////////////////////////////////////
function scr_damage_shields(_target, _dmg){
	////////////////////
	// DAMAGE SHIELDS //
	////////////////////
	#region DAMAGE SHIELDS
	if (_target._creature_def != 0){ //if there is a shield
        var _new_shield = _target._creature_def - _dmg;
        if (_new_shield <= 0) { // Shield breaks
			scr_create_combat_popup(_target,"-"+string(_target._creature_def),"Shields",0,0);
            _dmg = abs(_new_shield); // Carry over remaining damage
            _target._creature_def = 0;
			audio_play_sound(snd_effect_break_shield,0,false);			
        } else { // Shield absorbs all damage
            _target._creature_def = _new_shield;
			scr_create_combat_popup(_target,"-"+string(_dmg),"Shields",0,0);
            _dmg = 0;
        }
	}
	#endregion
	
	return _dmg;
}