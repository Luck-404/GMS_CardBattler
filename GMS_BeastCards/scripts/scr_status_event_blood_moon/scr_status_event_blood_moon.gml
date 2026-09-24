//===============================================================================//
//
// SCRIPT: SCR_STATUS_EVENT_BLOOD_MOON
// FUNCTION: Handles the Blood Moon global Event.
//           All healing is prevented.
//           At the end of each round, each living Beast gains 1 Rage.
//           Each living Minion on that Beast grows by +1/+1.
//           When Blood Moon naturally expires, every living Beast gains 1 Bloodlet.
//           Lasts 4 rounds by default.
//
// ARGUMENTS: _str_tag, _ref_status, _val_lifetime.
// RETURNS: Applied or existing Event Status on APPLY; undefined on other paths.
//
//===============================================================================//

function scr_status_event_blood_moon(_str_tag,_ref_status,_val_lifetime=undefined){

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
				_val_lifetime = 4;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"EVENT: BLOOD_MOON",
				global.list_statuses
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

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

			//=====================//
			//INITIALIZE LIFETIME//
			//=====================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_event_blood_moon;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "EVENT";
			_ref_new_status._str_status_name = "EVENT: BLOOD_MOON";
			_ref_new_status._str_status_desc = "Event. All healing is prevented. At the end of each round, each living Beast gains 1 Rage, and each Minion on that Beast gains (+1/+1). When Blood Moon expires, apply 1 Bloodlet to every living Beast. Lifetime: 4 rounds.";

			_ref_new_status._spr_status = spr_status_event_blood_moon;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(global.list_statuses,_ref_new_status);

			//======================//
			//BLOOD MOON START VFX//
			//======================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_event_blood_moon_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				snd_battle_event_blood_moon_start
			);

			//===========================//
			//PERSISTENT BLOOD MOON VFX//
			//===========================//
			_ref_new_status._ref_persistent_vfx =
				scr_battle_vfx_persistent_loop(
					spr_battle_vfx_event_blood_moon_persist,
					room_width * 0.5,
					room_height * 0.5,
					1
				);

			//================//
			//REPOSITION EVENT//
			//================//
			scr_status_reposition(global.list_statuses);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			//----------------//
			//VALIDATE STATUS//
			//----------------//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//================//
			//GET BEAST LISTS//
			//================//
			var _arr_beast_lists = [];

			if (instance_exists(obj_battle_player_controller)){

				array_push(
					_arr_beast_lists,
					obj_battle_player_controller._list_beasts_alive
				);
			}

			if (instance_exists(obj_battle_enemy_controller)){

				array_push(
					_arr_beast_lists,
					obj_battle_enemy_controller._list_beasts_alive
				);
			}

			//================//
			//SNAPSHOT BEASTS//
			//================//
			var _arr_beasts = [];

			for (
				var _it_team = 0;
				_it_team < array_length(_arr_beast_lists);
				_it_team++
			){

				var _list_beasts = _arr_beast_lists[_it_team];

				if (!ds_exists(_list_beasts,ds_type_list)){
					continue;
				}

				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(_list_beasts);
					_it_beast++
				){

					var _ref_beast = ds_list_find_value(
						_list_beasts,
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

					array_push(_arr_beasts,_ref_beast);
				}
			}

			//================//
			//TRACK RESULTS//
			//================//
			var _ct_rage_applied = 0;
			var _ct_minions_grown = 0;

			//================//
			//PROCESS BEASTS//
			//================//
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

				#region RAGE

				//================//
				//GAIN 1 RAGE//
				//================//
				var _ref_rage = scr_status_gain_rage(
					_ref_beast,
					1
				);

				if (instance_exists(_ref_rage)){
					_ct_rage_applied++;
				}

				#endregion

				#region MINION GROWTH

				//==================//
				//CHECK MINION LIST//
				//==================//
				if (ds_exists(_ref_beast._list_minions,ds_type_list)){

					//================//
					//SNAPSHOT MINIONS//
					//================//
					var _arr_minions = [];

					for (
						var _it_minion = 0;
						_it_minion < ds_list_size(_ref_beast._list_minions);
						_it_minion++
					){

						var _ref_minion = ds_list_find_value(
							_ref_beast._list_minions,
							_it_minion
						);

						if (!instance_exists(_ref_minion)){
							continue;
						}

						if (_ref_minion._val_cur_hp <= 0){
							continue;
						}

						array_push(
							_arr_minions,
							_ref_minion
						);
					}

					//================//
					//GROW EACH MINION//
					//================//
					for (
						var _it_minion = 0;
						_it_minion < array_length(_arr_minions);
						_it_minion++
					){

						var _ref_minion = _arr_minions[_it_minion];

						if (!instance_exists(_ref_minion)){
							continue;
						}

						if (_ref_minion._val_cur_hp <= 0){
							continue;
						}

						//================//
						//GROW +1/+1//
						//================//
						if (scr_minion_grow(_ref_minion,1)){
							_ct_minions_grown++;
						}
					}
				}

				#endregion
			}

			//================//
			//DEBUG ROUND//
			//================//
			scr_debug_log(
				"BATTLE",
				"EVENT",
				_ref_status,
				"BLOOD MOON ROUND END" +
				" | BEASTS: " + string(array_length(_arr_beasts)) +
				" | RAGE APPLIED: " + string(_ct_rage_applied) +
				" | MINIONS GROWN: " + string(_ct_minions_grown),
				"BATTLE",
				"SCR_STATUS_EVENT_BLOOD_MOON"
			);

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

			//================//
			//REPOSITION EVENT//
			//================//
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

			//----------------//
			//VALIDATE STATUS//
			//----------------//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//==========================//
			//CHECK NATURAL EXPIRATION//
			//==========================//
			var _flag_natural_expiration = (
				variable_instance_exists(_ref_status,"_val_status_lifetime") &&
				is_real(_ref_status._val_status_lifetime) &&
				_ref_status._val_status_lifetime <= 0
			);

			if (_flag_natural_expiration){

				//================//
				//GET BEAST LISTS//
				//================//
				var _arr_beast_lists = [];

				if (instance_exists(obj_battle_player_controller)){

					array_push(
						_arr_beast_lists,
						obj_battle_player_controller._list_beasts_alive
					);
				}

				if (instance_exists(obj_battle_enemy_controller)){

					array_push(
						_arr_beast_lists,
						obj_battle_enemy_controller._list_beasts_alive
					);
				}

				//================//
				//SNAPSHOT BEASTS//
				//================//
				var _arr_beasts = [];

				for (
					var _it_team = 0;
					_it_team < array_length(_arr_beast_lists);
					_it_team++
				){

					var _list_beasts = _arr_beast_lists[_it_team];

					if (!ds_exists(_list_beasts,ds_type_list)){
						continue;
					}

					for (
						var _it_beast = 0;
						_it_beast < ds_list_size(_list_beasts);
						_it_beast++
					){

						var _ref_beast = ds_list_find_value(
							_list_beasts,
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

						array_push(_arr_beasts,_ref_beast);
					}
				}

				//================//
				//APPLY BLOODLET//
				//================//
				var _ct_bloodlet_applied = 0;

				for (
					var _it_beast = 0;
					_it_beast < array_length(_arr_beasts);
					_it_beast++
				){

					var _ref_beast = _arr_beasts[_it_beast];

					if (!instance_exists(_ref_beast)){
						continue;
					}

					if (
						_ref_beast._str_list != "ALIVE" ||
						_ref_beast._val_cur_hp <= 0
					){
						continue;
					}

					var _ref_bloodlet = scr_status_apply_debuff(
						"BLOODLET",
						_ref_beast,
						undefined,
						undefined,
						true
					);

					if (instance_exists(_ref_bloodlet)){
						_ct_bloodlet_applied++;
					}
				}

				//================//
				//DEBUG EXPIRATION//
				//================//
				scr_debug_log(
					"BATTLE",
					"EVENT",
					_ref_status,
					"BLOOD MOON EXPIRED" +
						" | BEASTS: " + string(array_length(_arr_beasts)) +
						" | BLOODLET APPLIED: " + string(_ct_bloodlet_applied),
					"BATTLE",
					"SCR_STATUS_EVENT_BLOOD_MOON"
				);
			}

			//================//
			//DESTROY EVENT//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}