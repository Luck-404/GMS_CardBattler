//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_INNER_FLAME
// FUNCTION: Stores bonus damage from cleansed Statuses.
//           Activates immediately before the host's next Attack.
//           Removes its exact damage contribution after that Attack.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_inner_flame(_str_tag,_ref_status,_val_magnitude=undefined,_ref_target=undefined){

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
			if (_val_magnitude == undefined){
				_val_magnitude = 0;
			}

			_val_magnitude = max(0,floor(_val_magnitude));

			if (_val_magnitude <= 0){
				return undefined;
			}

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"INNER_FLAME",
				_ref_target
			);

			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//------------------//
				//ACCUMULATE BONUS//
				//------------------//
				_ref_existing_status._val_status_magnitude += _val_magnitude;

				_ref_existing_status._str_status_desc =
					"NEXT ATTACK: +" +
					string(_ref_existing_status._val_status_magnitude) +
					" DAMAGE";

				return _ref_existing_status;
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

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_inner_flame;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "INNER_FLAME";

			_ref_new_status._str_status_desc =
				"NEXT ATTACK: +" +
				string(_val_magnitude) +
				" DAMAGE";

			_ref_new_status._spr_status = spr_status_buff_inner_flame;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = undefined;

			//------------------------//
			//TRACK TEMPORARY BONUS//
			//------------------------//
			_ref_new_status._flag_inner_flame_active = false;

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

		//==========//
		//ACTIVATE//
		//==========//
		case "ACTIVATE":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (_ref_status._flag_inner_flame_active){
				return false;
			}

			//======================//
			//GRANT TEMPORARY DAMAGE//
			//======================//
			_ref_host._val_dmg_linear_bonus +=
				_ref_status._val_status_magnitude;

			_ref_status._flag_inner_flame_active = true;

			//==========//
			//FEEDBACK//
			//==========//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"INNER FLAME +" +
					string(_ref_status._val_status_magnitude),
				undefined,
				c_red,
				_ref_host.x,
				_ref_host.y - 48
			);

			return true;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//========================//
			//REMOVE TEMPORARY DAMAGE//
			//========================//
			if (
				instance_exists(_ref_host) &&
				_ref_status._flag_inner_flame_active
			){

				_ref_host._val_dmg_linear_bonus = max(
					0,
					_ref_host._val_dmg_linear_bonus -
						_ref_status._val_status_magnitude
				);

				_ref_status._flag_inner_flame_active = false;
			}

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
