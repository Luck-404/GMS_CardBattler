//////////////////////////////////////////////////////////////////////
//					SCR_TRIGGER_STATUS_EFFECTS						//
//																	//
// > TRIGGER EVERY STATUS COUNTER THAT IS AN END OR BEGIN TURN		//
//////////////////////////////////////////////////////////////////////		
function scr_trigger_status_effects(_period,_team){
	with (obj_card_status_counter) {
		if (_counter_trigger_period == _period){
			if (_counter_target != "Targetless" && _counter_team == _team){
				show_debug_message("NOT TARGETLESS counter found");				
				show_debug_message(_period + " " + _counter_trigger_period);					
				_counter_life--;
				_counter_trigger_effect = true;	
			}			
			else if(_counter_target == "Targetless" && _counter_team  == _team){
				show_debug_message("Targetless counter found");	
				show_debug_message(_period + " " + _counter_trigger_period);	
				_counter_life--;
				_counter_trigger_effect = true;
			}

		}
	}
}