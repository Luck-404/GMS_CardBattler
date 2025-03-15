//////////////////////////////////////////////////////////////////////
//				OBJ_CARD_EFFECT_COUNTER DRAW GUI					//
//																	//
// > EVERY TURN DECREMENT LIFESPAN AND TRIGGER EFFECT ONCE			//	
//////////////////////////////////////////////////////////////////////

///////////
// DEATH //
///////////
	//counter ends
	if (_counter_life <= 0){ //counter ends
		_counter_tick_script(self,_counter_target,false); //TRIGGER REFERENCE TO CLEANUP EFFECT
	}
	//host dies
	if (_counter_target != "Targetless"){
		if(_counter_target._creature_hp_current <= 0){
			_counter_delete_flag = true;
		}
	}
	
	if (_counter_delete_flag == true){
		show_debug_message("Deleting counter from " + string(_counter_list) + " at index " + string(_counter_index));
		ds_list_delete(_counter_list,_counter_index);
		instance_destroy(); //DESTROY SELF
	}
	
////////////////////////////////////////////
// CHECKER (FOR CHARGE/INFINITE STATUSES) //
////////////////////////////////////////////
	if (_counter_check_script != undefined){
		_counter_check_script(_counter_target,self);
	}

////////////////////
// TRIGGER EFFECT //
////////////////////
	if (_counter_tick_script != undefined && _counter_trigger_effect == true){
		_counter_tick_script(self,_counter_target,true);
		_counter_trigger_effect = false;
	}
	
///////////////////////
// DRAW TOOLTIP INFO //
///////////////////////
if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
	//draw info
	draw_set_font(fnt_fanwood_sm);
	draw_set_color(c_black);
	var _tooltip_x = 1420;
	var _tooltip_y = 838;
	var _output_str = "";
	
	
	_output_str += _counter_name +"\n"; //name
	_output_str += _counter_desc +"\n";//desc
	
	if (_counter_target != "Targetless"){ //spell type
		if (_counter_card == "Reaction"){
			_output_str += "Type: Reaction\n";	
		} else{
			_output_str += "Type: " + _counter_card._card_type +"\n";
		}
	} else {
		_output_str += "Type: Utility\n";
	}
	
	if (_counter_type == "General"){ //source card - for general it will be 'general', for standalone its the card name
		_output_str += "Source: " + _counter_type +"\n";
	} else {
		_output_str += "Source: " + _counter_card._card_name +"\n";
	}
	
	_output_str += "Triggers: " + _counter_trigger_period +"\n"; //when the effect triggers/decrements

	
	if (_counter_life > 10){ //turns left, anything bigger than 10 is infinite	
		_output_str += "Turns Left: Infinite\n"; 
	} else {
		_output_str += "Turns Left: " + string(_counter_life) + "\n"; 
	}
	
	_output_str += "Stacks: " + string(_counter_stacks) + "\n"; //stack count
	_output_str += "x per turn: " +  string(_counter_magnitude) + "\n"; //x per turn
	
	if (_counter_charges != 0){ //charges left on stack
		_output_str += "Charges: " + string(_counter_charges) + "\n"; 
	} else {
		_output_str += "Charges: Infinite" + "\n"; 
	}
	
	if (_counter_target != "Targetless"){
		_output_str += "Host: " + _counter_target._creature_name + "\n"; 
	} else {
		_output_str += "Host: Targetless\n"; 
	}
	
	//draw final tooltip;
	draw_text_ext(_tooltip_x,_tooltip_y,_output_str,15,150);
} 

//////////////////////////////////
// DRAW STACKS AND LIFE ON ICON //
//////////////////////////////////
	draw_set_font(fnt_fanwood_mini);
	draw_set_color(c_white);
	draw_text(x-16, y+5, string(_counter_life)); //life on left
	draw_text(x+9, y+5, string(_counter_stacks)); //stacks on right