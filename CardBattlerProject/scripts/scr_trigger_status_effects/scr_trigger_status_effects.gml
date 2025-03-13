//////////////////////////////////////////////////////////////////////
//					SCR_TRIGGER_STATUS_EFFECTS						//
//																	//
// > TRIGGER EVERY STATUS COUNTER THAT IS AN END OR BEGIN TURN		//
//////////////////////////////////////////////////////////////////////		
function scr_trigger_status_effects(_period,_team){
	with (obj_card_status_counter) {
		if (_counter_target == "Targetless"){
			if (_counter_trigger_period == _period){
				_counter_life--;
				_counter_trigger_effect = true;
			}
		}
		else if (_counter_target._creature_team == _team && _counter_trigger_period == _period){
			_counter_life--;
			_counter_trigger_effect = true;
		}						
	}	
}