//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_EVENT
// FUNCTION: Applies or refreshes a global Event Status.
//           Reapplying the same Event refreshes its lifetime.
//           Applying a different Event removes all current Events first.
//           Does not affect active Weather.
//
//           ACTIVE EVENTS:
//           - BLOODMIST
//           - BLOOMTIDE
//
// ARGUMENTS: _str_event_name is the Event ID to apply.
//            _val_lifetime optionally overrides its default duration.
// RETURNS: Applied Event Status, or undefined if application fails.
//
//===============================================================================//

function scr_status_apply_event(_str_event_name,_val_lifetime=undefined){

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!ds_exists(global.list_statuses,ds_type_list)){
		return undefined;
	}

	//========================//
	//VALIDATE REQUESTED EVENT//
	//========================//
	switch (_str_event_name){

		case "BLOODMIST":
		case "BLOOMTIDE":
		break;

		default:
			return undefined;
	}

	var _ref_status = undefined;
	var _str_requested_event = "EVENT: " + _str_event_name;

	//=====================//
	//CHECK CURRENT EVENT//
	//=====================//
	var _flag_same_event_active = false;

	for (var _it_status = 0;_it_status < ds_list_size(global.list_statuses);_it_status++){

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

	//=========================//
	//REPLACE DIFFERENT EVENT//
	//=========================//
	if (!_flag_same_event_active){
		scr_status_clear_event();
	}

	//================//
	//APPLY EVENT//
	//================//
	switch (_str_event_name){

		//==========//
		//BLOODMIST//
		//==========//
		case "BLOODMIST":

			_ref_status = scr_status_event_bloodmist(
				"APPLY",
				undefined,
				_val_lifetime
			);

		break;

		//==========//
		//BLOOMTIDE//
		//==========//
		case "BLOOMTIDE":

			_ref_status = scr_status_event_bloomtide(
				"APPLY",
				undefined,
				_val_lifetime
			);

		break;
	}

	//================//
	//EVENT FEEDBACK//
	//================//
	if (instance_exists(_ref_status)){

		var _c_event = c_green;

		if (_str_event_name == "BLOODMIST"){
			_c_event = c_red;
		}

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			_str_requested_event,
			undefined,
			_c_event,
			room_width * 0.5,
			room_height * 0.5
		);
	}

	return _ref_status;
}