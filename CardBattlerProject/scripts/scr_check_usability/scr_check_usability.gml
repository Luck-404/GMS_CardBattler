//////////////////////////////////////////////////////////////////////
//							SCR_CHECK_USABILITY						//
//																	//
// > Checks if a card can be channeled through based on a variety	//
//	 of limiting factors											//
//////////////////////////////////////////////////////////////////////
function scr_check_usability(_ref_card){
	show_debug_message("usability checking card: " + _ref_card._card_name);	
	//check if you have enough mana
	if(global.cur_mana < _ref_card._card_cost){
		show_debug_message("not enough mana");
		return false
	}
	//check if you have a unit that matches the color of the card
		//for each unit
		if(_ref_card._card_color == "Uncolored"){
			
		} else {
			var _found_a_colored_unit = false;
			for(var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
				var _unit = ds_list_find_value(global.player_party_in_play, _i);
				if ((_unit._creature_color1 == _ref_card._card_color) || (_unit._creature_color2 == _ref_card._card_color)){
					_found_a_colored_unit = true;
				}
			}
			if (_found_a_colored_unit == false){
				show_debug_message("no unit found with a correct color");
				return false;
			}
		}
		
		
	//check if you have a unit of the right major class (mar, tech, mag)
		//for each unit
		var _found_a_spec_unit = false;
		if(_ref_card._card_type_req == "Any"){
			
		} else {		
			for(var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
				var _unit = ds_list_find_value(global.player_party_in_play, _i);
				if (_unit._creature_spec == _ref_card._card_type_req){
					_found_a_spec_unit = true;
				}
			}
			if (_found_a_spec_unit == false){
				show_debug_message("no unit found with a correct spec");
				return false;
			}
		}
		
		
	//check if you have a unit of the right class
		//for each unit
		if(_ref_card._card_class_req == "Any"){
			
		} else {		
			var _found_a_class_unit = false;
			for(var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
				var _unit = ds_list_find_value(global.player_party_in_play, _i);
				if (_unit._creature_class == _ref_card._card_class_req){
					_found_a_class_unit = true;
				}
			}
			if (_found_a_class_unit == false){
				show_debug_message("no unit found with a correct class");
				return false;
			}
		}
	return true;
}