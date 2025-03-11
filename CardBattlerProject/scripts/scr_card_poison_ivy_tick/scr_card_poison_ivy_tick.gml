//////////////////////////////////////////////////////////////////////
//					SCR_CARD_POISON_IVY_TICK						//
//																	//
// > TICK DAMAGE EACH TURN ON THE UNIT, RESET COUNT IF IT RUNS OUT  //	
//////////////////////////////////////////////////////////////////////
function scr_card_poison_ivy_tick(_target,_repeat){
	if (_repeat == false){
		_target._poison_count = 0;
		_target._poison_counter_ref = undefined;
		
		var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
		_popup._text = "Cured";
		_popup._type = "Poison";			
	} 
	else {
		var _stacks = _target._poison_count;
		_target._creature_hp_current -= abs(_target._creature_def-(3+(1*_stacks)));	
		_target._creature_def -= (3+(1*_stacks));
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
		
		var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
		_popup._text = string(3+_stacks);
		_popup._type = "Poison";			
	}
}
