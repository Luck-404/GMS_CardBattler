//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ARMOR_OVER_TIME
// FUNCTION: Handles the generic Armor Over Time buff.
//           Stores configurable Armor magnitude and lifetime on the status.
//           Grants stored Armor at the end of each turn until expiration.
//
//===============================================================================//

function scr_status_buff_armor_over_time(_str_tag,_ref_status,_val_magnitude,_val_lifetime){

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

			//----------------//
			//VALIDATE VALUES//
			//----------------//
			if (_val_magnitude == undefined){
				_val_magnitude = 0;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 1;
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
					"ARMOR_OVER_TIME",
					_ref_target
				);

			//-------------------//
			//REFRESH / REPLACE//
			//-------------------//
			if (_ref_existing_status != -1){

				_ref_existing_status._val_status_magnitude =
					_val_magnitude;

				_ref_existing_status._val_status_lifetime =
					_val_lifetime;

				_ref_existing_status._str_status_desc =
					"+" +
					string(_val_magnitude) +
					" ARMOR AT TURN END";

				return _ref_existing_status;
			}

			//----------------//
			//CREATE STATUS//
			//----------------//
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
				scr_status_buff_armor_over_time;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"ARMOR_OVER_TIME";

			_ref_new_status._str_status_desc =
				"+" +
				string(_val_magnitude) +
				" ARMOR AT TURN END";

			_ref_new_status._spr_status =
				spr_status_buff_armor_over_time;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_trigger_region =
				"END";

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

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(
					_ref_status
				);

				return undefined;
			}

			//-------------//
			//GRANT ARMOR//
			//-------------//
			scr_armor_target(
				_ref_status._val_status_magnitude,
				_ref_host
			);

			//----------------//
			//REDUCE LIFETIME//
			//----------------//
			_ref_status._val_status_lifetime--;

			if (
				_ref_status._val_status_lifetime <= 0
			){

				_ref_status._str_status_command =
					"DEATH";
			}
			else{

				_ref_status._str_status_command =
					"WAIT";
			}

			scr_reposition_statuses(
				_ref_host
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}