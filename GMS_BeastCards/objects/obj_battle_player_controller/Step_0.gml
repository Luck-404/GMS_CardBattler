//
//
// STEP: OBJ_BATTLE_PLAYER_CONTROLLER | HANDLE THE PLAYER STATE MACHINE
//
//
if (keyboard_check_pressed(ord("R")) && _player_state == PLAYER_STATE.SELECT_CARD){
	scr_reroll_hand();	
}
switch (_player_state){
	//
	//INIT_BEASTS
	//
	#region INIT_BEASTS
	case PLAYER_STATE.INIT_BEASTS:
		for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
			//GET UNIT
			var _party_unit = ds_list_find_value(global.player_party,_i);
			
			//MAKE NEW BEAST OBJ
			var _obj_beast = instance_create_layer(room_width/2-80-(100*_i),room_height/2,"ily_player",obj_battle_beast);
			_obj_beast._sprite = _party_unit[?"beast_sprite"];
			_obj_beast._ref_unit = _party_unit;
			_obj_beast._team = "PLAYER";
			_obj_beast._uid = _party_unit[?"beast_uid"];
			_obj_beast._pos = _i;
			_obj_beast._cur_hp = _party_unit[?"beast_hp_cur"];
			_obj_beast._max_hp = _party_unit[?"beast_hp_max"];
			
			//ADD TO BEAST LIST
			ds_list_add(_beasts_list,_obj_beast);
			
			//ADD TO LIVING
			ds_list_add(_beasts_alive,_obj_beast);
		}
		
		_player_state = PLAYER_STATE.INIT_CARDS;
	break;
	#endregion
	
	//
	//INIT_CARDS
	//
	#region INIT_CARDS
	case PLAYER_STATE.INIT_CARDS:
		//SPAWN ALL CARD OBJECTS
		for (var _c = 0; _c < ds_list_size(global.player_deck); _c++){
			var _card_ref = ds_list_find_value(global.player_deck,_c);
			var _new_card = instance_create_layer(70,room_height-100,"ily_player",obj_battle_card);
			_new_card._sprite = _card_ref[?"card_sprite"];
			_new_card._uid = _card_ref[?"card_uid"];
			_new_card._team = "PLAYER";
			_new_card._ref_card = _card_ref;
			_new_card._location = "DECK"; //DECK, HAND, DISCARD, EXHAUST
			
			ds_list_add(_battle_deck,_new_card);
		}
		//SHUFFLE DECK		
		ds_list_shuffle(_battle_deck);		

		//NEXT STATE
		_player_state = PLAYER_STATE.TRIGGER_ENTRY_EFFECTS;
	break;
	#endregion

	//
	//TRIGGER_ENTRY_EFFECTS
	//
	#region TRIGGER_ENTRY_EFFECTS
	case PLAYER_STATE.TRIGGER_ENTRY_EFFECTS:
		obj_battle_turn_controller._flag_game_start = true;
		//NEXT STATE
		_player_state = PLAYER_STATE.WAIT;
	break;
	#endregion
	
	//
	//WAIT
	//
	#region WAIT
	case PLAYER_STATE.WAIT:
	
	break;
	#endregion
	
	//
	//TURN_START
	//
	#region TURN_START
	case PLAYER_STATE.TURN_START:
		//REDUCE ARMOR
		for (var _i = 0; _i < ds_list_size(_beasts_alive); _i++){
			var _u = ds_list_find_value(_beasts_alive,_i);
			scr_degrade_shield(_u);
		}
		
		//DRAW hand size
		scr_reroll_hand();
		
		//MANA RESET
		_cur_mana = _max_mana;
		
		//NEXT STATE
		_player_state = PLAYER_STATE.TRIGGER_MINIONS;	
	break;
	#endregion
	
	//
	//TRIGGER_MINIONS
	//
	#region TRIGGER_MINIONS
	case PLAYER_STATE.TRIGGER_MINIONS:
		//NEXT STATE
		_player_state = PLAYER_STATE.SELECT_CARD;	
		#region CHECK FOR OOM
		scr_check_battle_card_oom(_battle_hand);
		#endregion		
	break;
	#endregion
	
	//
	//SELECT_CARD
	//
	#region SELECT_CARD
	case PLAYER_STATE.SELECT_CARD:
	
		#region END TURN
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked && position_meeting(mouse_x,mouse_y,obj_battle_button_end_turn)){
			_flag_clicked = true;			
			_player_state = PLAYER_STATE.TURN_END;
			break;			
		}
		#endregion
				
		#region LEFT CLICK SELECTS
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked){			
			_flag_clicked = true;
			var _card = instance_nearest(mouse_x,mouse_y,obj_battle_card);
			
			if (_card != undefined && _card._location == "HAND" && _card._team == "PLAYER" && _card._card_oom_check == false){
				
				global.cast_card = _card;
				
				//MOVE STATE
				_player_state = PLAYER_STATE.SELECT_CASTER;
				
				#region CHECK FOR COLOR
				scr_check_battle_beast_color(_beasts_alive);
				#endregion
		
				#region CHECK FOR ARCHEYPE
				scr_check_battle_beast_archetype(_beasts_alive);
				#endregion
		
				#region CHECK FOR CLASS
				scr_check_battle_beast_class(_beasts_alive);
				#endregion					
			}
		}
		#endregion
	break;
	#endregion
	
	//
	//SELECT_CASTER
	//
	#region SELECT_CASTER
	case PLAYER_STATE.SELECT_CASTER:
		#region END TURN
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked && position_meeting(mouse_x,mouse_y,obj_battle_button_end_turn)){
			_flag_clicked = true;			
			_player_state = PLAYER_STATE.TURN_END;
			break;			
		}
		#endregion	
		
		#region RIGHT CLICK SENDS BACK
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){
			_flag_clicked = true
			_player_state = PLAYER_STATE.SELECT_CARD;
			global.cast_card = undefined;
			#region CHECK FOR OOM
			scr_check_battle_card_oom(_battle_hand);
			#endregion
			break;
		}
		#endregion
		
		//DRAWS LINE FROM CARD TO MOUSE
		
		#region LEFT CLICK SELECTS
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
			_flag_clicked = true;
			var _beast_clicked = instance_nearest(mouse_x,mouse_y,obj_battle_beast);
			if (_beast_clicked != undefined && _beast_clicked._team == "PLAYER" && _beast_clicked._beast_color_check == true && _beast_clicked._beast_archetype_check == true && _beast_clicked._beast_class_check == true){
				global.caster_beast = _beast_clicked;
				
				//MOVE STATE
				_player_state = PLAYER_STATE.SELECT_TARGET;

				#region CHECK FOR RANGE
				var _card_range = global.cast_card._ref_card[?"card_range"];
				if (_card_range != "GLONAL"){
					scr_check_battle_beast_range(_beasts_alive,_card_range);
				}
				#endregion					
			}
		}
		#endregion
	break;
	#endregion
	
	//
	//SELECT_TARGET
	//
	#region SELECT_TARGET
	case PLAYER_STATE.SELECT_TARGET:
		#region END TURN
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked && position_meeting(mouse_x,mouse_y,obj_battle_button_end_turn)){
			_flag_clicked = true;			
			_player_state = PLAYER_STATE.TURN_END;
			break;			
		}
		#endregion	
		
		#region RIGHT CLICK SENDS BACK
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){
			_flag_clicked = true
			_player_state = PLAYER_STATE.SELECT_CASTER;
			global.caster_beast = undefined;	
			
			#region CHECK FOR COLOR
			scr_check_battle_beast_color(_beasts_alive);
			#endregion
		
			#region CHECK FOR ARCHEYPE
			scr_check_battle_beast_archetype(_beasts_alive);
			#endregion
		
			#region CHECK FOR CLASS
			scr_check_battle_beast_class(_beasts_alive);
			#endregion					
			break;			
		}
		#endregion		
		
		//DRAWS LINE FROM CASTER TO MOUSE	
		
		#region GLOBAL HANDLE
		var _card_range = global.cast_card._ref_card[?"card_range"];
		
		if (_card_range == "GLOBAL"){
			if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
				_flag_clicked = true;
				global.target_beast = "GLOBAL";
				//MOVE STATE
				_player_state = PLAYER_STATE.CARD_EXECUTE;				
			}
		}
		#endregion	
				
		#region LEFT CLICK SELECTS
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _card_range != "GLOBAL"){
			_flag_clicked = true;
			var _beast_clicked = instance_nearest(mouse_x,mouse_y,obj_battle_beast);
			if (_beast_clicked != undefined && _beast_clicked._beast_range_check == true){
				global.target_beast = _beast_clicked;
				
				//MOVE STATE
				_player_state = PLAYER_STATE.CARD_EXECUTE;
			}
		}
		#endregion
	break;
	#endregion
	
	//
	//CARD_EXECUTE
	//
	#region CARD_EXECUTE
	case PLAYER_STATE.CARD_EXECUTE:
		//_card,_caster,_target)
		scr_cast_battle_card();
		
		//MOVE STATE
		_player_state = PLAYER_STATE.SELECT_CARD;
		
		#region CHECK FOR OOM
		scr_check_battle_card_oom(_battle_hand);
		#endregion
	break;
	#endregion
	
	//
	//TURN_END
	//
	#region TURN_END
	case PLAYER_STATE.TURN_END:
	
	//TURN END EFFECTS (FUTURE)
	
	//FORCE TO CAST DOWN TO _HAND_SIZE
	if (ds_list_size(_battle_hand) > _hand_size){
		//DISCARD CARDS
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked && position_meeting(mouse_x,mouse_y,obj_battle_card)){
			_flag_clicked = true;
			var _card_clicked = instance_nearest(mouse_x,mouse_y,obj_battle_card);
			if (_card_clicked != undefined){
				scr_discard_battle_card(_card_clicked);
			}
		}
	} else {
		//MOVE STATE
		_player_state = PLAYER_STATE.WAIT;
		obj_battle_turn_controller.scr_pass_turn();
	}
	
	break;
	#endregion	
}

#region CLICK COOLDOWNS
if (_cooldown > 0){
    _cooldown--;

    if (_cooldown <= 0){
        _cooldown = 10;
        _flag_clicked = false;
    }
}
#endregion