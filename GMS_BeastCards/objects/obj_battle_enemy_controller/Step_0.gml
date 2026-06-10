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
			var _enemy_unit = scr_get_random_beast(global.last_enemy_pool);
			
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
			_new_card._ref_unit = _enemy_unit;
			_new_card._location = "DECK"; //DECK, HAND, DISCARD, EXHAUST, ENEMY
			visible = false;
		
			ds_list_add(_enemy_unit._decklist,_new_card);
		}
		
		//SHUFFLE DECK
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
	_statuses_init = false;	
	_cast_init = false;		
	_minions_init = false;		
	break;
	#endregion
	

	//
	// TURN_START
	//
	#region TURN_START
	case ENEMY_STATE.TURN_START:

	    if (_statuses_init == false)
	    {
	        _statuses_init = true;

	        // REDUCE ARMOR
	        for (var _i = 0; _i < ds_list_size(_beasts_alive); _i++)
	        {
	            var _u = ds_list_find_value(_beasts_alive, _i);
	            scr_degrade_shield(_u);
	        }

	        _statuses_list = ds_list_create();

	        for (var _j = 0; _j < ds_list_size(_beasts_alive); _j++)
	        {
	            var _beast = ds_list_find_value(_beasts_alive, _j);

	            for (var _i = 0; _i < ds_list_size(_beast._statuses); _i++)
	            {
	                ds_list_add(_statuses_list, ds_list_find_value(_beast._statuses, _i));
	            }
	        }
	    }

	    if (_statuses_init && !instance_exists(obj_wait))
	    {
	        if (ds_list_size(_statuses_list) > 0)
	        {
	            var _status = ds_list_find_value(_statuses_list, 0);

	            if (instance_exists(_status))
	            {
	                if (_status._trigger_region == "START")
	                {
	                    _status._status_command = "REPEAT";
	                }

	                ds_list_delete(_statuses_list, 0);

	                scr_init_battle_wait(10);
	            }
	            else
	            {
	                ds_list_delete(_statuses_list, 0);
	            }
	        }
	        else
	        {
	            ds_list_destroy(_statuses_list);
	            _statuses_list = undefined;

	            _statuses_init = false;
	            _enemy_state = ENEMY_STATE.TRIGGER_MINIONS;
	        }
	    }

	break;
	#endregion
	
	//
	//TRIGGER_MINIONS
	//
	#region TRIGGER_MINIONS
	case ENEMY_STATE.TRIGGER_MINIONS:

	    if (_minions_init == false)
	    {
	        _minions_init = true;
	        _casting_minions = ds_list_create();

	        for (var _j = 0; _j < ds_list_size(_beasts_alive); _j++)
	        {
	            var _beast = ds_list_find_value(_beasts_alive, _j);

	            for (var _i = 0; _i < ds_list_size(_beast._minions); _i++)
	            {
	                ds_list_add(_casting_minions, ds_list_find_value(_beast._minions, _i));
	            }
	        }
	    }

	    if (_minions_init && !instance_exists(obj_wait))
	    {
	        if (ds_list_size(_casting_minions) > 0)
	        {
	            var _minion = ds_list_find_value(_casting_minions, 0);

	            scr_cast_minion_effect(_minion);

	            ds_list_delete(_casting_minions, 0);

	            scr_init_battle_wait(15);
	        }
	        else
	        {
	            ds_list_destroy(_casting_minions);

	            _minions_init = false;

				//NEXT STATE
				_enemy_state = ENEMY_STATE.CAST_CARDS;		
	        }
	    }
	

	break;
	#endregion
	
	//
	//CAST_CARDS
	//
	#region CAST_CARDS
	case ENEMY_STATE.CAST_CARDS:
	if (_cast_init == false){
		_cast_init = true;
		_casting_units = ds_list_create();

		for (var i = 0; i < ds_list_size(_beasts_alive); i++)
		{
		    ds_list_add(_casting_units, ds_list_find_value(_beasts_alive, i));
		}
	}
	if (_cast_init == true && !instance_exists(obj_wait)){
		if(ds_list_size(_casting_units) > 0){
			var _beast = ds_list_find_value(_casting_units,0);
			obj_battle_player_controller.scr_check_battle_beast_able(_beasts_alive);
			var _card = ds_list_find_value(_beast._decklist,_beast._hand_pos);
			if (_beast._beast_able_check == true){				
				var _card_type = _card._ref_card[?"card_type"];
				var _target;
				switch(_card_type){
					case "ATTACK":
				        var _enemy_list = obj_battle_player_controller._beasts_alive;

				        if (ds_list_size(_enemy_list) > 0)
				        {

				            switch (_card._ref_card[?"card_range"])
				            {
				                case "MELEE":
				                    _target = ds_list_find_value(_enemy_list, 0);
				                break;

				                case "BACK":
				                    _target = ds_list_find_value(
				                        _enemy_list,
				                        ds_list_size(_enemy_list) - 1
				                    );
				                break;

				                default:
				                    _target = ds_list_find_value(
				                        _enemy_list,
				                        irandom(ds_list_size(_enemy_list) - 1)
				                    );
				                break;
				            }

				            global.cast_card   = _card;
				            global.caster_beast = _beast;
				            global.target_beast = _target;

				            scr_cast_card();
				        }

					break;
				
					case "SUPPORT":
				        _target = _beast;

				        if (_card._ref_card[?"card_range"] == "RANGED")
				        {
				            if (random(1) < 0.25)
				            {
				                var _ally_count = ds_list_size(
				                    obj_battle_enemy_controller._beasts_alive
				                );

				                if (_ally_count > 1)
				                {
				                    repeat (10)
				                    {
				                        var _candidate =
				                            ds_list_find_value(
				                                obj_battle_enemy_controller._beasts_alive,
				                                irandom(_ally_count - 1)
				                            );

				                        if (_candidate != _beast)
				                        {
				                            _target = _candidate;
				                            break;
				                        }
				                    }
				                }
				            }
				        }

				        global.cast_card    = _card;
				        global.caster_beast = _beast;
				        global.target_beast = _target;

				        scr_cast_card();
					break;
				
					case "UTILITY":
				        _target = _beast;

				        if (_card._ref_card[?"card_range"] == "RANGED")
				        {
				            if (random(1) < 0.25)
				            {
				                var _ally_count = ds_list_size(
				                    obj_battle_enemy_controller._beasts_alive
				                );

				                if (_ally_count > 1)
				                {
				                    repeat (10)
				                    {
				                        var _candidate =
				                            ds_list_find_value(
				                                obj_battle_enemy_controller._beasts_alive,
				                                irandom(_ally_count - 1)
				                            );

				                        if (_candidate != _beast)
				                        {
				                            _target = _candidate;
				                            break;
				                        }
				                    }
				                }
				            }
				        }

				        global.cast_card    = _card;
				        global.caster_beast = _beast;
				        global.target_beast = _target;

				        scr_cast_card();
					break;				
				
					case "DEFENSE":

					    _target = _beast;

					    if (_card._ref_card[?"card_range"] == "RANGED")
					    {
					        if (random(1) < 0.25)
					        {
					            var _ally_count = ds_list_size(
					                obj_battle_enemy_controller._beasts_alive
					            );

					            if (_ally_count > 1)
					            {
					                repeat (10)
					                {
					                    var _candidate =
					                        ds_list_find_value(
					                            obj_battle_enemy_controller._beasts_alive,
					                            irandom(_ally_count - 1)
					                        );

					                    if (_candidate != _beast)
					                    {
					                        _target = _candidate;
					                        break;
					                    }
					                }
					            }
					        }
					    }

					    global.cast_card    = _card;
					    global.caster_beast = _beast;
					    global.target_beast = _target;

					    scr_cast_card();

					break;
				}
				ds_list_delete(_casting_units,0);
				_card.visible = false;
				//create waiter
				scr_init_battle_wait(30);
			} else {
				_card.visible = false;	
				ds_list_delete(_casting_units,0);	
				break;
			}
		} else {
			_enemy_state = ENEMY_STATE.NEW_CARDS;
			break;
		}
	}
	break;
	#endregion
	
	//
	//NEW_CARDS
	//
	#region NEW_CARDS
	case ENEMY_STATE.NEW_CARDS:
		//iterate each unit's hand pos by 1.
		for (var _i = 0; _i < ds_list_size(_beasts_alive); _i++){
			//GET UNIT
			var _enemy_unit = ds_list_find_value(_beasts_alive,_i);
			
			//UNSET OLD
			var _old_card = ds_list_find_value(_enemy_unit._decklist,_enemy_unit._hand_pos);
			_old_card.visible = false;
			_old_card._location = "DECK";
			
			//ROLL NEW
			_enemy_unit._hand_pos++;
			if (_enemy_unit._hand_pos > ds_list_size(_enemy_unit._decklist)-1){
				_enemy_unit._hand_pos = 0;	
			}
			
			//SET NEW
			_old_card = ds_list_find_value(_enemy_unit._decklist,_enemy_unit._hand_pos);
			_old_card.visible = true;
			_old_card._location = "HAND";			
		}
		_statuses_init = false;	
		_cast_init = false;		
		_minions_init = false;				
		_enemy_state = ENEMY_STATE.TURN_END;	
	break;
	#endregion
	
	//
	// TURN_END
	//
	#region TURN_END
	case ENEMY_STATE.TURN_END:

	    if (_statuses_init == false)
	    {
	        _statuses_init = true;

	        _statuses_list = ds_list_create();

	        for (var _j = 0; _j < ds_list_size(_beasts_alive); _j++)
	        {
	            var _beast = ds_list_find_value(_beasts_alive, _j);

	            for (var _i = 0; _i < ds_list_size(_beast._statuses); _i++)
	            {
	                ds_list_add(_statuses_list, ds_list_find_value(_beast._statuses, _i));
	            }
	        }
			
			var _status = scr_check_for_status("WEATHER: RAPID GROWTH",global.statuses);
			if (_status != -1){
				_status._status_command = "REPEAT";
			}
	    }

	    if (_statuses_init && !instance_exists(obj_wait))
	    {
	        if (ds_list_size(_statuses_list) > 0)
	        {
	            var _status = ds_list_find_value(_statuses_list, 0);

	            if (instance_exists(_status))
	            {
	                if (_status._trigger_region == "END")
	                {
	                    _status._status_command = "REPEAT";
	                }

	                ds_list_delete(_statuses_list, 0);

	                scr_init_battle_wait(10);
	            }
	            else
	            {
	                ds_list_delete(_statuses_list, 0);
	            }
	        }
	        else
	        {
	            ds_list_destroy(_statuses_list);
	            _statuses_list = undefined;

	            _statuses_init = false;
	            _enemy_state = ENEMY_STATE.WAIT;

	            obj_battle_turn_controller.scr_pass_turn();
	        }
	    }

	break;
	#endregion
}