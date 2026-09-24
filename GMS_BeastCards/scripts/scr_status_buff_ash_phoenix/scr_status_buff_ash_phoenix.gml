//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ASH_PHOENIX
// FUNCTION: Grants +15 Dodge while the source Ash Phoenix lives.
//           Each source Minion maintains its own Buff.
//           Removes the granted Dodge when the source is destroyed.
//
//===============================================================================//

function scr_status_buff_ash_phoenix(_str_tag,_ref_status,_ref_source_minion=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//================//
			//VALIDATE MINION//
			//================//
			if (!instance_exists(_ref_source_minion)){
				return undefined;
			}

			if (_ref_source_minion._str_name != "ASH PHOENIX"){
				return undefined;
			}

			//================//
			//VALIDATE HOST//
			//================//
			var _ref_host = _ref_source_minion._ref_host;

			if (!instance_exists(_ref_host)){
				return undefined;
			}

			if (!ds_exists(_ref_host._list_statuses,ds_type_list)){
				return undefined;
			}

			//================//
			//CHECK EXACT SOURCE//
			//================//
			for (
				var _it_status = 0;
				_it_status < ds_list_size(_ref_host._list_statuses);
				_it_status++
			){

				var _ref_existing = ds_list_find_value(
					_ref_host._list_statuses,
					_it_status
				);

				if (!instance_exists(_ref_existing)){
					continue;
				}

				if (_ref_existing._str_status_name != "ASH_PHOENIX"){
					continue;
				}

				if (_ref_existing._ref_source_minion == _ref_source_minion){
					return _ref_existing;
				}
			}

			//================//
			//CREATE STATUS//
			//================//
			var _ref_new_status = instance_create_layer(
				_ref_host.x,
				_ref_host.y,
				"ily_status",
				obj_battle_status
			);

			//================//
			//INFINITE LIFETIME//
			//================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//================//
			//STATUS DATA//
			//================//
			_ref_new_status._scr_status = scr_status_buff_ash_phoenix;

			_ref_new_status._ref_host = _ref_host;
			_ref_new_status._ref_source_minion = _ref_source_minion;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "ASH_PHOENIX";

			_ref_new_status._str_status_desc =
				"+15 DODGE WHILE ASH PHOENIX LIVES.";

			_ref_new_status._spr_status = spr_status_buff_ash_phoenix;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = 15;

			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._flag_status_uncleansable = true;
			_ref_new_status._flag_status_requires_live_source_minion = true;

			_ref_new_status._str_trigger_region = undefined;

			//================//
			//GRANT DODGE//
			//================//
			_ref_host._val_dodge_bonus +=
				_ref_new_status._val_status_magnitude;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_host._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_host);

			return _ref_new_status;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			//================//
			//VALIDATE STATUS//
			//================//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//================//
			//REMOVE DODGE//
			//================//
			if (instance_exists(_ref_host)){

				_ref_host._val_dodge_bonus -=
					_ref_status._val_status_magnitude;
			}

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}