//////////////////////////////////////////////////////////////////////
//					SCR_CARD_SERPENT_SUMMON_TICK					//
//																	//
// > REMOVE 10DMG BUFF												//	
//////////////////////////////////////////////////////////////////////
function scr_card_serpent_summon_tick(_target,_repeat){
	if (_repeat == false){
		_target._creature_attack_linear = _target._creature_attack_linear-10;
		var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
		_popup._text = "Serpent Summoned +10dmg wore off";			
	} else {
		//check if we still have at least 1 serpent
		var _check = false;
		for (var _i = 0;  _i < ds_list_size(_target._creature_minion_references); _i++){
			var _minion = ds_list_find_value(_target._creature_minion_references,_i);
			if (_minion._minion_name == "Serpent"){
				_check = true;
			}
		}
		if (_check == false){
			scr_card_serpent_summon_tick(_target,false);
		}
	}
}