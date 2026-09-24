//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_OVERHEALTH
// FUNCTION: Handles rechargeable temporary Overhealth.
//           Stackable Timed Buff.
//           Each stack grants one stored Magnitude of Overhealth.
//           Reapplication adds one stack and refreshes duration.
//           Regenerates up to one stack worth whenever its lifetime ticks.
//           Removes remaining Status-owned Overhealth on expiration.
//           Temporary Overhealth is consumed before Persistent Overhealth.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_magnitude is Overhealth granted per stack.
//            _val_lifetime is the temporary lifetime.
//            _ref_target is the explicit host on APPLY.
// RETURNS: Applied/existing Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_buff_overhealth(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

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

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//================//
			//SYNC OWNERSHIP//
			//================//
			scr_status_sync_overhealth_ownership(
				_ref_target
			);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"OVERHEALTH",
				_ref_target
			);

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				/*
					Existing temporary Overhealth owns one common
					per-stack Magnitude.

					New stacks use that stored Magnitude.
				*/
				var _val_stack_amount =
					_ref_existing_status._val_status_magnitude;

				_ref_target._val_overhealth +=
					_val_stack_amount;

				_ref_existing_status._val_status_remaining +=
					_val_stack_amount;

				_ref_existing_status._ct_status_stacks++;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
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

			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				true,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status =
				scr_status_buff_overhealth;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"OVERHEALTH";

			_ref_new_status._str_status_desc =
				"RECHARGEABLE TEMPORARY OVERHEALTH";

			_ref_new_status._spr_status =
				spr_status_buff_overhealth;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = true;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._val_status_remaining =
				_val_magnitude;

			_ref_new_status._str_trigger_region =
				"START";

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

			//========================//
			//CALCULATE MAX OVERHEALTH//
			//========================//
			var _val_overhealth_max =
				_ref_status._val_status_magnitude *
				_ref_status._ct_status_stacks;

			//============================//
			//CALCULATE MISSING OVERHEALTH//
			//============================//
			var _val_overhealth_missing = max(
				0,
				_val_overhealth_max -
				_ref_status._val_status_remaining
			);

			//=======================//
			//REGENERATE ONE STACK//
			//=======================//
			var _val_regenerated = min(
				_ref_status._val_status_magnitude,
				_val_overhealth_missing
			);

			if (_val_regenerated > 0){

				_ref_host._val_overhealth +=
					_val_regenerated;

				_ref_status._val_status_remaining +=
					_val_regenerated;

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"+" + string(_val_regenerated) + " OVERHEALTH",
					undefined,
					c_green,
					_ref_host.x,
					_ref_host.y - 48
				);
			}

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(
				_ref_status
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