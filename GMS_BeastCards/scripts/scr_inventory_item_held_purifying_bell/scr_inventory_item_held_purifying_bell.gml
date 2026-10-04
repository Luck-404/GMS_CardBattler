//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_PURIFYING_BELL
// FUNCTION: Handles Purifying Bell Held Item behavior.
//
//           At the holder's Turn Start:
//           - Builds a pool of cleansable negative Statuses on the holder.
//           - Negative Statuses are DEBUFF, DOT, and CC.
//           - Selects one eligible Status at random.
//           - Cleanses exactly 1 stack from that Status through the authoritative
//             SCR_STATUS_CLEANSE stack-removal pipeline.
//
//           If the selected Status has only 1 stack, its normal DEATH cleanup
//           removes the entire Status.
//
//           Uncleansable Statuses are never selected.
//           The item remains equipped after triggering.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Purifying Bell Held Item struct.
//            _ref_target - Persistent Beast struct for EQUIP/UNEQUIP, or the
//                          live battle Beast holder for TRIGGER.
// RETURNS: True when at least 1 negative Status stack is cleansed, or for
//          successful EQUIP/UNEQUIP; otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_purifying_bell(_str_state,_stct_item,_ref_target){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":

			return is_struct(_ref_target);

		case "TRIGGER":

			//================//
			//VALIDATE HOLDER//
			//================//
			if (!instance_exists(_ref_target)){
				return false;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0
			){
				return false;
			}

			if (
				!ds_exists(
					_ref_target._list_statuses,
					ds_type_list
				)
			){
				return false;
			}

			//========================//
			//BUILD NEGATIVE CANDIDATES//
			//========================//
			var _arr_candidates = [];

			for (
				var _it_status = 0;
				_it_status <
					ds_list_size(
						_ref_target._list_statuses
					);
				_it_status++
			){

				var _ref_status =
					ds_list_find_value(
						_ref_target._list_statuses,
						_it_status
					);

				if (!instance_exists(_ref_status)){
					continue;
				}

				//----------------//
				//NEGATIVE TYPE//
				//----------------//
				var _flag_negative = (
					_ref_status._str_status_type == "DEBUFF" ||
					_ref_status._str_status_type == "DOT" ||
					_ref_status._str_status_type == "CC"
				);

				if (!_flag_negative){
					continue;
				}

				//----------------//
				//UNCLEANSABLE//
				//----------------//
				if (
					variable_instance_exists(
						_ref_status,
						"_flag_status_uncleansable"
					) &&
					_ref_status._flag_status_uncleansable
				){
					continue;
				}

				array_push(
					_arr_candidates,
					_ref_status
				);
			}

			if (
				array_length(
					_arr_candidates
				) <= 0
			){
				return false;
			}

			//================//
			//SELECT ONE//
			//================//
			var _ref_selected =
				_arr_candidates[
					irandom(
						array_length(
							_arr_candidates
						) - 1
					)
				];

			if (!instance_exists(_ref_selected)){
				return false;
			}

			var _str_status_name =
				_ref_selected._str_status_name;

			var _str_status_type =
				_ref_selected._str_status_type;

			//================//
			//CLEANSE 1 STACK//
			//================//
			var _stct_result =
				scr_status_cleanse(
					_ref_target,
					_str_status_type,
					1,
					{
						_str_mode : "STACKS",
						_str_status_id : _str_status_name
					}
				);

			if (!is_struct(_stct_result)){
				return false;
			}

			return (
				_stct_result._ct_stacks_removed >
				0
			);

		case "UNEQUIP":

			return is_struct(_ref_target);
	}

	#endregion

	return false;
}