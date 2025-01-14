//check for game end
if (ds_list_size(global.player_team_in_play) == 0 && ds_list_size(global.player_team_dead) != 0){
	if (_flag_executed_encounter_end == false){
		_flag_executed_encounter_end = true;		
		//enemy won
		//cleanup/reset any variables from all
		//cleanup lists on delete
		//check for persistent objects, remove as needed
	
		//display score/game over screen and confirm box
		instance_create_layer(960,540,"GUI", obj_end_box);
		var _ref_confirm = instance_create_layer(960,940,"GUI", obj_confirm);	
		_ref_confirm._confirm_type = "endgame";
		//on confirm, call a transition object to main menu
	}
} else if (instance_exists(obj_enemy_team) && ds_list_size(global.enemy_team_in_play) == 0 && ds_list_size(global.enemy_team_dead) != 0){
	if (_flag_executed_encounter_end == false){	
		_flag_executed_encounter_end = true;
		//ally won
		//cleanup/reset any variables from all
		//cleanup lists on delete
		//check for persistent objects, remove as needed
		
		//display rewards screen and confirm box
		instance_create_layer(960,540,"GUI", obj_end_box);
		var _ref_confirm = instance_create_layer(960,940,"GUI", obj_confirm);	
		_ref_confirm._confirm_type = "playon";
	
		//give 2 cards a a reward, display them
			//create 2 temp card objects with sprites
			//add 2 new cards to inventory (script
		//give gold, display it
		global.gold = global.gold + irandom_range(40,50);
		
		//on confirm, call a transition object to overworld back in the place we left off ()
	}
}

if (global.turn_tracker == obj_player){
	//display the 'end turn' button
	_ref_end_turn.visible = true;
	//WAITS FOR CLICK ON END TURN BUTTON
	_flag_spawned_timer = false;
	_enemy_played = false;
}

if (global.turn_tracker == obj_enemy_team && _enemy_played == false){	
	_enemy_played = true;
	//have the enemy team play cards at random targets (one card per member of the team)
	for (var _i = 0; _i < ds_list_size(global.enemy_team); _i++){
		show_debug_message("\n\n[[ ENEMY SPELL " + string(_i) + " of " + string(ds_list_size(global.enemy_team)) + " ]]\n\n");	
		
		//pick the spell
		var _ref_card_num = irandom_range(1,ds_list_size(global.enemy_card_inventory));
		var _ref_card = ds_list_find_value(global.enemy_card_inventory,_ref_card_num-1);		
		show_debug_message("\n\n[[ ENEMY PICKED CARD: " + _ref_card[?"name"] + " ]]\n\n");			
		
		var _ref_tar = undefined;
		var _ref_tar_num = 0;
		//decide targets based on spell
		switch(_ref_card[?"name"]){
			case "Echo":
				_i-=1;
			break;
			
			case "Strike":
				_ref_tar_num = irandom_range(1,ds_list_size(global.player_team_in_play));
				show_debug_message("\n\n[[ ENEMY PICKED NUMBER: " + string(_ref_tar_num) + " ]]\n\n");
		
				_ref_tar = ds_list_find_value(global.player_team_in_play,_ref_tar_num-1);
				show_debug_message("\n\n[[ ENEMY PICKED TARGET: " + string(_ref_tar._creature_name) + " ]]\n\n");	
			break;
			
			case "Block":
				_ref_tar_num = irandom_range(1,ds_list_size(global.enemy_team_in_play));
				show_debug_message("\n\n[[ ENEMY PICKED NUMBER: " + string(_ref_tar_num) + " ]]\n\n");
		
				_ref_tar = ds_list_find_value(global.enemy_team_in_play,_ref_tar_num-1);
				show_debug_message("\n\n[[ ENEMY PICKED TARGET: " + string(_ref_tar._creature_name) + " ]]\n\n");	
			break;
		}

		
				
		
		var _ref_card_scr = _ref_card[?"script"];
		scr_play_card(_ref_card_scr,_ref_tar,0);
	}
	//spawn a 1 second timer, then kill it which will update the global turn tracker
	if (_flag_spawned_timer == false){
		instance_create_layer(10,10,"GUI",obj_timer);
		_flag_spawned_timer = true;
	}
}