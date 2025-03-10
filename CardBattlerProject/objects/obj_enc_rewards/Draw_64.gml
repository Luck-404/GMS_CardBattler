//////////////////////////////////////////////////////////////////////
//					OBJ_ENC_REWARDS	DRAW GUI						//
//																	//
// > DRAW GUI													    //
//////////////////////////////////////////////////////////////////////

/////////////////
// DRAW BG BOX //
/////////////////
draw_set_color(c_grey);
draw_rectangle(room_width/2 - 150,room_height/2 - 200,room_width/2 + 150,room_height/2 + 200,false);
draw_set_color(c_white);

/////////
// WIN //
/////////
if (_type == "win" && _flag_init == false){ //INIT ONCE
	_flag_init = true;	
	////////////////////
	// ROLL 1-3 CARDS //
	////////////////////
	var _rand_rewards = irandom_range(1,3);
	// Roll a rarity for each card
	for (var _i = 0; _i < _rand_rewards; _i++) {
		var _rarity_roll = irandom_range(1, 100); // Determine rarity
		var _card = undefined;
		
		if (50 < _rarity_roll < 100){ //50% common
			_card = scr_roll_card("common");
		} else if (20 < _rarity_roll < 50){ //30% uncommon
			_card = scr_roll_card("uncommon");
		} else if (10 < _rarity_roll < 20){ //10% rare
			_card = scr_roll_card("rare");
		} else if (3 < _rarity_roll < 10){ //7% epic
			_card = scr_roll_card("epic");
		} else if (1 < _rarity_roll < 3){ //3% legendary
			_card = scr_roll_card("legendary");
		}
			
		ds_list_add(global.player_deck, _card);
	}
		
	//////////////////
	// CREATE CARDS //
	//////////////////
	#region Card 1
	var _ref_card1 = instance_create_layer(room_width/2,room_height/2+100,"GUI", obj_card);
	_ref_card1.depth = -101;
	_ref_card1._reward = true;
	_ref_card1.image_index = 0;
	_ref_card1.image_speed = 0;
	_ref_card1.sprite_index = ds_list_find_value(global.player_deck,ds_list_size(global.player_deck)-1)[?"sprite"];
	_ref_card1.image_xscale = 0.20;
	_ref_card1.image_yscale = 0.20;
	#endregion
	#region Card 2
	if (_rand_rewards > 1){
	var _ref_card2 = instance_create_layer(room_width/2-100,room_height/2+100,"GUI", obj_card);
	_ref_card2.depth = -101;
	_ref_card2._reward = true;
	_ref_card2.image_index = 0;
	_ref_card2.image_speed = 0;
	_ref_card2.sprite_index = ds_list_find_value(global.player_deck,ds_list_size(global.player_deck)-2)[?"sprite"];	
	_ref_card2.image_xscale = 0.20;
	_ref_card2.image_yscale = 0.20;		
	}
	#endregion	
	#region Card 3	
	if (_rand_rewards >2 ){
	var _ref_card3 = instance_create_layer(room_width/2+100,room_height/2+100,"GUI", obj_card);
	_ref_card3.depth = -101;
	_ref_card3._reward = true;
	_ref_card3.image_index = 0;
	_ref_card3.image_speed = 0;
	_ref_card3.sprite_index = ds_list_find_value(global.player_deck,ds_list_size(global.player_deck)-2)[?"sprite"];	
	_ref_card3.image_xscale = 0.20;
	_ref_card3.image_yscale = 0.20;	
	#endregion
}
				
//give gold, display it
global.gold_randomizer = irandom_range(40,50);
global.gold = global.gold + global.gold_randomizer;
				
}
if (_type == "win"){ //ALWAYS
	draw_set_color(c_white);
	draw_set_font(fnt_fanwood);
	draw_text(room_width/2-100,room_height/2-100,"You've won!");
	draw_text(room_width/2-100,room_height/2-80,"Gained " + string(global.gold_randomizer) + " gold!");
	draw_text(room_width/2-100,room_height/2-60,"Gained cards:");
}

//////////
// LOSS //
//////////
if (_type == "loss"){
	draw_set_color(c_white);	
	draw_set_font(fnt_fanwood);
	draw_text(room_width/2-100,room_height/2-100,"You've lost!");
	draw_text(room_width/2-100,room_height/2-50,"send back to main menu...");	
}

/////////////
// FORFEIT //
/////////////	
if (_type == "forfeit"){
	draw_set_color(c_white);	
	draw_set_font(fnt_fanwood);
	draw_text(room_width/2-100,room_height/2-100,"You've forfeited!");
	draw_text(room_width/2-100,room_height/2-50,"All units lose 25% hp!");
}
		
///////////////////
// CONFIRM LOGIC //
///////////////////
if (_clicked == false && position_meeting(mouse_x,mouse_y,obj_confirm) && mouse_check_button_pressed(mb_left)){
	if (_type == "win"){
		_clicked = true;
		global.flag_gui_open = false;
		show_debug_message("			TRANSITION TO OVERWORLD FROM ENCOUNTER (WIN)");			
		scr_transition("overworld","return","Any","Any");
		instance_destroy();
	}
	
	else if(_type == "loss"){
		_clicked = true;
		//on game loss confirm- send to title screen
		//start transition to title
		global.flag_gui_open = false;		
		show_debug_message("			TRANSITION TO MAIN MENU FROM ENCOUNTER (LOSS)");			
		scr_transition("main menu","loss","Any","Any");	
		instance_destroy();
	}
	
	else if(_type == "forfeit"){
		_clicked = true;
		global.flag_gui_open = false;		
		//on forfeit confirm
		//take 25% max hp from all units
		for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
			var _ref_unit = ds_list_find_value(global.player_party, _i);
			var _cur_hp = _ref_unit[?"curhp"];
			_cur_hp = floor(_cur_hp * 0.75);
			_ref_unit[?"curhp"] = _cur_hp;
		}
		//start transition to overworld
		show_debug_message("			TRANSITION TO OVERWORLD FROM ENCOUNTER (FORFEIT)");		
		scr_transition("overworld","return","Any","Any");
		instance_destroy();
	}
}
