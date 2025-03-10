//////////////////////////////////////////////////////////////////////
//					SCR_CARD_BEASTIAL_BASH_TICK						//
//																	//
// > UNSTUN THE TARGET AFTER THE TIME ENDS							//	
//////////////////////////////////////////////////////////////////////
function scr_card_beastial_bash_tick(_target,_repeat){
	if (_repeat == false){
		_target._stunned = false;
		_target._stun_counter_ref = undefined;
	} else {

	}
}