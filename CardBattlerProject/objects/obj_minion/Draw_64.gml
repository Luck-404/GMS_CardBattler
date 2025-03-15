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
	
	scr_create_combat_popup(undefined,"","Death",x,y);
	
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
	if (_minion_effect_script != undefined && _minion_trigger_effect == true){
		_minion_effect_script(_minion_unit_attached,self);
		_minion_trigger_effect = false;
	}
}



///////////////
// REACTIONS //
///////////////
if (_latest_target != undefined && _latest_channel != undefined){
	////////////////////////////////
	// HOST DAMAGE TAKEN REACTION //
	////////////////////////////////
	if (_minion_cast_types[1] == "Host Damage Taken"){
		//show_debug_message("MINION: " + _latest_target._creature_name + " has taken " + string(_latest_damage_done));
		
		if(_latest_target == _minion_unit_attached && _latest_damage_done != 0){
		///////////////
		//  BRAMBLET //
		///////////////			
			if (_minion_name == "Bramblet"){
				//show_debug_message("BRAMBLET: TRIGGERED");
				
				/////////////////////////////
				// DEAL 25% OF DAMAGE BACK //
				/////////////////////////////
					//deal 25% damage back to channeler
					var _25p = ceil(_latest_damage_done*0.25);
					scr_damage_creature(_latest_channel,_25p);
					//show_debug_message("BRAMBLET: dealing " + string(_25p) + " to " + _latest_channel._creature_name);
		
				////////////
				// EFFECT //
				////////////
					//TODO
	
				///////////
				// SOUND //
				///////////
					audio_play_sound(snd_effect_hit,0,false);
			}
			
		//////////////
		//  SERPENT //
		//////////////
			if (_minion_name == "Serpent"){
				//show_debug_message("SERPENT: VENOM TRIGGERED");

				//show_debug_message("SERPENT: applying venom to " + _latest_channel._creature_name);
		
				///////////
				// VENOM //
				///////////
				var _counter = scr_get_status_counter(_latest_channel,"General",undefined,"Venom");		
				if (_counter == undefined){		
					scr_create_status_counter(_latest_channel,"Venom","Target is envenomed for 3 turns, each venom stack deals damage and reduces damage done","Reaction","End",scr_status_venom_tick, false, undefined, 3, 1, "3 * (stacks)", 0, "General", _latest_channel._creature_statuses, spr_status_venom);

					_latest_channel._status_venom = true;
					//apply debuff stacks from venom
					_latest_channel._creature_attack_linear--;					
				} 
				else {
					show_debug_message("ADDING A STACK OF VENOM");
					_counter._counter_life = 3;
					_counter._counter_stacks +=1;
					_latest_channel._creature_attack_linear--;
				}
		
				////////////
				// EFFECT //
				////////////
					scr_create_combat_effect(_latest_channel,spr_effect_venom,0,0);
	
				///////////
				// SOUND //
				///////////
					audio_play_sound(snd_effect_reaction_serpent,0,false);	
			}
		}
	}

	////////////////////////////////
	// HOST DAMAGE DEALT REACTION //
	////////////////////////////////
	if (_minion_cast_types[2] == "Host Damage Dealt"){
		if((_latest_channel == _minion_unit_attached) && _latest_damage_done != 0){
		////////////////
		//  BLOODBEAK //
		////////////////
				if (_minion_name == "Bloodbeak"){
					//show_debug_message("BLOODBEAK: TRIGGERED");
					
					///////////////
					// 20% Leech //
					///////////////
					var _20p = ceil(_latest_damage_done*0.20); //get 20% of max hp
					scr_heal_creature(_minion_unit_attached,_20p,0);
					//show_debug_message("BLOODBEAK: healing " + string(_20p) + " on host " + _minion_unit_attached._creature_name);
				
					///////////
					// 5 DMG //
					///////////
					scr_damage_creature(_latest_target,5);
					//show_debug_message("BLOODBEAK: dealing 5 to unit " + _latest_target._creature_name);
					
					////////////
					// EFFECT //
					////////////
						//TODO
	
					///////////
					// SOUND //
					///////////
						audio_play_sound(snd_effect_trigger_bloodbeak,0,false);				
				}
				
		//////////////
		//  SERPENT //
		//////////////
			if (_minion_name == "Serpent"){
					///////////////
					// 20% Leech //
					///////////////
					var _20p = ceil(_latest_damage_done*0.20); //get 20% of max hp
					scr_heal_creature(_minion_unit_attached,_20p,0);
					
					////////////
					// EFFECT //
					////////////
						//TODO
	
					///////////
					// SOUND //
					///////////
						audio_play_sound(snd_effect_leech,0,false);	
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
	///////////////////
	// HOVER TOOLTIP //
	///////////////////
	//draw info
	draw_set_font(fnt_fanwood_sm);
	draw_set_color(c_black);
	var _tooltip_x = 1420;
	var _tooltip_y = 838;
	var _output_str = "";
	
	_output_str += _minion_name + "\n";
	_output_str += string(_minion_hp_cur) + "/" + string(_minion_hp_max) + "\n";
	_output_str += "Defense: " + string(_minion_def) + "\n";
	_output_str += "Attached Unit: " + _minion_unit_attached._creature_name;	
	_output_str += "Color: " + _minion_color + "\n";
	_output_str += "Class: " + _minion_class + "\n";
	
	//draw final tooltip;
	draw_text_ext(_tooltip_x,_tooltip_y,_output_str,15,150);	
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
	draw_sprite(spr_minion_def,0,x-16, y + 40);
	// Draw the defense number inside the circle
	draw_set_color(c_white);
	draw_set_font(fnt_fanwood_sm);
	draw_text(x-14, y + 35, string(_minion_def));  // Display the defense value inside the circle
}