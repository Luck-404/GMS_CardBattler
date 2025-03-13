//////////////////////////////////////////////////////////////////////
//					SCR_CARD_SERPENT_SUMMON_DISABLE					//
//																	//
// > TURN OFF THE +10 BONUS FROM SERPENT SUMMON IF ALL ARE DEAD		//
//////////////////////////////////////////////////////////////////////
function scr_card_serpent_summon_disable(_target,_counter){
	//check if we still have at least 1 serpent
	var _check = false;
	for (var _i = 0;  _i < ds_list_size(_target._creature_minion_references); _i++){
		var _minion = ds_list_find_value(_target._creature_minion_references,_i);
		if (_minion._minion_name == "Serpent"){
			_check = true;
		}
	}
	if (_check == false){
		var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
		_popup._text = "Serpent Summon dmg boost wore off";		
		_counter._counter_life = 0;
	}
}