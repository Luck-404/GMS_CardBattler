//check for game end
if (global.trigger_loss == true || (ds_list_size(global.player_party_in_play) == 0 && ds_list_size(global.player_party_dead) != 0)){
	if (_flag_executed_encounter_end == false){
		_flag_executed_encounter_end = true;
		//enemy won
		//cleanup/reset any variables from all
		//cleanup lists on delete
		//check for persistent objects, remove as needed
	
		//display score/game over screen and confirm box
		instance_create_layer(960,540,"GUI", obj_end_box);

		//on confirm, call a transition object to main menu
		var _ref_confirm = instance_create_layer(960,940,"GUI", obj_confirm);	
		_ref_confirm._confirm_type = "endgame";			
	}
} else if (instance_exists(obj_enemy_team) && ds_list_size(global.enemy_team_in_play) == 0 && ds_list_size(global.enemy_team_dead) != 0){
	if (_flag_executed_encounter_end == false){	
		_flag_executed_encounter_end = true;
		//ally won
		//cleanup/reset any variables from all
		//cleanup lists on delete
		//check for persistent objects, remove as needed (when we press confirm)
		
		//display rewards screen and confirm box
		instance_create_layer(960,540,"GUI", obj_end_box);
		
		//update your team's health currents as we move out of the room
		for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
			var _ref_creature = ds_list_find_value(global.player_party_in_play,_i); //get the creature at that spot
			var _ref_hp_cur = _ref_creature._creature_hp_current; //get the value of the creature's currenthp
			//update the current hp to the permanent list
			var _ref_original_creature = ds_list_find_value(global.player_party,_i); //get the creature at that spot
			_ref_original_creature[?"curhp"] = _ref_hp_cur;
			//if that hp turns out to be 0- the creature has died and is sent to the graveyard
			if (_ref_hp_cur == 0){
				ds_list_delete(global.player_party,ds_list_find_index(global.player_party,_ref_original_creature));
				ds_list_add(global.graveyard,_ref_original_creature);
			}
		}
	
		// Empty the exhausted pile into the card inventory		
		scr_empty_exhausted();

		// Empty the current hand into the card inventory		
		scr_empty_hand();
	
		//give 2 cards a a reward, display them
		//add 2 new cards to inventory (script)			
		scr_generate_reward_card(2);
		//display 2 the 2 new temp card objects with sprites
		var _ref_card1 = instance_create_layer(850,400,"GUI", obj_card);
		_ref_card1.depth = -100;
		_ref_card1.sprite_index = ds_list_find_value(global.player_deck,ds_list_size(global.player_deck)-1)[?"sprite"];
		_ref_card1.image_xscale = 0.20;
		_ref_card1.image_yscale = 0.20;
			
		var _ref_card2 = instance_create_layer(1000,400,"GUI", obj_card);
		_ref_card2.depth = -100;
		_ref_card2.sprite_index = ds_list_find_value(global.player_deck,ds_list_size(global.player_deck)-2)[?"sprite"];	
		_ref_card2.image_xscale = 0.20;
		_ref_card2.image_yscale = 0.20;			
				
		//give gold, display it
		global.gold_randomizer = irandom_range(40,50);
		global.gold = global.gold + global.gold_randomizer;
		
		//on confirm, call a transition object to overworld back in the place we left off ()
		var _ref_confirm = instance_create_layer(960,940,"GUI", obj_confirm);	
		_ref_confirm._confirm_type = "playon";		
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

		//pick the spell
		var _ref_card_num = irandom_range(1,ds_list_size(global.enemy_card_inventory));
		var _ref_card = ds_list_find_value(global.enemy_card_inventory,_ref_card_num-1);		

		var _ref_tar = undefined;
		var _ref_tar_num = 0;
		//decide targets based on spell
		switch(_ref_card[?"name"]){
			case "Echo":
				_i-=1;
			break;
			
			case "Strike":
				_ref_tar_num = irandom_range(1,ds_list_size(global.player_party_in_play));

				_ref_tar = ds_list_find_value(global.player_party_in_play,_ref_tar_num-1);
			break;
			
			case "Block":
				_ref_tar_num = irandom_range(1,ds_list_size(global.enemy_team_in_play));
		
				_ref_tar = ds_list_find_value(global.enemy_team_in_play,_ref_tar_num-1);
			break;
		}
		var _ref_card_scr = _ref_card[?"script"];
		scr_play_card(_ref_card_scr,_ref_tar,0, _ref_card[? "exhausts"]);
	}
	//spawn a 1 second timer, then kill it which will update the global turn tracker
	if (_flag_spawned_timer == false){	
		instance_create_layer(10,10,"GUI",obj_timer);
		_flag_spawned_timer = true;
		//trigger the effects of the passive cards
		with(obj_card_counter){
			obj_card_counter._turn_lifespan--;
			obj_card_counter._trigger_my_effect = true;
		}
	}
}