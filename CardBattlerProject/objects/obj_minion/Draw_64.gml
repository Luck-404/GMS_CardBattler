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
	show_debug_message("Minion has died!");
	_flag_has_died = true;
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
if (_minion_effect_script != undefined && _trigger_my_effect == true){
	_minion_effect_script(_minion_unit_attached,self);
	_trigger_my_effect = false;
}


////////////////////////////////
// HOST DAMAGE TAKEN REACTION //
////////////////////////////////
if (_minion_cast_types[1] == "Host Damage Taken"){
	if((global.latest_target == _minion_unit_attached) && global.latest_damage_done != 0){
		//show_debug_message("My host " + _minion_unit_attached._creature_name + " has taken " + string(global.latest_damage_done) + " damage");
		_keystr = string(global.turn_counter) + "-" + string(global.latest_damage_done) + "-" + string(global.latest_channel) + "-" + string(global.latest_target) + "-" + string(irandom(1000000));
		//show_debug_message("Key: " + string(_keystr));
		//1-10-monke-furn-6
		if (_host_damage_taken_trigger != _keystr){ // "" vs 1-10-monke-furn-6
			_host_damage_taken_trigger = _keystr; //1-10-monke-furn-6 = 1-10-monke-furn-6
		
			if (_minion_name == "Bramblet"){
				//show_debug_message("Dealing 10% damage back to attacker");
				//deal 10% damage back to channeler
				var _10p = ceil(global.latest_damage_done*0.10);
		
				//store (key purposes)
				var _tmp_dmg = global.latest_damage_done;
				var _tmp_channel = global.latest_channel;
		
				//deal dmg
				scr_damage_creature(global.latest_channel,_10p);
		
				//restore keys
				global.latest_damage_done = _tmp_dmg;
				global.latest_channel = _tmp_channel;
			}
		}
	}
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
draw_text(x-10, y + 20, string(_minion_hp_cur) + "/" + string(_minion_hp_max));

///////////////////////
// DRAW DEFENSE ICON //
///////////////////////
if (_minion_def != 0){
	// Set the drawing color for the defense (blue circle)
	draw_set_color(c_blue);

	// Draw the blue circle for the defense stat to the right of the health bar
	var _defense_circle_radius = 6; // Radius of the circle
	var _defense_x = x + 25; // Position the circle 15 pixels to the right of the health bar
	var _defense_y = y + 20; // Vertically align it with the health bar

	draw_circle(_defense_x, _defense_y, _defense_circle_radius, false);  // Draw the circle

	// Draw the defense number inside the circle
	draw_set_color(c_white);
	draw_text(_defense_x - 3, _defense_y - 3, string(_minion_def));  // Display the defense value inside the circle
}