//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_FIRESTORM
// FUNCTION: Handles Firestorm Weather.
//           At the end of each round, applies 1 Burn to every living Beast.
//
//           ERUPTION 10:
//           Consume exactly 10 Burn from the Beast.
//           Deal 20 fixed NEU damage, bypassing Armor.
//           Apply 3 Char if the Beast survives.
//
//           Lifetime: 5 rounds.
//           Owns Firestorm Weather VFX.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references the existing Firestorm Status.
//            _val_lifetime optionally overrides its duration.
// RETURNS: Applied or existing Weather Status on APPLY; undefined on other paths.
//
//===============================================================================//

function scr_status_weather_firestorm(_str_tag,_ref_status,_val_lifetime=undefined){

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
				_val_lifetime = 5;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check(
				"WEATHER: FIRESTORM",
				global.list_statuses
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
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
			_ref_new_status._scr_status = scr_status_weather_firestorm;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "WEATHER";
			_ref_new_status._str_status_name = "WEATHER: FIRESTORM";

			_ref_new_status._str_status_desc = "Weather. At the end of each round, apply 1 Burn to every living Beast. ERUPTION 10: Consume all Burn from that Beast, deal 20 NEU dmg to it, and apply 3 Char. Lifetime: 5 rounds.";

			//----------------//
			//STATUS SPRITE//
			//----------------//
			var _spr_firestorm_status = asset_get_index(
				"spr_status_weather_firestorm"
			);

			if (_spr_firestorm_status == -1){
				_spr_firestorm_status = spr_status_dot_burn;
			}

			_ref_new_status._spr_status = _spr_firestorm_status;

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

			//================//
			//START VFX//
			//================//
			scr_battle_vfx_weather_firestorm(
				"START"
			);

			//=======================//
			//PERSISTENT FIRESTORM FX//
			//=======================//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent_loop(
				spr_battle_vfx_weather_firestorm_persist,
				room_width * 0.5,
				room_height * 0.5,
				1,
				"ily_weather_fx"
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

			//===================//
			//BUILD BEAST ARRAY//
			//===================//
			var _arr_beasts = [];

			//----------------//
			//GET TEAM LISTS//
			//----------------//
			var _arr_team_lists = [];

			if (instance_exists(obj_battle_player_controller)){

				array_push(
					_arr_team_lists,
					obj_battle_player_controller._list_beasts_alive
				);
			}

			if (instance_exists(obj_battle_enemy_controller)){

				array_push(
					_arr_team_lists,
					obj_battle_enemy_controller._list_beasts_alive
				);
			}

			//----------------------//
			//COLLECT LIVING BEASTS//
			//----------------------//
			for (
				var _it_team = 0;
				_it_team < array_length(_arr_team_lists);
				_it_team++
			){

				var _list_team = _arr_team_lists[_it_team];

				if (!ds_exists(_list_team,ds_type_list)){
					continue;
				}

				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(_list_team);
					_it_beast++
				){

					var _ref_beast = ds_list_find_value(
						_list_team,
						_it_beast
					);

					if (!instance_exists(_ref_beast)){
						continue;
					}

					if (
						_ref_beast._str_list != "ALIVE" ||
						_ref_beast._val_cur_hp <= 0
					){
						continue;
					}

					array_push(
						_arr_beasts,
						_ref_beast
					);
				}
			}


			//================//
			//TICK SOUND FLAG//
			//================//
			var _flag_firestorm_sound_played = false;

			//============================//
			//APPLY BURN AND CHECK ERUPTION//
			//============================//
			for (
				var _it_beast = 0;
				_it_beast < array_length(_arr_beasts);
				_it_beast++
			){

				var _ref_beast = _arr_beasts[_it_beast];

				//----------------//
				//VALIDATE BEAST//
				//----------------//
				if (!instance_exists(_ref_beast)){
					continue;
				}

				if (
					_ref_beast._str_list != "ALIVE" ||
					_ref_beast._val_cur_hp <= 0
				){
					continue;
				}

				//================//
				//FIRESTORM TICK FX//
				//================//
				scr_battle_vfx_weather_firestorm(
					"TICK",
					_ref_beast,
					!_flag_firestorm_sound_played
				);

				_flag_firestorm_sound_played = true;

				//================//
				//APPLY 1 BURN//
				//================//

				scr_status_apply_dot("BURN", _ref_beast);

				//------------------------//
				//CHECK BEAST AFTER BURN//
				//------------------------//
				if (
					!instance_exists(_ref_beast) ||
					_ref_beast._str_list != "ALIVE" ||
					_ref_beast._val_cur_hp <= 0
				){
					continue;
				}

				//========================//
				//CHECK ERUPTION 10 BURN//
				//========================//
				var _ref_burn = scr_status_check("BURN",_ref_beast);

				if (_ref_burn == -1 || !instance_exists(_ref_burn)){
					continue;
				}

				if (_ref_burn._ct_status_stacks < 10){
					continue;
				}

				//==================//
				//CONSUME 10 BURN//
				//==================//
				// Any Burn above 10 remains on the Beast.
				var _ct_burn_consumed = scr_status_consume_burn(
					_ref_beast,
					10
				);

				if (_ct_burn_consumed < 10){
					continue;
				}

				//======================//
				//DEAL 20 NEU DAMAGE//
				//======================//
				// Fixed Weather damage bypasses Armor.
				// Overhealth absorbs damage before HP.

				var _val_damage_remaining = 20;
				var _val_beast_damage = 0;

				//================//
				//OVERHEALTH//
				//================//
				if (_ref_beast._val_overhealth > 0){

					var _val_overhealth_damage = min(
						_ref_beast._val_overhealth,
						_val_damage_remaining
					);

					_ref_beast._val_overhealth -= _val_overhealth_damage;

					_val_damage_remaining -= _val_overhealth_damage;

					_val_beast_damage += _val_overhealth_damage;

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"-" + string(_val_overhealth_damage),
						undefined,
						c_green,
						_ref_beast.x,
						_ref_beast.y - 24
					);
				}

				//================//
				//HP DAMAGE//
				//================//
				if (
					_val_damage_remaining > 0 &&
					_ref_beast._val_cur_hp > 0
				){

					var _val_hp_damage = min(
						_val_damage_remaining,
						_ref_beast._val_cur_hp
					);

					_ref_beast._val_cur_hp = max(
						0,
						_ref_beast._val_cur_hp - _val_hp_damage
					);

					_val_beast_damage += _val_hp_damage;

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"-" + string(_val_hp_damage),
						undefined,
						c_maroon,
						_ref_beast.x,
						_ref_beast.y - 48
					);
				}

				//================//
				//WAKE SLEEP//
				//================//
				if (
					_val_beast_damage > 0 &&
					_ref_beast._val_cur_hp > 0
				){

					scr_status_wake_sleep_on_damage(
						_ref_beast
					);
				}

				//======================//
				//CHECK SURVIVING BEAST//
				//======================//
				if (
					_ref_beast._str_list != "ALIVE" ||
					_ref_beast._val_cur_hp <= 0
				){
					continue;
				}

				//================//
				//APPLY 3 CHAR//
				//================//

				var _ct_char_applied = 0;

				repeat (3){

					var _ref_char = scr_status_debuff_char("APPLY", undefined, undefined, _ref_beast);

					if (instance_exists(_ref_char)){
						_ct_char_applied++;
					}
				}

				//================//
				//CHAR FEEDBACK//
				//================//
				if (_ct_char_applied > 0){

					scr_battle_vfx_char(
						_ref_beast
					);

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"+" + string(_ct_char_applied) + " CHAR",
						undefined,
						c_red,
						_ref_beast.x,
						_ref_beast.y - 48
					);
				}
			}


			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			if (instance_exists(_ref_status)){

				scr_status_tick_lifetime(
					_ref_status
				);
			}

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			if (ds_exists(global.list_statuses,ds_type_list)){

				scr_status_reposition(
					global.list_statuses
				);
			}

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//================//
			//DESTROY WEATHER//
			//================//
			scr_status_destroy(
				_ref_status
			);

		break;
	}

	return undefined;
}