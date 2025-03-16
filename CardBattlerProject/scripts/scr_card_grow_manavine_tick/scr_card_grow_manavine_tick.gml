//////////////////////////////////////////////////////////////////////
//					SCR_CARD_GROW_MANAVINE_TICK						//
//																	//
// > RESET THE BUFF AFTER IT CONCLUDES								//	
//////////////////////////////////////////////////////////////////////
function scr_card_grow_manavine_tick(_counter,_target,_repeat){
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
		global.bonus_mana-=2;
		global.cur_mana-=2;
		scr_create_combat_popup(undefined,"Manavine wore off","Default",room_width/2,room_height/2);
		_counter._counter_delete_flag = true;		
	}	
}