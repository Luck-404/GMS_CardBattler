//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_EVENT
// FUNCTION: Applies or refreshes the single active Event Status.
//           Event is owned by GLOBAL.REF_STATUS_EVENT rather than the legacy
//           Global Status list. Reapplying the same Event refreshes/overwrites
//           through the Event implementation; applying a different Event first
//           clears the active Event through its normal DEATH path.
//
//           BLOODMIST requires an owner team because its END trigger belongs to
//           the team that created the Event. When no owner is supplied, this
//           script attempts to infer it from GLOBAL.REF_CASTER_BEAST.
//
// ACTIVE EVENTS:
// - BLOOD_MOON
// - BLOODMIST
// - BLOOMTIDE
//
// ARGUMENTS: _str_event_name - Event ID to apply.
//            _val_lifetime - Optional lifetime override.
//            _str_owner_team - Optional PLAYER/ENEMY owner; required by BLOODMIST.
// RETURNS: Applied Event Status, or undefined on failure.
//
//===============================================================================//

function scr_status_apply_event(_str_event_name,_val_lifetime=undefined,_str_owner_team=undefined){

	#region VALIDATION

	//================//
	//NORMALIZE NAME//
	//================//
	_str_event_name =
		string_upper(
			string(
				_str_event_name
			)
		);

	if (string_pos("EVENT: ",_str_event_name) == 1){
		_str_event_name =
			string_delete(
				_str_event_name,
				1,
				string_length("EVENT: ")
			);
	}

	//========================//
	//VALIDATE REQUESTED EVENT//
	//========================//
	switch (_str_event_name){

		case "BLOOD_MOON":
		case "BLOODMIST":
		case "BLOOMTIDE":
		break;

		default:
			return undefined;
	}

	if (!variable_global_exists("ref_status_event")){
		global.ref_status_event = undefined;
	}

	#endregion

	#region OWNER

	if (_str_owner_team != undefined){
		_str_owner_team =
			string_upper(
				string(
					_str_owner_team
				)
			);
	}

	//------------------------//
	//INFER BLOODMIST OWNER//
	//------------------------//
	if (
		_str_event_name == "BLOODMIST" &&
		_str_owner_team != "PLAYER" &&
		_str_owner_team != "ENEMY"
	){

		if (
			variable_global_exists("ref_caster_beast") &&
			instance_exists(global.ref_caster_beast) &&
			variable_instance_exists(
				global.ref_caster_beast,
				"_str_team"
			)
		){
			_str_owner_team =
				string_upper(
					string(
						global.ref_caster_beast._str_team
					)
				);
		}
	}

	if (
		_str_event_name == "BLOODMIST" &&
		_str_owner_team != "PLAYER" &&
		_str_owner_team != "ENEMY"
	){
		return undefined;
	}

	#endregion

	#region CURRENT EVENT

	var _ref_status = undefined;
	var _str_requested_event = "EVENT: " + _str_event_name;

	var _flag_same_event_active =
		instance_exists(global.ref_status_event) &&
		global.ref_status_event._str_status_name ==
			_str_requested_event;

	if (
		instance_exists(global.ref_status_event) &&
		!_flag_same_event_active
	){
		scr_status_clear_event();
	}

	#endregion

	#region APPLY EVENT

	switch (_str_event_name){

		case "BLOOD_MOON":
			_ref_status =
				scr_status_event_blood_moon(
					"APPLY",
					undefined,
					_val_lifetime
				);
		break;

		case "BLOODMIST":
			_ref_status =
				scr_status_event_bloodmist(
					"APPLY",
					undefined,
					_val_lifetime,
					_str_owner_team
				);
		break;

		case "BLOOMTIDE":
			_ref_status =
				scr_status_event_bloomtide(
					"APPLY",
					undefined,
					_val_lifetime
				);
		break;
	}

	#endregion

	#region FEEDBACK

	if (instance_exists(_ref_status)){

		var _c_popup = c_red;

		if (_str_event_name == "BLOOMTIDE"){
			_c_popup = c_green;
		}

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			_str_requested_event,
			undefined,
			_c_popup,
			room_width * 0.5,
			room_height * 0.5
		);
	}

	#endregion

	#region DEBUG

	if (instance_exists(_ref_status)){

		var _str_lifetime = "INFINITE";

		if (!_ref_status._flag_status_infinite){
			_str_lifetime =
				string(
					_ref_status._val_status_lifetime
				);
		}

		var _str_owner_text = "";

		if (
			variable_instance_exists(
				_ref_status,
				"_str_event_owner_team"
			)
		){
			_str_owner_text =
				" | OWNER: " +
				string_upper(
					string(
						_ref_status._str_event_owner_team
					)
				);
		}

		scr_debug_log(
			"BATTLE",
			"EVENT",
			_ref_status,
			(_flag_same_event_active ? "EVENT REFRESHED: " : "EVENT STARTED: ") +
			_str_event_name +
			" | LIFETIME: " +
			_str_lifetime +
			_str_owner_text,
			"BATTLE",
			"SCR_STATUS_APPLY_EVENT"
		);
	}

	#endregion

	return _ref_status;
}
