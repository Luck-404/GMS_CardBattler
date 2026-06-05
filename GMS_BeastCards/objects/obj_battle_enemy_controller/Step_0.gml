//
//
// STEP: OBJ_BATTLE_ENEMY_CONTROLLER | HANDLE THE ENEMY STATE MACHINE
//
//
switch (_enemy_state){
	//
	//INIT_BEASTS
	//
	#region INIT_BEASTS
	case ENEMY_STATE.INIT_BEASTS:
			for (var _i = 0; _i < _beast_number; _i++){
			//GET UNIT
			var _enemy_unit = scr_roll_random_beast(global.last_enemy_pool);
			
			//MAKE NEW BEAST OBJ
			var _obj_beast = instance_create_layer(room_width/2+80+(100*_i),room_height/2,"ily_player",obj_battle_beast);
			_obj_beast._sprite = _enemy_unit[?"beast_sprite"];
			_obj_beast._ref_unit = _enemy_unit;
			_obj_beast._team = "ENEMY";
			_obj_beast._uid = _enemy_unit[?"beast_uid"];
			_obj_beast._pos = _i;
			_obj_beast._cur_hp = _enemy_unit[?"beast_hp_cur"];
			_obj_beast._max_hp = _enemy_unit[?"beast_hp_max"];			
			
			//ADD TO BEAST LIST
			ds_list_add(_beasts_list,_obj_beast);
			
			//ADD TO LIVING
			ds_list_add(_beasts_alive,_obj_beast);
		}
			
	_enemy_state = ENEMY_STATE.INIT_CARDS;
	break;
	#endregion
	
	//
	//INIT_CARDS
	//
	#region INIT_CARDS
	case ENEMY_STATE.INIT_CARDS:
		//FOR EACH UNIT ON TEAM
		for (var _i = 0; _i < ds_list_size(_beasts_alive); _i++){
		//GET UNIT
		var _enemy_unit = ds_list_find_value(_beasts_alive,_i);
		
		var _u = _enemy_unit._ref_unit;
		
		//GET DECK (BUNCH OF STRINGS)
		var _deck_refs = scr_get_enemy_deck(_u[?"beast_name"],_u[?"beast_color_type"]);
		
		//CREATE AN OBJECT FOR EACH CARD
		for (var _c = 0; _c < ds_list_size(_deck_refs); _c++){
			var _card_ref = ds_list_find_value(_deck_refs,_c);
			var _new_card = instance_create_layer(_enemy_unit.x,_enemy_unit.y-200,"ily_enemy",obj_battle_card);
			_new_card._sprite = _card_ref[?"card_sprite"];
			_new_card._uid = _card_ref[?"card_uid"];
			_new_card._team = "ENEMY";
			_new_card._ref_card = _card_ref;
			_new_card._location = "DECK"; //DECK, HAND, DISCARD, EXHAUST, ENEMY
			visible = false;
		
			ds_list_add(_enemy_unit._decklist,_new_card);
		}
		
		//SHUFFLE DECK
		randomize();
		ds_list_shuffle(_enemy_unit._decklist);
		
		//SET CARD ACTIVEs
		_enemy_unit._hand_pos = 0;
		var _card_one = ds_list_find_value(_enemy_unit._decklist,_enemy_unit._hand_pos);
		_card_one._location = "HAND";

		}
		//NEXT STATE
		_enemy_state = ENEMY_STATE.TRIGGER_ENTRY_EFFECTS;		
	break;
	#endregion

	//
	//TRIGGER_ENTRY_EFFECTS
	//
	#region TRIGGER_ENTRY_EFFECTS
	case ENEMY_STATE.TRIGGER_ENTRY_EFFECTS:
		//NEXT STATE
		_enemy_state = ENEMY_STATE.WAIT;
	break;
	#endregion
	
	//
	//WAIT
	//
	#region WAIT
	case ENEMY_STATE.WAIT:
		
	break;
	#endregion
	
	//
	//TURN_START
	//
	#region TURN_START
	case ENEMY_STATE.TURN_START:
		//REDUCE ARMOR
		for (var _i = 0; _i < ds_list_size(_beasts_alive); _i++){
			var _u = ds_list_find_value(_beasts_alive,_i);
			scr_degrade_shield(_u);
		}
		//NEXT STATE
		_enemy_state = ENEMY_STATE.TRIGGER_MINIONS;		
	break;
	#endregion
	
	//
	//TRIGGER_MINIONS
	//
	#region TRIGGER_MINIONS
	case ENEMY_STATE.TRIGGER_MINIONS:
		//NEXT STATE
		_enemy_state = ENEMY_STATE.CAST_CARDS;		
	break;
	#endregion
	
	//
	//CAST_CARDS
	//
	#region CAST_CARDS
	case ENEMY_STATE.CAST_CARDS:
	
	
	break;
	#endregion
	
	//
	//NEW_CARDS
	//
	#region NEW_CARDS
	case ENEMY_STATE.NEW_CARDS:
	break;
	#endregion
	
	//
	//TURN_END
	//
	#region TURN_END
	case ENEMY_STATE.TURN_END:
	break;
	#endregion	
}