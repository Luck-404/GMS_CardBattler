//===============================================================================//
//
// SCR_STATUS_DEBUFF_WEAKNESS
// FUNCTION: Handles the Weakness debuff status.
//           Applies or stacks Weakness on the target beast.
//           Reduces lifetime at turn end and removes itself on death.
//
//===============================================================================//
function scr_status_debuff_weakness(_str_tag,_ref_status){

	switch(_str_tag){

		case "APPLY":

			var _ref_target = global.ref_target_beast;

			var _ref_existing_status = scr_check_for_status("WEAKNESS",_ref_target);

			if (_ref_existing_status != -1){
				_ref_existing_status._val_status_lifetime = 3;
				_ref_existing_status._ct_status_stacks++;
				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(_ref_target.x,_ref_target.y,"ily_status",obj_battle_status);

			_ref_new_status._val_status_lifetime = 3;
			_ref_new_status._scr_status = scr_status_debuff_weakness;
			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._str_status_name = "WEAKNESS";
			_ref_new_status._str_status_desc = "-2 DAMAGE PER STACK";
			_ref_new_status._spr_status = spr_status_debuff_weakness;
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._str_trigger_region = "END";

			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_reposition_statuses(_ref_target);

		break;

		case "REPEAT":

			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){
				_ref_status._str_status_command = "DEATH";
			}
			else{
				_ref_status._str_status_command = "WAIT";
			}

			scr_reposition_statuses(_ref_status._ref_host);

		break;

		case "DEATH":

			scr_destroy_status(_ref_status);

		break;
	}
}