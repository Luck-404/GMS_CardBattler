//////////////////////////////////////////////////////////////////////
//						SCR_CARD_ZONE_IN_CHECK						//
//																	//
// > CHECK IF THE CHARGES HAVE BEEN USED UP FOR THE COUNTER			//
//////////////////////////////////////////////////////////////////////
function scr_card_zone_in_check(_target,_counter){
	// check latest channel == target and latest card == attack
	if (_counter._latest_channel == _target && _counter._latest_damage != 0){
		show_debug_message("CONDITION MET");
		_counter._counter_life = 0;
	} 
}