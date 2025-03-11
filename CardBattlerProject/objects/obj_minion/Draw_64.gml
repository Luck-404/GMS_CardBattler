//////////////////////////////////////////////////////////////////////
//						OBJ_MINION DRAW GUI							//
//																	//
// > DRAW GUI RELATED INFORMATION HOSTED BY THE MINIONS				//
//////////////////////////////////////////////////////////////////////
//////////////
// POSITION //
//////////////
draw_set_color(c_olive);
draw_set_font(fnt_fanwood);
draw_text(x,y+50, string(_minion_position));

/////////////////
// DEATH CHECK //
/////////////////
if ((_minion_unit_attached != undefined && _minion_unit_attached._creature_hp_current <= 0) || (_minion_hp_cur <= 0 && _flag_has_died == false)){
	_flag_has_died = true;
	
	var _popup = instance_create_layer(x, y, "GUI", obj_combat_values_popup);
	_popup._type = "Death";
	
	//remove minion from attached unit
	_minion_unit_attached._creature_minion_count--;
	ds_list_delete(_minion_unit_attached._creature_minion_references, _minion_position);
	
	//update positions of creatures
	for (var _i = 0; _i < ds_list_size(_minion_unit_attached._creature_minion_references); _i++){
		var _minion = ds_list_find_value(_minion_unit_attached._creature_minion_references, _i);
		_minion._minion_position = _i;
	}			
	//destroy self
	instance_destroy();
}

/////////////////////////////
// HANDLE SCRIPT EXECUTION //
/////////////////////////////
if (_minion_cast_types[0] == "Minion Step"){
	if (_minion_effect_script != undefined && _trigger_my_effect == true && _minion_unit_attached._creature_hp_current > 0){
		_minion_effect_script(_minion_unit_attached,self);
		_trigger_my_effect = false;
	}
}


