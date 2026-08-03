//===============================================================================//
//
// SCRIPT: SCR_STATUS_EVENT_BLOOMTIDE
// FUNCTION: Handles the Bloomtide global weather status.
//           At the end of each round:
//           - Heals every living Beast by 2.
//           - Cleanses one negative effect from one random living Beast.
//           - Grants Bloom to one random living Beast.
//
//===============================================================================//

function scr_status_event_bloomtide(_str_tag,_ref_status){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_existing_status =
				scr_check_for_status(
					"WEATHER: BLOOMTIDE",
					global.list_statuses
				);

			if (_ref_existing_status != -1){

				_ref_existing_status._val_status_lifetime =
					15;

				return _ref_existing_status;
			}

			var _ref_new_status =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_status",
					obj_battle_status
				);

			_ref_new_status._val_status_lifetime =
				15;

			_ref_new_status._scr_status =
				scr_status_event_bloomtide;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_name =
				"WEATHER: BLOOMTIDE";

			_ref_new_status._str_status_desc =
				"END OF ROUND: HEAL ALL BEASTS 2, CLEANSE 1 NEGATIVE EFFECT FROM A RANDOM BEAST, AND GIVE 1 RANDOM BEAST BLOOM.";

			_ref_new_status._spr_status =
				spr_status_event_bloomtide;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._str_status_type =
				"WEATHER";

			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			//-------------------//
			//CHANGE BACKGROUND//
			//-------------------//
			var _ref_layer =
				layer_get_id(
					"bly_event"
				);

			layer_background_change(
				_ref_layer,
				spr_scene_fx_bloomtide
			);

			scr_reposition_statuses(
				global.list_statuses
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			var _list_beasts =
				ds_list_create();

			//--------------------//
			//GET PLAYER BEASTS//
			//--------------------//
			for (
				var _it_beast = 0;
				_it_beast <
				ds_list_size(
					obj_battle_player_controller._list_beasts_alive
				);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						obj_battle_player_controller._list_beasts_alive,
						_it_beast
					);

				if (instance_exists(_ref_beast)){

					ds_list_add(
						_list_beasts,
						_ref_beast
					);
				}
			}

			//-------------------//
			//GET ENEMY BEASTS//
			//-------------------//
			for (
				var _it_beast = 0;
				_it_beast <
				ds_list_size(
					obj_battle_enemy_controller._list_beasts_alive
				);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						obj_battle_enemy_controller._list_beasts_alive,
						_it_beast
					);

				if (instance_exists(_ref_beast)){

					ds_list_add(
						_list_beasts,
						_ref_beast
					);
				}
			}


			//----------------//
			//HEAL ALL BY 2//
			//----------------//
			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_beasts);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_beasts,
						_it_beast
					);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				scr_heal_target(
					2,
					_ref_beast
				);
			}


			//--------------------------------//
			//CLEANSE RANDOM LIVING BEAST//
			//--------------------------------//
			if (ds_list_size(_list_beasts) > 0){

				var _ref_cleanse_target =
					ds_list_find_value(
						_list_beasts,
						irandom(
							ds_list_size(_list_beasts) - 1
						)
					);

				scr_cleanse_negative(
					_ref_cleanse_target,
					1
				);
			}


			//--------------------------//
			//GIVE 3 RANDOM BEASTS BLOOM//
			//--------------------------//
			if (ds_list_size(_list_beasts) > 0){
				repeat (3){
					var _ref_bloom_target =
						ds_list_find_value(
							_list_beasts,
							irandom(
								ds_list_size(_list_beasts) - 1
							)
						);

					var _ref_original_target =
						global.ref_target_beast;

					global.ref_target_beast =
						_ref_bloom_target;

					scr_apply_buff_status(
						"BLOOM",
						5,
						2
					);

					global.ref_target_beast =
						_ref_original_target;
				}
			}


			//---------------//
			//DESTROY LIST//
			//---------------//
			ds_list_destroy(
				_list_beasts
			);


			//----------------//
			//REDUCE LIFETIME//
			//----------------//
			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){

				_ref_status._str_status_command =
					"DEATH";
			}
			else{

				_ref_status._str_status_command =
					"WAIT";
			}

			scr_reposition_statuses(
				global.list_statuses
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			var _ref_layer =
				layer_get_id(
					"bly_event"
				);

			layer_background_change(
				_ref_layer,
				spr_bg_blank
			);

			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}