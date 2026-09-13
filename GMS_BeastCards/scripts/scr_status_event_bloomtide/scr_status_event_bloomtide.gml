//===============================================================================//
//
// SCRIPT: SCR_STATUS_EVENT_BLOOMTIDE
// FUNCTION: Handles the Bloomtide global Event.
//           Converts excess healing into Overhealth while active.
//           Heals every living Beast by 2 at the end of each round.
//
// ARGUMENTS: _str_tag selects the Status action, _ref_status references an
//            existing Status, and _val_lifetime optionally sets its duration.
// RETURNS: The active Bloomtide Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_event_bloomtide(_str_tag,_ref_status,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//----------------------//
			//VALIDATE GLOBAL LIST//
			//----------------------//
			if (!ds_exists(global.list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check(
				"EVENT: BLOOMTIDE",
				global.list_statuses
			);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//================//
			//CREATE STATUS//
			//================//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_event_bloomtide;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "EVENT";
			_ref_new_status._str_status_name = "EVENT: BLOOMTIDE";
			_ref_new_status._str_status_desc = "HEALING BEYOND MAXIMUM HP BECOMES OVERHEALTH. END OF ROUND: HEAL ALL LIVING BEASTS 2.";

			_ref_new_status._spr_status = spr_status_event_bloomtide;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			//=====================//
			//BLOOMTIDE START VFX//
			//=====================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_event_bloomtide_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				snd_battle_event_bloomtide_start
			);

			//==========================//
			//PERSISTENT BLOOMTIDE VFX//
			//==========================//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent_loop(
				spr_battle_vfx_event_bloomtide_persist,
				room_width * 0.5,
				room_height * 0.5,
				1
			);

			//====================//
			//BLOOMTIDE AMBIENCE//
			//====================//
			scr_status_start_persistent_audio(
				_ref_new_status,
				bgm_battle_event_bloomtide,
				0.25
			);

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			scr_status_reposition(global.list_statuses);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			//-----------------//
			//VALIDATE STATUS//
			//-----------------//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//====================//
			//BLOOMTIDE TICK VFX//
			//====================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_event_bloomtide_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				undefined
			);

			//=================//
			//HEAL ALL BEASTS//
			//=================//
			if (instance_exists(obj_battle_player_controller)){

				var _list_player_beasts = obj_battle_player_controller._list_beasts_alive;

				if (ds_exists(_list_player_beasts,ds_type_list)){

					for (var _it_beast = 0;_it_beast < ds_list_size(_list_player_beasts);_it_beast++){

						var _ref_beast = ds_list_find_value(_list_player_beasts,_it_beast);

						if (!instance_exists(_ref_beast)){
							continue;
						}

						if (
							_ref_beast._str_list != "ALIVE" ||
							_ref_beast._val_cur_hp <= 0
						){
							continue;
						}

						//----------------//
						//TARGET HEAL VFX//
						//----------------//
						scr_battle_vfx(
							undefined,
							spr_battle_vfx_event_bloomtide_tick,
							_ref_beast.x,
							_ref_beast.y - 48,
							0,
							0,
							1,
							0,
							undefined
						);

						//-----------//
						//HEAL BEAST//
						//-----------//
						scr_battle_heal_target(2,_ref_beast);
					}
				}
			}

			if (instance_exists(obj_battle_enemy_controller)){

				var _list_enemy_beasts = obj_battle_enemy_controller._list_beasts_alive;

				if (ds_exists(_list_enemy_beasts,ds_type_list)){

					for (var _it_beast = 0;_it_beast < ds_list_size(_list_enemy_beasts);_it_beast++){

						var _ref_beast = ds_list_find_value(_list_enemy_beasts,_it_beast);

						if (!instance_exists(_ref_beast)){
							continue;
						}

						if (
							_ref_beast._str_list != "ALIVE" ||
							_ref_beast._val_cur_hp <= 0
						){
							continue;
						}

						//----------------//
						//TARGET HEAL VFX//
						//----------------//
						scr_battle_vfx(
							undefined,
							spr_battle_vfx_event_bloomtide_tick,
							_ref_beast.x,
							_ref_beast.y - 48,
							0,
							0,
							1,
							0,
							undefined
						);

						//-----------//
						//HEAL BEAST//
						//-----------//
						scr_battle_heal_target(2,_ref_beast);
					}
				}
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			if (ds_exists(global.list_statuses,ds_type_list)){
				scr_status_reposition(global.list_statuses);
			}

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}