//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_PHOENIX_REBIRTH
// FUNCTION: Handles Phoenix Rebirth.
//           Infinite, unstackable, and uncleansable.
//           The next time the host would be defeated:
//           - Restore it to 40% Maximum HP.
//           - Remove every negative Status.
//           - Heal every other living ally for 20% Maximum HP.
//           - Consume Phoenix Rebirth.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_phoenix_rebirth(_str_tag,_ref_status,_val_magnitude=undefined,_ref_target=undefined){

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
			if (_val_magnitude == undefined){
				_val_magnitude = 40;
			}

			_val_magnitude = clamp(
				_val_magnitude,
				1,
				100
			);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"PHOENIX_REBIRTH",
				_ref_target
			);

			//====================//
			//ALREADY HAS REBIRTH//
			//====================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				_ref_existing_status._val_status_magnitude =
					_val_magnitude;

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

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//================//
			//STATUS DATA//
			//================//
			_ref_new_status._scr_status =
				scr_status_buff_phoenix_rebirth;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "PHOENIX_REBIRTH";

			_ref_new_status._str_status_desc =
				"NEXT DEFEAT: REVIVE AT " +
				string(_val_magnitude) +
				"% MAX HP, CLEANSE ALL NEGATIVE STATUSES, " +
				"HEAL OTHER ALLIES FOR 20% MAX HP.";

			_ref_new_status._spr_status =
				spr_status_buff_phoenix_rebirth;

			_ref_new_status._ct_status_stacks = 1;

			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._flag_status_uncleansable = true;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_trigger_region = undefined;

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

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//================//
			//VALIDATE STATUS//
			//================//
			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			//================//
			//REVIVE HP//
			//================//
			var _val_revive_hp = max(
				1,
				ceil(
					_ref_host._val_max_hp *
					(_ref_status._val_status_magnitude / 100)
				)
			);

			_ref_host._val_cur_hp = min(
				_ref_host._val_max_hp,
				_val_revive_hp
			);

			//================//
			//FEEDBACK//
			//================//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"PHOENIX REBIRTH",
				undefined,
				c_red,
				_ref_host.x,
				_ref_host.y - 48
			);

			//======================//
			//CONSUME PHOENIX BUFF//
			//======================//
			// Remove this before cleansing so the trigger cannot
			// recursively participate in any following effects.

			scr_status_buff_phoenix_rebirth(
				"DEATH",
				_ref_status
			);

			//=======================//
			//REMOVE ALL NEGATIVES//
			//=======================//
				scr_status_cleanse(
					_ref_host,
					"NEGATIVE",
					"ALL",
					{
						_flag_ignore_uncleansable: true,
						_flag_show_popups: false,
						_flag_force_vfx: true
					}
				);
				
			//================//
			//GET ALLIED TEAM//
			//================//
			var _list_allies =
				scr_battle_get_target_team_list(
					_ref_host
				);

			//================//
			//HEAL ALLIES//
			//================//
			if (
				_list_allies != undefined &&
				ds_exists(_list_allies,ds_type_list)
			){

				//----------------//
				//SNAPSHOT ALLIES//
				//----------------//
				var _arr_allies = [];

				for (
					var _it_ally = 0;
					_it_ally < ds_list_size(_list_allies);
					_it_ally++
				){

					array_push(
						_arr_allies,
						ds_list_find_value(
							_list_allies,
							_it_ally
						)
					);
				}

				//================//
				//HEAL OTHER ALLIES//
				//================//
				for (
					var _it_ally = 0;
					_it_ally < array_length(_arr_allies);
					_it_ally++
				){

					var _ref_ally = _arr_allies[_it_ally];

					if (!instance_exists(_ref_ally)){
						continue;
					}

					//----------------//
					//EXCLUDE REVIVED//
					//----------------//
					if (_ref_ally == _ref_host){
						continue;
					}

					if (
						_ref_ally._str_list != "ALIVE" ||
						_ref_ally._val_cur_hp <= 0
					){
						continue;
					}

					//================//
					//20% MAX HP HEAL//
					//================//
					var _val_heal = max(
						1,
						ceil(
							_ref_ally._val_max_hp *
							0.20
						)
					);

					scr_battle_heal_target(
						"FIXED",
						_val_heal,
						_ref_ally
					);
				}
			}

			//================//
			//DEBUG TRIGGER//
			//================//
			scr_debug_log_battle_trigger(
				"PHOENIX REBIRTH",
				_ref_host,
				_ref_host,
				"REVIVED TO " +
				string(_ref_host._val_cur_hp) +
				"/" +
				string(_ref_host._val_max_hp),
				"SCR_STATUS_BUFF_PHOENIX_REBIRTH"
			);

			return true;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (instance_exists(_ref_status)){

				scr_status_destroy(
					_ref_status
				);
			}

		break;
	}

	return undefined;
}
