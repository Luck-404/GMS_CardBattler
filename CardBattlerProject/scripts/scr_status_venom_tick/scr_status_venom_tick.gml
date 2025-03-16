//////////////////////////////////////////////////////////////////////
//							SCR_CARD_VENOM_TICK						//
//																	//
// > TICK DAMAGE EACH TURN ON THE UNIT, RESET COUNT IF IT RUNS OUT  //	
//////////////////////////////////////////////////////////////////////
function scr_status_venom_tick(_counter,_target,_repeat){ //EFFECTED BY STACKS //DEFAULT LIFETIME: 3	
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		var _dmg_done = scr_damage_shields(_target, 3*_counter._counter_stacks);
        _target._creature_hp_current -= _dmg_done;
		scr_create_combat_popup(_target,string(3*_counter._counter_stacks),"Venom",0,0);
		audio_play_sound(snd_effect_debuff,0,false);	
		scr_create_combat_effect(_target,spr_effect_dripping,0,0,36,c_purple,0.25,0.25,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		show_debug_message("REMOVING VENOM STACK");
		_target._status_venom = false;		
		_target._creature_attack_linear = _target._creature_attack_linear+_counter._counter_stacks;
		scr_create_combat_popup(_target,"Venom cured","Venom",0,0);
		_counter._counter_delete_flag = true;		
	} 	
}
