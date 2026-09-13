//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ECHO
// FUNCTION: Handles Echo.
//           Stackable Infinite Global Buff.
//           Each stack causes the next eligible card to repeat one additional
//           time.
//           All accumulated Echo stacks are consumed when triggered.
//
//===============================================================================//

function scr_status_buff_echo(_str_tag,_ref_status,_ct_stacks_added=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//----------------//
			//VALIDATE LIST//
			//----------------//
			if (!variable_global_exists("list_statuses")){
				return undefined;
			}

			if (!ds_exists(global.list_statuses,ds_type_list)){
				return undefined;
			}

			//----------//
			//DEFAULTS//
			//----------//
			if (_ct_stacks_added == undefined){
				_ct_stacks_added = 1;
			}

			_ct_stacks_added = max(1,_ct_stacks_added);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("ECHO",global.list_statuses);

			//----------------//
			//ADD TO EXISTING//
			//----------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks += _ct_stacks_added;

				scr_status_reposition(global.list_statuses);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			//-------------------//
			//INFINITE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_echo;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "ECHO";
			_ref_new_status._str_status_desc = "THE NEXT ELIGIBLE CARD REPEATS ONCE PER ECHO STACK";

			_ref_new_status._spr_status = spr_status_buff_echo;

			_ref_new_status._ct_status_stacks = _ct_stacks_added;

			_ref_new_status._flag_status_stackable = true;
			_ref_new_status._flag_status_uncleansable = true;

			_ref_new_status._str_trigger_region = undefined;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			scr_status_reposition(global.list_statuses);

			return _ref_new_status;

		break;

		//=========//
		//CONSUME//
		//=========//
		case "CONSUME":

			if (!instance_exists(_ref_status)){
				return false;
			}

			if (_ref_status._ct_status_stacks <= 0){
				return false;
			}

			/*
				The next eligible card uses every accumulated
				Echo stack, then consumes the entire resource.
			*/
			scr_status_buff_echo(
				"DEATH",
				_ref_status
			);

			return true;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}