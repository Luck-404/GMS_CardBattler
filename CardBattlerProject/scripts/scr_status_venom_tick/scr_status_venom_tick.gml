//////////////////////////////////////////////////////////////////////
//							SCR_CARD_VENOM_TICK						//
//																	//
// > TICK DAMAGE EACH TURN ON THE UNIT, RESET COUNT IF IT RUNS OUT  //	
//////////////////////////////////////////////////////////////////////
function scr_venom_tick(_target,_repeat){
	//EFFECTED BY STACKS	
	//DEFAULT LIFETIME: 3	
	if (_repeat == false){ //removal
		//fix debuff
		_target._creature_attack_linear = _target._creature_attack_linear+_target._venom_count;
		
		//clear venom
		_target._venom_count = 0;
		_target._venom_counter_ref = undefined;
		
		var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
		_popup._text = "Cured";
		_popup._type = "Venom";

	} 
	
	
	else { //damage scales with each stack
		var _stacks = _target._venom_count;
		_target._creature_hp_current -= abs(_target._creature_def-(3*_stacks));	
		_target._creature_def -= (3*_stacks);
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
		
		var _popup = instance_create_layer(target.x, target.y, "GUI", obj_combat_values_popup);
		_popup._text = string(3*_stacks);
		_popup._type = "Venom";		
	}
}
