//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_WEAKNESS
// FUNCTION: Handles the Weakness debuff status.
//           Each stack reduces the host's outgoing linear damage by 2.
//           Refreshes duration when stacked and restores the modifier on death.
//
//===============================================================================//

function scr_status_debuff_weakness(_str_tag,_ref_status){

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

			//--------------------------------//
			//STACK EXISTING WEAKNESS STATUS//
			//--------------------------------//
			var _ref_existing_status = scr_check_for_status(
				"WEAKNESS",
				_ref_target
			);

			if (_ref_existing_status != -1){

				_ref_existing_status._val_status_lifetime =
					3;

				_ref_existing_status._ct_status_stacks++;

				_ref_target._val_dmg_linear_reduction +=
					_ref_existing_status._val_status_magnitude;

				return _ref_existing_status;
			}

			//----------------------------//
			//CREATE NEW WEAKNESS STATUS//
			//----------------------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			_ref_new_status._val_status_lifetime =
				3;

			_ref_new_status._scr_status =
				scr_status_debuff_weakness;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"DEBUFF";

			_ref_new_status._str_status_name =
				"WEAKNESS";

			_ref_new_status._str_status_desc =
				"-2 OUTGOING DAMAGE PER STACK";

			_ref_new_status._spr_status =
				spr_status_debuff_weakness;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				2;

			_ref_new_status._str_trigger_region =
				"END";

			//--------------------------------//
			//APPLY LINEAR DAMAGE REDUCTION//
			//--------------------------------//
			_ref_target._val_dmg_linear_reduction +=
				_ref_new_status._val_status_magnitude;

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

			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){

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

			var _ref_host =
				_ref_status._ref_host;

			if (instance_exists(_ref_host)){

				var _val_total_reduction =
					_ref_status._val_status_magnitude *
					_ref_status._ct_status_stacks;

				_ref_host._val_dmg_linear_reduction = max(
					0,
					_ref_host._val_dmg_linear_reduction -
					_val_total_reduction
				);
			}

			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}