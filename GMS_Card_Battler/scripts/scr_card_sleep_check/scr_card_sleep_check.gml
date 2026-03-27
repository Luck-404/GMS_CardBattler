//////////////////////////////////////////////////////////////////////
//						SCR_CARD_sleep_CHECK //
//																	//
// > CHECK IF THE CHARGES HAVE BEEN USED UP FOR THE COUNTER			//
//////////////////////////////////////////////////////////////////////
function scr_card_sleep_check(_target,_counter){
	if (_target._status_sleeping == false){
		_counter._counter_life = 0;
	} 
}