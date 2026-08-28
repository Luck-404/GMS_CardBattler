//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_NATURES_BOND
// FUNCTION: Handles the Nature's Bond Buff.
//           Stackable Timed.
//           Whenever the host receives healing, grants 2 Armor per stack.
//           Reapplication adds one stack and refreshes duration.
//
//===============================================================================//
function scr_status_buff_natures_bond(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target =
				global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//------------------//
			//DEFAULT MAGNITUDE//
			//------------------//
			if (_val_magnitude == undefined){
				_val_magnitude = 2;
			}

			//----------------//
			//DEFAULT LENGTH//
			//----------------//
			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			_val_magnitude =
				max(0,_val_magnitude);

			_val_lifetime =
				max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"NATURES_BOND",
					_ref_target
				);

			//----------------//
			//STACK EXISTING//
			//----------------//
			if (_ref_existing_status != -1){

				_ref_existing_status._ct_status_stacks++;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			_ref_new_status._scr_status =
				scr_status_buff_natures_bond;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"NATURES_BOND";

			_ref_new_status._str_status_desc =
				"WHEN HEALED, GAIN 2 ARMOR PER STACK";

			_ref_new_status._spr_status =
				spr_status_buff_natures_bond;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_buff_trigger =
				"HEALED";

			_ref_new_status._str_trigger_region =
				"END";

			//-------------------//
			//INITIALIZE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(_ref_target);

			return _ref_new_status;

		break;


		//---------//
		//TRIGGER//
		//---------//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			//----------------//
			//CALCULATE ARMOR//
			//----------------//
			var _val_armor_gain =
				_ref_status._val_status_magnitude *
				_ref_status._ct_status_stacks;

			if (_val_armor_gain <= 0){
				return false;
			}

			//-------------//
			//GRANT ARMOR//
			//-------------//
			scr_armor_target(
				_val_armor_gain,
				_ref_host
			);

			return true;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				_ref_status._str_status_command =
					"DEATH";

				return undefined;
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			scr_reposition_statuses(_ref_host);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_destroy_status(_ref_status);
			}

		break;
	}

	return undefined;
}