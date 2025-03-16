//////////////////////////////////////////////////////////////////////
//					SCR_CARD_INSPIRATION_TICK						//
//																	//
// > PLAY FX EVERY TURN, AFTER THE TIMER CONCLUDES, UNDO THE BUFF 	//
//////////////////////////////////////////////////////////////////////
function scr_card_inspiration_tick(_counter,_target,_repeat){		//STACKLESS		//DEFAULT LIFETIME: 3
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		scr_create_combat_popup(undefined,"","Mana",room_width/2,room_height/2);	
		scr_create_combat_effect(undefined,spr_effect_bonus_mana_shimmer,0,779,13,c_white,1,1,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");
	} 
	
	/////////////////
	// UNDO EFFECT //
	/////////////////
	else {
		//update effect
		//decrement bonus mana
		global.bonus_mana--;
		global.cur_mana--;
		scr_create_combat_popup(undefined,"Inspiration wore off","Default",room_width/2,room_height/2);
		_counter._counter_delete_flag = true;		
	}	
}
