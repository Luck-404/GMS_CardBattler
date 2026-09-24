//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_EVENT
// FUNCTION: Applies a global Event Status.
//           Reapplying the same Event delegates its refresh/overwrite behavior
//           to that Event's Status script.
//           Applying a different Event removes all current Events first.
//           BLOODMIST stores the casting team's ownership for END timing.
//           Does not affect active Weather.
//
//           ACTIVE EVENTS:
//           - BLOODMIST
//           - BLOOD_MOON
//           - BLOOMTIDE
//
// ARGUMENTS: _str_event_name selects the Event.
//            _val_lifetime optionally overrides its duration.
//            _str_owner_team optionally identifies PLAYER or ENEMY ownership.
// RETURNS: Active Event Status, or undefined if the request is invalid.
//
//===============================================================================//

function scr_status_apply_event(_str_event_name,_val_lifetime=undefined,_str_owner_team=undefined){

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
		case "BLOOD_MOON":
		case "BLOOMTIDE":
		break;

		default:
			return undefined;
	}

	//===========================//
	//VALIDATE BLOODMIST OWNERSHIP//
	//===========================//
	if (
		_str_event_name == "BLOODMIST" &&
		_str_owner_team != "PLAYER" &&
		_str_owner_team != "ENEMY"
	){
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

			_ref_status = scr_status_event_bloodmist("APPLY",undefined,_val_lifetime,_str_owner_team);

		break;

		//============//
		//BLOOD_MOON//
		//============//
		case "BLOOD_MOON":

			_ref_status = scr_status_event_blood_moon("APPLY",undefined,_val_lifetime);

		break;

		//==========//
		//BLOOMTIDE//
		//==========//
		case "BLOOMTIDE":

			_ref_status = scr_status_event_bloomtide("APPLY",undefined,_val_lifetime);

		break;
	}

	//================//
	//EVENT FEEDBACK//
	//================//
	if (instance_exists(_ref_status)){

		var _c_event = c_green;

		if (
			_str_event_name == "BLOODMIST" ||
			_str_event_name == "BLOOD_MOON"
		){
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