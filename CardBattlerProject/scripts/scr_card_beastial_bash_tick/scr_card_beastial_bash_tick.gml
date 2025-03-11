//////////////////////////////////////////////////////////////////////
//					SCR_CARD_BEASTIAL_BASH_TICK						//
//																	//
// > UNSTUN THE TARGET AFTER THE TIME ENDS							//	
//////////////////////////////////////////////////////////////////////
function scr_card_beastial_bash_tick(_target,_repeat){
	if (_repeat == false){
		_target._stunned = false;
		_target._stun_counter_ref = undefined;
		
		var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
		_popup._text = "Stunned wore off";		
	} else {

	}
}