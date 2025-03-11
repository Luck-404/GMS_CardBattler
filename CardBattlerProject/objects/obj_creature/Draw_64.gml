//////////////////////////////////////////////////////////////////////
//					OBJ_CREATURE DRAW GUI							//
//																	//
// > DRAW GUI RELATED INFORMATION HOSTED BY THE CREATURES			//
//////////////////////////////////////////////////////////////////////
//////////////
// POSITION //
//////////////
draw_set_color(c_olive);
draw_set_font(fnt_fanwood);
draw_text(x,y-400, string(_creature_position));

/////////////////
// DEATH CHECK //
/////////////////
if (_creature_hp_current <= 0 && _flag_has_died == false){
	_creature_hp_current = 0;
	_flag_has_died = true;
	var _popup = instance_create_layer(x, y, "GUI", obj_combat_values_popup);
	_popup._type = "Death";
	image_index = 1; //DEATH SPRITE STATE
	//////////
	// ALLY //
	//////////
	if (_creature_team == "Player"){ 
		
		//update left and right references
		//left's right (was self) becomes self's right
		if (_left_unit != undefined){
			_left_unit._right_unit = _right_unit;
		}
		
		if (_right_unit != undefined){
			_right_unit._left_unit = _left_unit;
		}		
		
		//update lists
		ds_list_delete(global.player_party_in_play, _creature_position);
		ds_list_add(global.player_party_dead,self);	
		_creature_position= -1;
		
		//update positions of creatures
		for (var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
			var _unit = ds_list_find_value(global.player_party_in_play,_i);
			_unit._creature_position = _i;
		}		
		
		
	} 
	///////////
	// ENEMY //
	///////////
	else{ 
		image_xscale = -1;
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
		_creature_position= -1;
		
		//update lists
		//update positions of creatures
		for (var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){
			var _unit = ds_list_find_value(global.enemy_party_in_play,_i);
			_unit._creature_position = _i;
		}			
	}
}

if (_flag_has_died == false){
	////////////////////////
	// HOVER INTERACTIONS //
	////////////////////////
	if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
		///////////////////
		// HOVER TOOLTIP //
		///////////////////
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
		// Set the dimensions of the health bar
		var _health_bar_full_width = 100;
		var _health_bar_width = _health_bar_full_width * (_creature_hp_current / _creature_hp_max);

		// Center the health bar above the creature
		var _bar_x = x - _health_bar_full_width / 2;  // Use full width for centering
		var _bar_y = y - 100;  // Position the bar slightly above the creature

		// Draw the red background (lost health part)
		draw_set_color(c_red);
		draw_rectangle(_bar_x, _bar_y, _bar_x + _health_bar_full_width, _bar_y + 10, false);

		// Draw the green health bar on top
		draw_set_color(c_green);
		draw_rectangle(_bar_x, _bar_y, _bar_x + _health_bar_width, _bar_y + 10, false);

		// Draw the current health number on the bottom left of the HP bar
		draw_set_color(c_white);
		draw_set_font(fnt_fanwood_sm);
		draw_text(_bar_x, _bar_y + 10, string(_creature_hp_current) + "/" + string(_creature_hp_max));

	///////////////////////
	// DRAW DEFENSE ICON //
	///////////////////////
	if (_creature_def != 0){	
			// Set the drawing color for the defense (blue circle)
			draw_set_color(c_blue);

			// Draw the blue circle for the defense stat to the right of the health bar
			var _defense_circle_radius = 12; // Radius of the circle
			var _defense_x = _bar_x + _health_bar_width + 24; // Position the circle 15 pixels to the right of the health bar
			var _defense_y = _bar_y + 5; // Vertically align it with the health bar

			draw_circle(_defense_x, _defense_y, _defense_circle_radius, false);  // Draw the circle

			// Draw the defense number inside the circle
			draw_set_color(c_white);
			draw_text(_defense_x-4, _defense_y-8, string(_creature_def));  // Display the defense value inside the circle
	}
	
	///////////////////////////////
	// DRAW CC / DOT / HOT ICONS //
	///////////////////////////////
		//////////
		// STUN //
		//////////
		if(_stunned){
			draw_sprite(spr_stun,-10,x,y-125);
		}
	
		//////////////
		// DMG BUFF //
		//////////////
		if(_creature_attack_scalar != 1){
			draw_sprite(spr_dmg_buff,0,x+30,y-125);	

			draw_text(x+30,y-125,"x"+string(_creature_attack_scalar));
		}
	
		if(_creature_attack_linear != 0){
			draw_sprite(spr_dmg_buff,0,x+10,y-125);	
			if (_creature_attack_linear < 0){
				draw_text(x+10,y-125,string(_creature_attack_linear));
			} else {
				draw_text(x+10,y-125,"+"+string(_creature_attack_linear));
			}
		}
	
		//////////////
		// POISONED //
		//////////////
		if(_poison_count != 0){
			draw_sprite(spr_poison,0,x-30,y-125);	
			draw_text(x-30,y-125,string(_poison_count));
		}
		
		///////////
		// VENOM //
		///////////
		if(_venom_count != 0){
			draw_sprite(spr_venom,0,x-50,y-125);	
			draw_text(x-50,y-125,string(_venom_count));
		}		
}