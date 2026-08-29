//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_APEX_PREDATOR
// FUNCTION: Handles the permanent Apex Predator damage Buff.
//           Each stack grants +2 linear damage.
//           Infinite, stackable, and uncleansable for the remainder of battle.
//
//===============================================================================//
function scr_status_buff_apex_predator(_str_tag,_ref_status,_ct_stacks_added=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (_ct_stacks_added == undefined){
				_ct_stacks_added = 1;
			}

			_ct_stacks_added = max(0,_ct_stacks_added);

			if (_ct_stacks_added <= 0){
				return undefined;
			}

			var _val_damage_per_stack = 2;

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status(
				"APEX_PREDATOR",
				_ref_target
			);

			//----------------//
			//STACK EXISTING//
			//----------------//
			if (_ref_existing_status != -1){

				_ref_existing_status._ct_status_stacks +=
					_ct_stacks_added;

				var _val_damage_added =
					_ct_stacks_added *
					_val_damage_per_stack;

				_ref_target._val_dmg_linear_bonus +=
					_val_damage_added;

				var _val_total_damage =
					_ref_existing_status._ct_status_stacks *
					_val_damage_per_stack;

				_ref_existing_status._str_status_desc =
					"+" +
					string(_val_total_damage) +
					" LINEAR DAMAGE | +2 PER STACK";

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//---------------------//
			//INFINITE + STACKABLE//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				true,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status =
				scr_status_buff_apex_predator;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"APEX_PREDATOR";

			_ref_new_status._ct_status_stacks =
				_ct_stacks_added;

			_ref_new_status._val_status_magnitude =
				_val_damage_per_stack;

			_ref_new_status._str_status_desc =
				"+" +
				string(
					_ct_stacks_added *
					_val_damage_per_stack
				) +
				" LINEAR DAMAGE | +2 PER STACK";

			/*
				Create a dedicated icon:
				spr_status_buff_apex_predator
			*/
			_ref_new_status._spr_status =
				spr_status_buff_apex_predator;

			_ref_new_status._str_trigger_region =
				undefined;

			//----------------//
			//UNCLEANSABLE//
			//----------------//
			_ref_new_status._flag_status_uncleansable =
				true;

			//--------------------//
			//GRANT DAMAGE BONUS//
			//--------------------//
			_ref_target._val_dmg_linear_bonus +=
				_ct_stacks_added *
				_val_damage_per_stack;

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


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			/*
				This normally only happens when the Beast/status
				is being removed from battle. The Buff itself
				cannot expire or be cleansed.
			*/
			if (instance_exists(_ref_host)){

				var _val_total_bonus =
					_ref_status._ct_status_stacks *
					_ref_status._val_status_magnitude;

				_ref_host._val_dmg_linear_bonus =
					max(
						0,
						_ref_host._val_dmg_linear_bonus -
						_val_total_bonus
					);
			}

			scr_destroy_status(_ref_status);

		break;
	}

	return undefined;
}