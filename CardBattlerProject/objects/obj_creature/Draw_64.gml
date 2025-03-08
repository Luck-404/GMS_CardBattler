//////////////////////////////////////////////////////////////////////
//					OBJ_CREATURE DRAW GUI							//
//																	//
// > DRAW GUI RELATED INFORMATION HOSTED BY THE CREATURES			//
//////////////////////////////////////////////////////////////////////
/////////////////
// DEATH CHECK //
/////////////////
if (_creature_hp_current <= 0 && _flag_has_died == false){
	_creature_hp_current = 0;
	_flag_has_died = true;
	image_index = 1; //DEATH SPRITE STATE
	if (_creature_team == "Player"){ //IF ALLY
		//update left and right references
		//left's right (was self) becomes self's right
		if (_left_unit != undefined){
			_left_unit._right_unit = _right_unit;
		}
		
		if (_right_unit != undefined){
			_right_unit._left_unit = _left_unit;
		}		
		
		ds_list_delete(global.player_party_in_play, _creature_position);
		ds_list_add(global.player_party_dead,self);	
	} else{ //IF ENEMY
		//update left and right references
		if (_left_unit != undefined){
			_left_unit._right_unit = _right_unit;
		}
		
		if (_right_unit != undefined){
			_right_unit._left_unit = _left_unit;
		}		
		
		if (_card_to_play != undefined){
			instance_destroy(_card_to_play);	
		}
		ds_list_delete(global.enemy_party_in_play,_creature_position);
		ds_list_add(global.enemy_party_dead,self);		
	}
}
if (_flag_has_died == false){
	////////////////////////
	// HOVER INTERACTIONS //
	////////////////////////
	if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
		//draws info box
		draw_set_color(c_grey);
		draw_rectangle(mouse_x+10,mouse_y,mouse_x+155, mouse_y+100,false);
	
		//draw info
		draw_set_font(fnt_fanwood_sm);
		draw_set_color(c_white);
	
		draw_text(mouse_x+15, mouse_y+5, _creature_name + " " + string(_creature_hp_current) + "/" + string(_creature_hp_max));
		draw_text(mouse_x+15, mouse_y+20, "Defense: " + string(_creature_def));	
		draw_text(mouse_x+15, mouse_y+35, _creature_color1 + " " + _creature_color2);	
		draw_text(mouse_x+15, mouse_y+50, _creature_subtype);	
		draw_text(mouse_x+15, mouse_y+60, _creature_spec);	
		draw_text(mouse_x+15, mouse_y+70, _creature_class);	
	
		//TODO draw list of stuns/debuffs/DoTs
		//TODO draw list of buffs/auras/HoTs
	
	} 
	/////////////////////
	// DRAW HEALTH BAR //
	/////////////////////
	// Set the drawing color for the health bar (green)
	draw_set_color(c_green);
	draw_set_font(fnt_fanwood);
	// Calculate the width of the health bar based on current health
	var _health_bar_width = 100 * (_creature_hp_current / _creature_hp_max);

	// Center the health bar above the creature
	var _bar_x = x - 32 - _health_bar_width / 2;  // Center bar horizontally (x + 64 for the middle of the creature)
	var _bar_y = y - 100;  // Position the bar slightly above the creature

	// Draw the health bar
	draw_rectangle(_bar_x, _bar_y, _bar_x + _health_bar_width, _bar_y + 10, false);

	// Draw the current health number on the left side of the health bar
	draw_set_color(c_white);
	draw_text(_bar_x + 5, _bar_y + 3, string(_creature_hp_current) + "/" + string(_creature_hp_max));

	///////////////////////
	// DRAW DEFENSE ICON //
	///////////////////////
	// Set the drawing color for the defense (blue circle)
	draw_set_color(c_blue);

	// Draw the blue circle for the defense stat to the right of the health bar
	var _defense_circle_radius = 12; // Radius of the circle
	var _defense_x = _bar_x + _health_bar_width + 30; // Position the circle 15 pixels to the right of the health bar
	var _defense_y = _bar_y + 5; // Vertically align it with the health bar

	draw_circle(_defense_x, _defense_y, _defense_circle_radius, false);  // Draw the circle

	// Draw the defense number inside the circle
	draw_set_color(c_white);
	draw_text(_defense_x-8, _defense_y - 17, string(_creature_def));  // Display the defense value inside the circle

	///////////////////
	// DRAW COUNTERS //
	///////////////////

	//stun
	if(_stunned){
		draw_sprite(spr_stun,0,x,y-50);
	}
	
	//damage bonus
	if(_creature_attack_scalar != 1){
		draw_sprite(spr_dmg_buff,0,x+20,y-70);	
		draw_text(x+30,y-70,"x"+string(_creature_attack_scalar));
	}
	
	if(_creature_attack_linear != 0){
		draw_sprite(spr_dmg_buff,0,x,y-70);	
		draw_text(x+10,y-70,"+"+string(_creature_attack_linear));
	}
	
	//poison
	if(_poison_count != 0){
		draw_sprite(spr_poison,0,x,y-60);	
		draw_text(x+10,y-60,string(_poison_count));
	}
}