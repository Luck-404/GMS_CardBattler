//////////////////////////////////////////////////////////////////////
//					SCR_CARD_POTENT_FRUIT_TICK						//
//																	//
// > UNDO BUFF AFTER TIMER ELAPSED									//	
//////////////////////////////////////////////////////////////////////
function scr_card_potent_fruit_tick(_target,_repeat){
	if (_repeat == false){
		_target._creature_attack_scalar = _target._creature_attack_scalar-1;
		var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
		_popup._text = "Potent Fruit wore off";		
	} 
	else {
		var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_potent_fruit_repeat;		
	}
}