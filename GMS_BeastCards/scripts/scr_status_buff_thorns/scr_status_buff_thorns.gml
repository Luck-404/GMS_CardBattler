//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_THORNS
// FUNCTION: Handles the Thorns buff status.
//           Stores neutral retaliation damage.
//           Supports permanent or temporary Thorns durations.
//
//===============================================================================//

function scr_status_buff_thorns(_str_tag,_ref_status,_val_magnitude,_val_lifetime){

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

			if (_val_magnitude == undefined){
				_val_magnitude = 3;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = -1;
			}

			_val_magnitude =
				max(0,_val_magnitude);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"THORNS",
					_ref_target
				);

			if (_ref_existing_status != -1){

				//----------------//
				//UPDATE DAMAGE//
				//----------------//
				_ref_existing_status._val_status_magnitude =
					max(
						_ref_existing_status._val_status_magnitude,
						_val_magnitude
					);

				//----------------//
				//UPDATE LIFETIME//
				//----------------//
				if (
					_ref_existing_status._val_status_lifetime == -1 ||
					_val_lifetime == -1
				){
					_ref_existing_status._val_status_lifetime = -1;
					_ref_existing_status._str_trigger_region = undefined;
				}
				else{
					_ref_existing_status._val_status_lifetime =
						max(
							_ref_existing_status._val_status_lifetime,
							_val_lifetime
						);

					_ref_existing_status._str_trigger_region = "END";
				}

				_ref_existing_status._str_status_desc =
					"MELEE ATTACKERS TAKE " +
					string(_ref_existing_status._val_status_magnitude) +
					" NEUTRAL DAMAGE";

				return _ref_existing_status;
			}

			//---------------//
			//CREATE THORNS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			_ref_new_status._val_status_lifetime =
				_val_lifetime;

			_ref_new_status._scr_status =
				scr_status_buff_thorns;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"THORNS";

			_ref_new_status._str_status_desc =
				"MELEE ATTACKERS TAKE " +
				string(_val_magnitude) +
				" NEUTRAL DAMAGE";

			_ref_new_status._spr_status =
				spr_status_buff_thorns;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			// PERMANENT THORNS DOES NOT TICK
			if (_val_lifetime == -1){
				_ref_new_status._str_trigger_region =
					undefined;
			}
			else{
				_ref_new_status._str_trigger_region =
					"END";
			}

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			if (_ref_status._val_status_lifetime == -1){
				_ref_status._str_status_command = "WAIT";
				return _ref_status;
			}

			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){
				_ref_status._str_status_command = "DEATH";
			}
			else{
				_ref_status._str_status_command = "WAIT";
			}

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