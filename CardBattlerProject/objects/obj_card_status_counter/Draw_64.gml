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
		//remove counter from the creature or fight controller list
		ds_list_delete(_counter_list,_counter_index);
		instance_destroy(); //DESTROY SELF
	}
	//host dies
	if (_counter_target != "Global Utility"){
		if(_counter_target._creature_hp_current <= 0){
			ds_list_delete(_counter_list,_counter_index);
			instance_destroy(); //DESTROY SELF
		}
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
	//draws info box
	draw_set_color(c_grey);
	draw_rectangle(mouse_x+10,mouse_y,mouse_x+200, mouse_y+100,false);
	
	//draw info
	draw_set_font(fnt_fanwood_sm);
	draw_set_color(c_white);
	
	draw_text(mouse_x+15, mouse_y+5, _counter_name); //name
	draw_text(mouse_x+15, mouse_y+20, _counter_desc); //desc
	if (_counter_target != "Global Utility"){
	draw_text(mouse_x+15, mouse_y+35, "Type: " + _counter_card._card_type); //spell type
	}
	
	//source card - for general it will be 'general', for standalone its the card name
	if (_counter_type == "General"){
		draw_text(mouse_x+15, mouse_y+50,"Status source: " + _counter_type);	
	} else {
		draw_text(mouse_x+15, mouse_y+50, "Status source: " + _counter_card._card_name);	
	}
	
	draw_text(mouse_x+15, mouse_y+65, "Trigger time: " + _counter_trigger_period);	//when the effect triggers/decrements
	
	//turns left, anything bigger than 10 is infinite
	if (_counter_life > 10){
		draw_text(mouse_x+15, mouse_y+80, "Turns Left: ∞");		
	} else {
		draw_text(mouse_x+15, mouse_y+80, "Turns Left: " + string(_counter_life));	
	}
	
	draw_text(mouse_x+15, mouse_y+95, "Stacks: " + string(_counter_stacks));	//stack count
	draw_text(mouse_x+15, mouse_y+110, "Magnitude per stack: " +  string(_counter_magnitude));	//damage per turn
	
	if (_counter_charges != undefined){
		draw_text(mouse_x+15, mouse_y+125, "Charges: " + string(_counter_charges));		
	} else {
		draw_text(mouse_x+15, mouse_y+125, "Charges: ∞");	
	}
	if (_counter_target != "Global Utility"){
	draw_text(mouse_x+15, mouse_y+140, "Host: " + _counter_target._creature_name);	
	}
} 

//////////////////////////////////
// DRAW STACKS AND LIFE ON ICON //
//////////////////////////////////
	draw_set_font(fnt_fanwood_mini);
	draw_set_color(c_white);
	draw_text(x-16, y+5, string(_counter_life)); //life on left
	draw_text(x+9, y+5, string(_counter_stacks)); //stacks on right