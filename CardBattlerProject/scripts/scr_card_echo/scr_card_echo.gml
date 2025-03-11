//////////////////////////////////////////////////////////////////////
//							SCR_CARD_ECHO							//
//																	//
// > INCREASE ECHO COUNT BY 1										//
//////////////////////////////////////////////////////////////////////
function scr_card_echo(_card,_channel,_target){
	global.echo_count += 1;	
	
	var _popup = instance_create_layer(room_width/2, room_height/2, "GUI", obj_combat_values_popup);
	_popup._text = "Echo count increased";
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
}
