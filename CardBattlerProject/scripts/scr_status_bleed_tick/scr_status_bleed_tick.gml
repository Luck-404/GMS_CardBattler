//////////////////////////////////////////////////////////////////////
//					SCR_CARD_bleed						//
//																	//
// > TICK DAMAGE EACH TURN ON THE UNIT, RESET COUNT IF IT RUNS OUT  //	
//////////////////////////////////////////////////////////////////////
function scr_status_bleed_tick(_counter,_target,_repeat){ 	//EFFECTED BY STACKS 	//DEFAULT LIFETIME: 3
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
        _target._creature_hp_current -= 2*_counter._counter_stacks;
		scr_create_combat_popup(_target,string(_counter._counter_stacks),"Damage",0,0);
		audio_play_sound(snd_effect_debuff,0,false);
		scr_create_combat_effect(_target,spr_effect_dripping,0,0,36,c_red,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");	
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._status_bleeding = false;		
		scr_create_combat_popup(_target,"Bleed staunched","Damage",0,0);
		_counter._counter_delete_flag = true;
	} 
}
