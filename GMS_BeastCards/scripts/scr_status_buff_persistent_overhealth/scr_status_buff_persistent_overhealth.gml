//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_PERSISTENT_OVERHEALTH
// FUNCTION: Handles non-expiring, non-regenerating Persistent Overhealth.
//           Reapplication adds additional Persistent Overhealth to the same
//           Status instance.
//           Uses the Beast's normal _val_overhealth defensive pool.
//           Can coexist with temporary OVERHEALTH.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_magnitude is the amount of Persistent Overhealth added.
//            _val_lifetime is unused because this Status is infinite.
//            _ref_target is the explicit host on APPLY.
// RETURNS: Applied/existing Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_buff_persistent_overhealth(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//-----------------//
			//VALIDATE TARGET//
			//-----------------//
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

			_val_magnitude = max(0,_val_magnitude);

			if (_val_magnitude <= 0){
				return undefined;
			}

			//======================//
			//SYNC EXISTING OWNERSHIP//
			//======================//
			scr_status_sync_overhealth_ownership(
				_ref_target
			);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"PERSISTENT_OVERHEALTH",
				_ref_target
			);

			//====================//
			//ADD TO EXISTING POOL//
			//====================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				_ref_target._val_overhealth +=
					_val_magnitude;

				_ref_existing_status._val_status_remaining +=
					_val_magnitude;

				scr_status_reposition(
					_ref_target
				);

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
			_ref_new_status._scr_status =
				scr_status_buff_persistent_overhealth;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"PERSISTENT_OVERHEALTH";

			_ref_new_status._str_status_desc =
				"NON-EXPIRING OVERHEALTH. DOES NOT REGENERATE. REMAINS UNTIL CONSUMED BY DAMAGE.";

			_ref_new_status._spr_status =
				spr_status_buff_persistent_overhealth;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._flag_status_uncleansable = false;

			_ref_new_status._val_status_magnitude = 0;
			_ref_new_status._val_status_remaining =
				_val_magnitude;

			_ref_new_status._str_trigger_region =
				undefined;

			//================//
			//GRANT OVERHEALTH//
			//================//
			_ref_target._val_overhealth +=
				_val_magnitude;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(
				_ref_target
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

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_status_destroy(
					_ref_status
				);

				return undefined;
			}

			//================//
			//SYNC OWNERSHIP//
			//================//
			scr_status_sync_overhealth_ownership(
				_ref_host
			);

			scr_status_reposition(
				_ref_host
			);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//================//
				//SYNC OWNERSHIP//
				//================//
				scr_status_sync_overhealth_ownership(
					_ref_host
				);

				//==========================//
				//REMOVE OWNED OVERHEALTH//
				//==========================//
				var _val_owned_overhealth = max(
					0,
					_ref_status._val_status_remaining
				);

				_ref_host._val_overhealth =
					max(
						0,
						_ref_host._val_overhealth -
						_val_owned_overhealth
					);

				_ref_status._val_status_remaining = 0;

				scr_status_sync_overhealth_ownership(
					_ref_host
				);
			}

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(
				_ref_status
			);

		break;
	}

	return undefined;
}