//
//
//
//
//
function scr_status_event_rapid_growth(_tag,_ref){
	switch(_tag){
		case "APPLY":
			_ref = global.statuses;
			
			var _status = scr_check_unit_status("WEATHER: RAPID GROWTH",global.statuses);
			if (_status != -1){
				_status._status_lifetime = 15;			
				return _status;
			}
	
			//Make a new status obj
			var _new_status = instance_create_layer(x,y,"ily_status",obj_battle_status);
			_new_status._status_lifetime = 15;
			_new_status._status_scr = scr_status_event_rapid_growth;				
			_new_status._ref_host = undefined;
			_new_status._status_name = "WEATHER: RAPID GROWTH";
			_new_status._status_desc = "GREEN DAMAGE +25%, RANDOMLY SPAWN 2 MINONS AT THE END OF EVERY ROUND, ALSO HEAL SELECTED BY 1";
			_new_status._status_sprite = spr_status_event_rapid_growth;
			_new_status._trigger_region = "END";
			_new_status._status_type = "GLOBAL";
			
			ds_list_add(global.statuses,_new_status);
	
			//SOUND
	
			//EFFECTS
				//ARTSY RAIN EFFECT
				var _lid = layer_get_id("bly_event")
				layer_background_change(_lid,spr_scene_fx_rapid_growth);
	
			scr_check_status_pos(global.statuses);
		break;
		
		case "REPEAT":
			var _beasts_list = ds_list_create();

			//----------------------------------------------------
			// COLLECT ALL ALIVE BEASTS
			//----------------------------------------------------

			// player beasts
			for (var i = 0; i < ds_list_size(obj_battle_player_controller._beasts_alive); i++)
			{
			    var _b = ds_list_find_value(obj_battle_player_controller._beasts_alive, i);
			    if (instance_exists(_b))
			    {
			        ds_list_add(_beasts_list, _b);
			    }
			}

			// enemy beasts
			for (var i = 0; i < ds_list_size(obj_battle_enemy_controller._beasts_alive); i++)
			{
			    var _b = ds_list_find_value(obj_battle_enemy_controller._beasts_alive, i);
			    if (instance_exists(_b))
			    {
			        ds_list_add(_beasts_list, _b);
			    }
			}

			//----------------------------------------------------
			// SPAWN 2 RANDOM MINIONS
			//----------------------------------------------------

			for (var i = 0; i < 2; i++)
			{
			    if (ds_list_size(_beasts_list) <= 0) break;

			    // pick random host beast
			    var _tar = ds_list_find_value(_beasts_list, irandom(ds_list_size(_beasts_list) - 1));
				
				scr_heal_target(1,_tar);

			    if (!instance_exists(_tar)) continue;

			    // roll minion type
			    var _minion = irandom(array_length(global.viridian_minions) - 1);

			    // spawn minion under target beast
			    scr_init_minion(ds_list_find_value(global.viridian_minions,_minion), undefined, undefined, _tar);
			}

			// cleanup
			ds_list_destroy(_beasts_list);
			
		    //----------------------------------------------------
		    // HANDLING
		    //----------------------------------------------------
			_ref._status_lifetime--;
			if (_ref._status_lifetime <= 0){
				_ref._status_command = "DEATH";	
			} else {
				_ref._status_command = "WAIT";	
			}
			scr_check_status_pos(global.statuses);				
		break;
		
		case "DEATH":
			//UNDO RAIN EFFECT
			var _lid = layer_get_id("bly_event")
			layer_background_change(_lid,spr_bg_blank);
			
			scr_destroy_status(_ref);
		break;
	}
}