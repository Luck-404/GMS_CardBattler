//////////////////////////////////////////////////////////////////////
//					SCR_CARD_POISON_IVY_TICK						//
//																	//
// > TICK DAMAGE EACH TURN ON THE UNIT, RESET COUNT IF IT RUNS OUT  //	
//////////////////////////////////////////////////////////////////////
function scr_status_poison_tick(_counter,_target,_repeat){ 	//EFFECTED BY STACKS 	//DEFAULT LIFETIME: 3
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		var _dmg_done = scr_damage_shields(_target, 3+_counter._counter_stacks);
        _target._creature_hp_current -= _dmg_done;
		scr_create_combat_popup(_target,string(3+_counter._counter_stacks),"Poison",0,0);
		audio_play_sound(snd_effect_debuff,0,false);
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._status_poisoned = false;		
		scr_create_combat_popup(_target,"Poison cured","Poison",0,0);
		_counter._counter_delete_flag = true;
	} 
}
