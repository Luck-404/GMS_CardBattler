//////////////////////////////////////////////////////////////////////
//					SCR_CARD_BEASTIAL_BASH_TICK						//
//																	//
// > UNSTUN THE TARGET AFTER THE TIME ENDS							//	
//////////////////////////////////////////////////////////////////////
function scr_status_stun_tick(_counter,_target,_repeat){		//STACKLESS		//DEFAULT LIFETIME: 1
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){

	} 
	
	/////////////////
	// UNDO EFFECT //
	/////////////////
	else {
		//update effect
		_target._status_stunned = false;
		scr_create_combat_popup(_target,"Stunned wore off","Default",0,0)
		_counter._counter_delete_flag = true;
	}
}