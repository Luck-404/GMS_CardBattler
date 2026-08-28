//===============================================================================//
//
// SCRIPT: SCR_APPLY_EVENT_STATUS
// FUNCTION: Begins or refreshes a global Event.
//           Replaces an existing different Event before applying the new one.
//           Does not affect the active Weather.
//
//===============================================================================//

function scr_apply_event_status(_str_event_name,_val_lifetime=undefined){

	var _ref_status = undefined;

	//-------------------//
	//CHECK SAME EVENT//
	//-------------------//
	var _ref_existing_event = scr_check_for_status(
		"EVENT: " + _str_event_name,
		global.list_statuses
	);

	//-----------------------//
	//REPLACE DIFFERENT EVENT//
	//-----------------------//
	if (_ref_existing_event == -1){
		scr_clear_event();
	}

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