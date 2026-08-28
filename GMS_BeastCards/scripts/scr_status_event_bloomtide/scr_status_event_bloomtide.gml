//===============================================================================//
//
// SCRIPT: SCR_STATUS_EVENT_BLOOMTIDE
// FUNCTION: Handles the Bloomtide global Event.
//           Converts excess healing into Overhealth while active.
//           Heals every living Beast by 2 at the end of each round.
//
//===============================================================================//

function scr_status_event_bloomtide(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status(
				"EVENT: BLOOMTIDE",
				global.list_statuses
			);

			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(_ref_existing_status,_val_lifetime);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			_ref_new_status._scr_status =
				scr_status_event_bloomtide;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_type =
				"EVENT";

			_ref_new_status._str_status_name =
				"EVENT: BLOOMTIDE";

			_ref_new_status._str_status_desc =
				"HEALING BEYOND MAXIMUM HP BECOMES OVERHEALTH. END OF ROUND: HEAL ALL LIVING BEASTS 2.";

			_ref_new_status._spr_status =
				spr_status_event_bloomtide;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._ct_status_stacks =
				1;

			//-------------------//
			//INITIALIZE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(_ref_new_status,_val_lifetime,false,false);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(global.list_statuses,_ref_new_status);

			//-------------------//
			//CHANGE EVENT VISUAL//
			//-------------------//
			var _ref_layer = layer_get_id("bly_event");

			layer_background_change(_ref_layer,spr_scene_fx_bloomtide);

			scr_reposition_statuses(global.list_statuses);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//-------------------//
			//HEAL PLAYER BEASTS//
			//-------------------//
			for (var _it_beast = 0; _it_beast < ds_list_size(obj_battle_player_controller._list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(
					obj_battle_player_controller._list_beasts_alive,
					_it_beast
				);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				scr_heal_target(2,_ref_beast);
			}

			//------------------//
			//HEAL ENEMY BEASTS//
			//------------------//
			for (var _it_beast = 0; _it_beast < ds_list_size(obj_battle_enemy_controller._list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(
					obj_battle_enemy_controller._list_beasts_alive,
					_it_beast
				);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				scr_heal_target(2,_ref_beast);
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			scr_reposition_statuses(global.list_statuses);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//------------------//
			//CLEAR EVENT VISUAL//
			//------------------//
			var _ref_layer = layer_get_id("bly_event");

			layer_background_change(_ref_layer,spr_bg_blank);

			scr_destroy_status(_ref_status);

		break;
	}

	return undefined;
}