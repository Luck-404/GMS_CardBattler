
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_TAUNT
// FUNCTION: Handles Taunt.
//           Unstackable Timed Buff with START decrement.
//           Only one normal Taunt may exist on a team.
//           The newest Taunt or Flameguard Taunt controls hostile targeting.
//           Reapplication refreshes duration and updates Taunt priority.
//           Older Flameguard passives remain intact but lose targeting
//           priority until they become the newest remaining Taunt.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference or undefined.
//
//===============================================================================//

function scr_status_buff_taunt(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//================//
			//VALIDATE TARGET//
			//================//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_lifetime == undefined){
				_val_lifetime = 2;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK OWN TAUNT//
			//================//
			var _ref_existing_status = scr_status_check(
				"TAUNT",
				_ref_target
			);

			//================//
			//REFRESH EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//------------------//
				//REFRESH LIFETIME//
				//------------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//================//
				//NEWEST PRIORITY//
				//================//
				if (!variable_global_exists("_ct_taunt_sequence")){
					global._ct_taunt_sequence = 0;
				}

				global._ct_taunt_sequence++;

				_ref_existing_status._val_taunt_priority =
					global._ct_taunt_sequence;

				//-----------------------//
				//ENSURE PERSISTENT VFX//
				//-----------------------//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){

					_ref_existing_status._ref_persistent_vfx = scr_battle_vfx_persistent(
						_ref_target,
						spr_battle_vfx_taunting,
						0,
						-110,
						1
					);
				}

				return _ref_existing_status;
			}

			//========================//
			//REMOVE OTHER TEAM TAUNT//
			//========================//
			// Remove other normal Taunts only.
			// Flameguard Taunts are source-bound and must remain intact.

			var _list_team = scr_battle_get_target_team_list(_ref_target);

			if (
				_list_team != undefined &&
				ds_exists(_list_team,ds_type_list)
			){

				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(_list_team);
					_it_beast++
				){

					var _ref_beast = ds_list_find_value(
						_list_team,
						_it_beast
					);

					if (
						!instance_exists(_ref_beast) ||
						_ref_beast == _ref_target
					){
						continue;
					}

					var _ref_old_taunt = scr_status_check(
						"TAUNT",
						_ref_beast
					);

					if (
						_ref_old_taunt != -1 &&
						instance_exists(_ref_old_taunt)
					){

						scr_status_buff_taunt(
							"DEATH",
							_ref_old_taunt
						);
					}
				}
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
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

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_taunt;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "TAUNT";

			_ref_new_status._str_status_desc =
				"NEWEST TAUNT CONTROLS HOSTILE PRIMARY TARGETING. " +
				"IGNORES RANGE AND BLIND. DOES NOT PREVENT AOE.";

			_ref_new_status._spr_status = spr_status_buff_taunt;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			//================//
			//NEWEST PRIORITY//
			//================//
			if (!variable_global_exists("_ct_taunt_sequence")){
				global._ct_taunt_sequence = 0;
			}

			global._ct_taunt_sequence++;

			_ref_new_status._val_taunt_priority =
				global._ct_taunt_sequence;

			//================//
			//START DECREMENT//
			//================//
			_ref_new_status._str_trigger_region = "START";

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			//----------------//
			//PERSISTENT VFX//
			//----------------//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent(
				_ref_target,
				spr_battle_vfx_taunting,
				0,
				-110,
				1
			);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_status_destroy(_ref_status);

				return undefined;
			}

			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}