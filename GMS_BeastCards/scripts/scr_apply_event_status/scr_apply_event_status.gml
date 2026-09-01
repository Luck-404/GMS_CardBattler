//===============================================================================//
//
// SCRIPT: SCR_APPLY_EVENT_STATUS
// FUNCTION: Applies or refreshes a global Event status.
//           Reapplying the same Event refreshes its lifetime.
//           Applying a different Event removes all current Events first.
//           Does not affect the active Weather.
//
//===============================================================================//

function scr_apply_event_status(_str_event_name,_val_lifetime=undefined){

	var _ref_status = undefined;

	//--------------------//
	//GET REQUESTED EVENT//
	//--------------------//
	var _str_requested_event =
		"EVENT: " + _str_event_name;

	//-------------------//
	//CHECK CURRENT EVENT//
	//-------------------//
	var _flag_same_event_active = false;

	for (var _it_status = 0; _it_status < ds_list_size(global.list_statuses); _it_status++){

		var _ref_check_status = ds_list_find_value(global.list_statuses,_it_status);

		if (!instance_exists(_ref_check_status)){
			continue;
		}

		if (_ref_check_status._str_status_type != "EVENT"){
			continue;
		}

		if (_ref_check_status._str_status_name == _str_requested_event){

			_flag_same_event_active = true;
			break;
		}
	}

	//-----------------------//
	//REPLACE DIFFERENT EVENT//
	//-----------------------//
	if (!_flag_same_event_active){
		scr_clear_event();
	}

	//-----------//
	//APPLY EVENT//
	//-----------//
	switch(_str_event_name){

		//----------//
		//BLOOMTIDE//
		//----------//
		case "BLOOMTIDE":

			_ref_status = scr_status_event_bloomtide("APPLY",undefined,_val_lifetime);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"EVENT: BLOOMTIDE",
					undefined,
					c_green,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;
	}

	return _ref_status;
}