if (_latest_target != undefined && _latest_channel != undefined){
	////////////////////////////////
	// HOST DAMAGE TAKEN REACTION //
	////////////////////////////////
	if (_minion_cast_types[1] == "Host Damage Taken"){
		//show_debug_message("MINION: " + _latest_target._creature_name + " has taken " + string(_latest_damage_done));
		if(_latest_target == _minion_unit_attached && _latest_damage_done != 0){
			if (_minion_name == "Bramblet"){
				//show_debug_message("BRAMBLET: TRIGGERED");
				//deal 10% damage back to channeler
				var _10p = ceil(_latest_damage_done*0.10);
				//show_debug_message("BRAMBLET: dealing " + string(_10p) + " to " + _latest_channel._creature_name);
				//deal dmg
				scr_damage_creature(_latest_channel,_10p);
	
				var _popup2 = instance_create_layer(_latest_channel.x, _latest_channel.y, "GUI", obj_combat_values_popup);
				_popup2._text = string(_10p);
				_popup2._type = "Damage";	
		
				////////////
				// EFFECT //
				////////////
				var _ref_effect = instance_create_layer(_minion_unit_attached.x,_minion_unit_attached.y,"Effects",obj_card_effect);
				_ref_effect.sprite_index = spr_effect_red_strike;
	
				///////////
				// SOUND //
				///////////
				audio_play_sound(snd_effect_strike,0,false);
			}
			
			if (_minion_name == "Serpent"){
				//show_debug_message("SERPENT: VENOM TRIGGERED");

				//show_debug_message("SERPENT: applying venom to " + _latest_channel._creature_name);
		
				//CHECK FOR POISON
				if (_latest_channel._venom_count == 0){	//IF NO VENOM
					//set up a poison counter
					var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_effect_counter);
					_ref_counter.x = _latest_channel.x+10;
					_ref_counter.y = _latest_channel.y - 100;
					_ref_counter._draw_color = c_purple;	
					_ref_counter._turn_lifespan = 3;
					_ref_counter._trigger_time = "End";
					_latest_channel._venom_counter_ref = _ref_counter;
					_ref_counter._trigger_my_effect = false;
					_ref_counter._reference_script = scr_card_venom_tick;
					_ref_counter._target = _latest_channel;
			
					//EFFECT
					var _ref_effect1 = instance_create_layer(_latest_channel.x,_latest_channel.y,"Effects",obj_card_effect);
					_ref_effect1.sprite_index = spr_effect_venom;
			
					//apply venom stacks
					_latest_channel._venom_count++;
					//apply debuff stacks from venom
					_latest_channel._creature_attack_linear--;
				} 
				//IF VENOM, RENEW AND SCALE VENOM
				else {
					_latest_channel._venom_counter_ref._turn_lifespan = 3;
					_latest_channel._venom_count++;
					_latest_channel._creature_attack_linear--;
				}
		
	
				///////////
				// SOUND //
				///////////
				audio_play_sound(snd_effect_poison_ivy,0,false);
			}
		}
	}

	////////////////////////////////
	// HOST DAMAGE DEALT REACTION //
	////////////////////////////////
	if (_minion_cast_types[2] == "Host Damage Dealt"){
		if((_latest_channel == _minion_unit_attached) && _latest_damage_done != 0){
				if (_minion_name == "Bloodbeak"){
					//show_debug_message("BLOODBEAK: TRIGGERED");
					var _20p = ceil(_latest_damage_done*0.20); //get 20% of max hp

					_minion_unit_attached._creature_hp_current += _20p; //add the hp
					//show_debug_message("BLOODBEAK: healing " + string(_20p) + " on host " + _minion_unit_attached._creature_name);
					if (_minion_unit_attached._creature_hp_current > _minion_unit_attached._creature_hp_max){ //check for overflow
						_minion_unit_attached._creature_hp_current = _minion_unit_attached._creature_hp_max;
					}
					
					var _popup2 = instance_create_layer(_minion_unit_attached.x, _minion_unit_attached.y, "GUI", obj_combat_values_popup);
					_popup2._text = string(_20p);
					_popup2._type = "Healing";	
				
					////////////
					// EFFECT //
					////////////
					var _ref_effect = instance_create_layer(_minion_unit_attached.x,_minion_unit_attached.y,"Effects",obj_card_effect);
					_ref_effect.sprite_index = spr_effect_grow_natures_remedy;
		
					//deal dmg
					//show_debug_message("BLOODBEAK: dealing 5 to unit " + _latest_target._creature_name);
					scr_damage_creature(_latest_target,5);
		
					////////////
					// EFFECT //
					////////////
					_ref_effect = instance_create_layer(_latest_target.x,_latest_target.y,"Effects",obj_card_effect);
					_ref_effect.sprite_index = spr_effect_red_strike;
			}
			if (_minion_name == "Serpent"){
				//show_debug_message("SERPENT: HEALING TRIGGERED");
				var _20p = ceil(_latest_damage_done*0.20); //get 20% of max hp

				_minion_unit_attached._creature_hp_current += _20p; //add the hp
				//show_debug_message("SERPENT: healing " + string(_20p) + " on host " + _minion_unit_attached._creature_name);
				if (_minion_unit_attached._creature_hp_current > _minion_unit_attached._creature_hp_max){ //check for overflow
					_minion_unit_attached._creature_hp_current = _minion_unit_attached._creature_hp_max;
				}
				
				var _popup2 = instance_create_layer(_minion_unit_attached.x, _minion_unit_attached.y, "GUI", obj_combat_values_popup);
				_popup2._text = string(_20p);
				_popup2._type = "Healing";	
					
				////////////
				// EFFECT //
				////////////
				var _ref_effect = instance_create_layer(_minion_unit_attached.x,_minion_unit_attached.y,"Effects",obj_card_effect);
				_ref_effect.sprite_index = spr_effect_grow_natures_remedy;
		}			
		}
	}

	//restore keys
	_latest_damage_done = undefined;
	_latest_channel = undefined;
	_latest_target = undefined;
	_latest_card = undefined;
}
////////////////////////
// HOVER INTERACTIONS //
////////////////////////
if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
	//draws info box
	draw_set_color(c_grey);
	draw_rectangle(mouse_x+10,mouse_y,mouse_x+155, mouse_y+75,false);
	
	//draw info
	draw_set_font(fnt_fanwood_sm);
	draw_set_color(c_white);
	
	draw_text(mouse_x+15, mouse_y+5, _minion_name + " " + string(_minion_hp_cur) + "/" + string(_minion_hp_max));
	draw_text(mouse_x+15, mouse_y+20, "Defense: " + string(_minion_def));	
	draw_text(mouse_x+15, mouse_y+35, "Attached Unit: " + _minion_unit_attached._creature_name);	
	draw_text(mouse_x+15, mouse_y+50, "Team: " + _minion_team);		
	
} 

/////////////////////
// DRAW HEALTH NUM //
/////////////////////
// Draw the current health number on the left side of the health bar
draw_set_font(fnt_fanwood_sm);
draw_set_color(c_white);
draw_text(x-16, y + 20, string(_minion_hp_cur) + "/" + string(_minion_hp_max));

///////////////////////
// DRAW DEFENSE ICON //
///////////////////////
if (_minion_def != 0){
	// Set the drawing color for the defense (blue circle)
	draw_set_color(c_blue);

	// Draw the blue circle for the defense stat to the right of the health bar
	var _defense_circle_radius = 6; // Radius of the circle
	var _defense_x = x; // Position the circle 15 pixels to the right of the health bar
	var _defense_y = y + 40; // Vertically align it with the health bar

	draw_circle(_defense_x, _defense_y, _defense_circle_radius, false);  // Draw the circle

	// Draw the defense number inside the circle
	draw_set_color(c_white);
	draw_text(_defense_x-2, _defense_y - 3, string(_minion_def));  // Display the defense value inside the circle
}