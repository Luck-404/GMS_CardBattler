//===============================================================================//
//
// SCR_STATUS_EVENT_RAPID_GROWTH
// FUNCTION: Handles the Rapid Growth global weather status.
//           Applies the status, repeats its end-turn effect,
//           and removes its background effect on death.
//
//===============================================================================//
function scr_status_event_rapid_growth(_str_tag,_ref_status){

	switch(_str_tag){

		case "APPLY":

			var _ref_existing_status = scr_check_for_status("WEATHER: RAPID GROWTH",global.list_statuses);

			if (_ref_existing_status != -1){
				_ref_existing_status._val_status_lifetime = 15;
				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(room_width/2,room_width/2,"ily_status",obj_battle_status);

			_ref_new_status._val_status_lifetime = 15;
			_ref_new_status._scr_status = scr_status_event_rapid_growth;
			_ref_new_status._ref_host = undefined;
			_ref_new_status._str_status_name = "WEATHER: RAPID GROWTH";
			_ref_new_status._str_status_desc = "GREEN DAMAGE +25%, RANDOMLY SPAWN 2 VIRIDIAN MINIONS AT THE END OF EVERY ROUND, ALSO HEAL SELECTED BY 1";
			_ref_new_status._spr_status = spr_status_event_rapid_growth;
			_ref_new_status._str_trigger_region = "END";
			_ref_new_status._str_status_type = "GLOBAL";

			ds_list_add(global.list_statuses,_ref_new_status);

			var _ref_layer = layer_get_id("bly_event");
			layer_background_change(_ref_layer,spr_scene_fx_rapid_growth);

			scr_reposition_statuses(global.list_statuses);

		break;

		case "REPEAT":

			var _list_beasts = ds_list_create();

			for (var _it_beast = 0; _it_beast < ds_list_size(obj_battle_player_controller._list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(obj_battle_player_controller._list_beasts_alive,_it_beast);

				if (instance_exists(_ref_beast)){
					ds_list_add(_list_beasts,_ref_beast);
				}
			}

			for (var _it_beast = 0; _it_beast < ds_list_size(obj_battle_enemy_controller._list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(obj_battle_enemy_controller._list_beasts_alive,_it_beast);

				if (instance_exists(_ref_beast)){
					ds_list_add(_list_beasts,_ref_beast);
				}
			}

			for (var _it_spawn = 0; _it_spawn < 2; _it_spawn++){

				if (ds_list_size(_list_beasts) <= 0){
					break;
				}

				var _ref_target = ds_list_find_value(_list_beasts,irandom(ds_list_size(_list_beasts) - 1));

				if (!instance_exists(_ref_target)){
					continue;
				}

				scr_heal_target(1,_ref_target);

				var _it_minion = irandom(ds_list_size(global.list_pool_viridian_minions) - 1);
				var _str_minion = ds_list_find_value(global.list_pool_viridian_minions,_it_minion);

				scr_init_minion(_str_minion,undefined,undefined,_ref_target);
			}

			ds_list_destroy(_list_beasts);

			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){
				_ref_status._str_status_command = "DEATH";
			}
			else{
				_ref_status._str_status_command = "WAIT";
			}

			scr_reposition_statuses(global.list_statuses);

		break;

		case "DEATH":

			var _ref_layer = layer_get_id("bly_event");
			layer_background_change(_ref_layer,spr_bg_blank);

			scr_destroy_status(_ref_status);

		break;
	}
}