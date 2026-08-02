//===============================================================================//
//
// SCR_STATUS_BUFF_OVERHEALTH
// FUNCTION: Handles the Overhealth buff status.
//           Applies or stacks overhealth on the target beast.
//           Regenerates overhealth while active and clears it on death.
//
//===============================================================================//
function scr_status_buff_overhealth(_str_tag,_ref_status){

	switch(_str_tag){

		case "APPLY":

			var _ref_target = global.ref_target_beast;

			var _ref_existing_status = scr_check_for_status("OVERHEALTH",_ref_target);

			if (_ref_existing_status != -1){
				_ref_existing_status._val_status_lifetime = 4;
				_ref_existing_status._ct_status_stacks++;
				_ref_target._val_overhealth += 5;
				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(_ref_target.x,_ref_target.y,"ily_status",obj_battle_status);

			_ref_new_status._val_status_lifetime = 4;
			_ref_new_status._scr_status = scr_status_buff_overhealth;
			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._str_status_name = "OVERHEALTH";
			_ref_new_status._str_status_desc = "+5 OVERHP PER STACK";
			_ref_new_status._spr_status = spr_status_buff_overhealth;
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._str_trigger_region = "START";
			_ref_new_status._str_status_type = "NUFF"

			_ref_target._val_overhealth += 5;

			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_reposition_statuses(_ref_target);

		break;

		case "REPEAT":

			var _ref_host = _ref_status._ref_host;

			_ref_host._val_overhealth += _ref_status._ct_status_stacks;

			if (_ref_host._val_overhealth > _ref_status._ct_status_stacks * 5){
				_ref_host._val_overhealth = _ref_status._ct_status_stacks * 5;
			}

			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){
				_ref_status._str_status_command = "DEATH";
			}
			else{
				_ref_status._str_status_command = "WAIT";
			}

			scr_reposition_statuses(_ref_host);

		break;

		case "DEATH":

			_ref_status._ref_host._val_overhealth = 0;
			scr_destroy_status(_ref_status);

		break;
	}
}