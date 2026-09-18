//===============================================================================//
//
// SCRIPT: SCR_STATUS_EVENT_BLOODMIST
// FUNCTION: Handles the Bloodmist global Event.
//           While active, every living Beast has Infinite generic Blind.
//           At the end of each round, every living Beast heals 5 HP and gains
//           1 Bleed.
//           While Bloodmist is active, all Attacks trigger HEMORRHAGE.
//           Lasts 3 rounds by default.
//
//           Bloodmist Blind uses the normal BLIND Crowd Control Status.
//           Attack HEMORRHAGE is resolved by the shared Attack-resolution hook.
//
//           Uses start and persistent VFX only.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references an existing Bloodmist Status.
//            _val_lifetime optionally overrides its duration.
// RETURNS: Active Bloodmist Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_event_bloodmist(_str_tag,_ref_status,_val_lifetime=undefined){

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

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"EVENT: BLOODMIST",
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

				//======================//
				//ENSURE BLIND ON ALL//
				//======================//
				scr_status_apply_bloodmist_blind();

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
			_ref_new_status._scr_status = scr_status_event_bloodmist;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "EVENT";
			_ref_new_status._str_status_name = "EVENT: BLOODMIST";
			_ref_new_status._str_status_desc = "END OF ROUND: HEAL ALL LIVING BEASTS 5 HP AND APPLY 1 BLEED. WHILE ACTIVE: ALL BEASTS ARE BLIND AND ALL ATTACKS HEMORRHAGE.";

			_ref_new_status._spr_status = spr_status_event_bloodmist;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._flag_status_permanent = false;

			_ref_new_status._str_trigger_region = "END";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			//================//
			//BLOODMIST START//
			//================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_event_bloodmist_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				snd_battle_event_bloodmist_start
			);

			//========================//
			//PERSISTENT BLOODMIST FX//
			//========================//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent_loop(
				spr_battle_vfx_event_bloodmist_persist,
				room_width * 0.5,
				room_height * 0.5,
				1
			);

			//======================//
			//BLIND ALL BEASTS//
			//======================//
			scr_status_apply_bloodmist_blind();

			//================//
			//REPOSITION EVENT//
			//================//
			scr_status_reposition(
				global.list_statuses
			);

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

			//======================//
			//SYNC BLOODMIST BLIND//
			//======================//
			scr_status_apply_bloodmist_blind();

			//================//
			//GET BEAST LISTS//
			//================//
			var _arr_beast_lists = [];
			var _arr_targets = [];

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

			//=====================//
			//SNAPSHOT ALL BEASTS//
			//=====================//
			for (var _it_team = 0;_it_team < array_length(_arr_beast_lists);_it_team++){

				var _list_beasts = _arr_beast_lists[_it_team];

				if (!ds_exists(_list_beasts,ds_type_list)){
					continue;
				}

				for (var _it_beast = 0;_it_beast < ds_list_size(_list_beasts);_it_beast++){

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

					array_push(
						_arr_targets,
						_ref_beast
					);
				}
			}

			//================//
			//STORE TARGET//
			//================//
			var _ref_original_target = global.ref_target_beast;

			//=========================//
			//HEAL + BLEED ALL BEASTS//
			//=========================//
			for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

				var _ref_target = _arr_targets[_it_target];

				if (!instance_exists(_ref_target)){
					continue;
				}

				if (
					_ref_target._str_list != "ALIVE" ||
					_ref_target._val_cur_hp <= 0
				){
					continue;
				}

				//================//
				//HEAL 5 HP//
				//================//
				scr_battle_heal_target(
					5,
					_ref_target
				);

				//--------------------------//
				//REVALIDATE AFTER HEALING//
				//--------------------------//
				if (!instance_exists(_ref_target)){
					continue;
				}

				if (
					_ref_target._str_list != "ALIVE" ||
					_ref_target._val_cur_hp <= 0
				){
					continue;
				}

				//================//
				//APPLY 1 BLEED//
				//================//
				global.ref_target_beast = _ref_target;

				scr_status_apply_dot(
					"BLEED"
				);
			}

			//================//
			//RESTORE TARGET//
			//================//
			global.ref_target_beast = _ref_original_target;

			//================//
			//UPDATE LIFETIME//
			//================//
			if (instance_exists(_ref_status)){
				scr_status_tick_lifetime(_ref_status);
			}

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

			//================//
			//REMOVE BLIND//
			//================//
			scr_status_remove_bloodmist_blind();

			//===========================//
			//CLEAR ATTACK TARGET CACHE//
			//===========================//
			if (
				variable_global_exists(
					"arr_bloodmist_attack_targets"
				)
			){
				global.arr_bloodmist_attack_targets = [];
			}

			//================//
			//DESTROY EVENT//
			//================//
			scr_status_destroy(
				_ref_status
			);

		break;
	}

	return undefined;
}