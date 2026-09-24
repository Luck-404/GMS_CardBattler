
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_SECOND_WIND
// FUNCTION: Stackable Infinite Buff lasting until the host's next Attack.
//           Each application adds 1 stack.
//           Each stack grants 50% additional direct Attack damage by default.
//           Reapplication preserves the original per-stack magnitude.
//           All stacks apply to the same Attack and are consumed together
//           after that Attack's Card effect finishes resolving.
//
// ARGUMENTS: _str_tag selects APPLY/ACTIVATE/CONSUME/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_magnitude=undefined is the bonus percentage per stack
//            when the Status is first created.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference, trigger result, or undefined.
//
//===============================================================================//

function scr_status_buff_second_wind(_str_tag,_ref_status,_val_magnitude=undefined,_ref_target=undefined){

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
				_val_magnitude = 50;
			}

			_val_magnitude = max(0,_val_magnitude);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"SECOND_WIND",
				_ref_target
			);

			//================//
			//STACK EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//================//
				//ADD 1 STACK//
				//================//
				_ref_existing_status._ct_status_stacks++;

				//============================//
				//PRESERVE PER-STACK MAGNITUDE//
				//============================//
				// Do not replace _val_status_magnitude.
				// Each stack contributes the original bonus.

				var _val_total_bonus =
					_ref_existing_status._val_status_magnitude *
					_ref_existing_status._ct_status_stacks;

				_ref_existing_status._str_status_desc =
					"NEXT ATTACK: +" +
					string(_val_total_bonus) +
					"% DIRECT DAMAGE (" +
					string(_ref_existing_status._val_status_magnitude) +
					"% PER STACK)";

				scr_status_reposition(_ref_target);

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
				true,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_second_wind;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "SECOND_WIND";

			_ref_new_status._str_status_desc =
				"NEXT ATTACK: +" +
				string(_val_magnitude) +
				"% DIRECT DAMAGE (" +
				string(_val_magnitude) +
				"% PER STACK)";

			_ref_new_status._spr_status = spr_status_buff_second_wind;

			//================//
			//STACK DATA//
			//================//
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;

			// Stored as the bonus PER STACK.
			_ref_new_status._val_status_magnitude = _val_magnitude;

			//--------------------//
			//ATTACK STATE//
			//--------------------//
			_ref_new_status._flag_second_wind_active = false;

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

		//==========//
		//ACTIVATE//
		//==========//
		case "ACTIVATE":

			if (!instance_exists(_ref_status)){
				return false;
			}

			if (!instance_exists(_ref_status._ref_host)){
				return false;
			}

			if (_ref_status._ct_status_stacks <= 0){
				return false;
			}

			//================//
			//ACTIVATE ALL STACKS//
			//================//
			_ref_status._flag_second_wind_active = true;

			return true;

		break;

		//=========//
		//CONSUME//
		//=========//
		case "CONSUME":

			//-----------------//
			//VALIDATE STATUS//
			//-----------------//
			if (!instance_exists(_ref_status)){
				return false;
			}

			//================//
			//VALIDATE HOST//
			//================//
			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (!ds_exists(_ref_host._list_statuses,ds_type_list)){
				return false;
			}

			//=========================//
			//CHECK STATUS REGISTERED//
			//=========================//
			if (
				ds_list_find_index(
					_ref_host._list_statuses,
					_ref_status
				) == -1
			){
				return false;
			}

			//================//
			//CONSUME ALL STACKS//
			//================//
			// The entire bonus belongs to the next Attack.
			// Do not decrement one stack at a time.

			scr_status_buff_second_wind(
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