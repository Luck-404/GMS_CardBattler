//////////////////////////////////////////////////////////////////////
//					SCR_CARD_SERPENT_SUMMON_DISABLE					//
//																	//
// > TURN OFF THE +10 BONUS FROM SERPENT SUMMON IF ALL ARE DEAD		//
//////////////////////////////////////////////////////////////////////
function scr_card_serpent_summon_check(_target,_counter){
	var _check = false;
	///////////
	// CHECK //
	///////////
	for (var _i = 0;  _i < ds_list_size(_target._creature_minion_references); _i++){
		var _minion = ds_list_find_value(_target._creature_minion_references,_i);
		if (_minion._minion_name == "Serpent"){ //if we have at least 1 serpent minion
			_check = true;
		}
	}
	
	/////////////////
	// CHECK FAILS //
	/////////////////
	if (_check == false){
		_counter._counter_life = 0;
	}
}