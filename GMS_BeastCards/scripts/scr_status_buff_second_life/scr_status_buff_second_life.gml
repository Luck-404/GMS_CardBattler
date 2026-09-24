//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_SECOND_LIFE
// FUNCTION: Handles Second Life.
//           Unstackable Timed Buff.
//           Prevents the host's next defeat while active.
//           Reapplication refreshes duration without stacking.
//           Restores the host to 25% Maximum HP when triggered and logs
//           the prevented death.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_second_life(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


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
				_val_lifetime = 4;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"SECOND_LIFE",
				_ref_target
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
			_ref_new_status._scr_status = scr_status_buff_second_life;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "SECOND_LIFE";
			_ref_new_status._str_status_desc = "NEXT DEFEAT RESTORES 25% MAXIMUM HP";

			_ref_new_status._spr_status = spr_status_buff_second_life;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "START";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

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

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (!is_struct(_ref_host._ref_unit)){
				return false;
			}

			//================//
			//STORE OLD HP//
			//================//
			var _val_hp_before = _ref_host._val_cur_hp;

			//=================//
			//RESTORE HOST HP//
			//=================//
			var _val_restored_hp = max(
				1,
				ceil(
					_ref_host._val_max_hp *
					0.25
				)
			);

			_ref_host._val_cur_hp = min(
				_val_restored_hp,
				_ref_host._val_max_hp
			);

			//==========//
			//FEEDBACK//
			//==========//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"SECOND LIFE",
				undefined,
				c_green,
				_ref_host.x,
				_ref_host.y - 48
			);

			//=====================//
			//DEBUG SECOND LIFE//
			//=====================//
			scr_debug_log(
				"BATTLE",
				"REVIVE",
				_ref_host,
				string_upper(_ref_host._str_team) + " " +
				string_upper(_ref_host._ref_unit._str_beast_name) +
				" (LVL " + string(_ref_host._ref_unit._val_beast_level) + ")" +
				" TRIGGERED SECOND LIFE" +
				" | HP: " +
				string(_val_hp_before) +
				" -> " +
				string(_ref_host._val_cur_hp) +
				"/" +
				string(_ref_host._val_max_hp) +
				" | DEATH PREVENTED",
				"BATTLE",
				"SCR_STATUS_BUFF_SECOND_LIFE"
			);

			//================//
			//CONSUME STATUS//
			//================//
			scr_status_buff_second_life(
				"DEATH",
				_ref_status
			);

			return true;

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
