//////////////////////////////////////////////////////////////////////
//						SCR_GET_STATUS_COUNTER						//
//																	//
// > GIVEN AN INPUT NAME/COUNTER TYPE CHECK IF A COUNTER EXISTS, IF //
//   ONE DOES RETURN ITS REFERENCE.									//	
//////////////////////////////////////////////////////////////////////
function scr_get_status_counter(_target, _type, _card_name, _status_name){
	//////////////////////////
	// LIST TO LOOK THROUGH //
	//////////////////////////
	var _list = undefined;
	if (_target == "Global Utility"){
		_list = global.encounter_statuses;
	} else {
		_list = _target._creature_statuses;
	}

	//////////////////////
	// LOOK FOR COUNTER //
	//////////////////////
	var _return_counter = undefined;
	/////////////////////////
	// STANDALONE COUNTERS //
	/////////////////////////
	if (_type == "Standalone"){
		for (var _i = 0; _i < ds_list_size(_list); _i++){ //match card names ("Sprig of Ygg")
			var _counter = ds_list_find_value(_list,_i);
			if (_counter._counter_card._card_name == _card_name){
				_return_counter = _counter;
			}
		}
	}
	
	//////////////////////
	// GENERAL COUNTERS //
	//////////////////////
	else if (_type == "General"){
		for (var _i = 0; _i < ds_list_size(_list); _i++){ //match counter type name ("Poison")
			var _counter = ds_list_find_value(_list,_i);
			if (_counter._counter_name == _status_name){
				_return_counter = _counter;
			}
		}
	}
	return _return_counter;
}