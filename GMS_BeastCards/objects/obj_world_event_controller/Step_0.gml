//===============================================================================//
//
// STEP: OBJ_WORLD_EVENT_CONTROLLER
// FUNCTION: Observes room changes, validates room spawn points, flushes pending
//           World Event banners, activates announced events on target-room entry,
//           and advances travel/active/completion timers only during active
//           overworld gameplay.
//
//===============================================================================//

//================//
//REPAIR GLOBAL REF//
//================//
if (
	!variable_global_exists(
		"ref_world_event_controller"
	) ||
	global.ref_world_event_controller !=
	id
){
	global.ref_world_event_controller =
		id;
}

//================//
//VALIDATE EVENT STATE//
//================//
if (!is_struct(_stct_active_world_event)){

	_stct_active_world_event =
		scr_world_event_create_empty();
}

//================//
//WORLD EVENT HUD TOGGLE//
//================//
var _flag_world_event_gui_input_blocked =
	variable_global_exists("ref_active_gui") &&
	instance_exists(global.ref_active_gui);

if (
	room != rm_battle &&
	!_flag_world_event_gui_input_blocked &&
	keyboard_check_pressed(ord("J"))
){
	_flag_world_event_gui_visible =
		!_flag_world_event_gui_visible;

	audio_play_sound(snd_gui_press,0,false);

	scr_debug_log(
		"WORLD_EVENT",
		"GUI",
		self,
		"WORLD EVENT HUD " +
		(_flag_world_event_gui_visible ? "SHOWN" : "HIDDEN") +
		" | SOURCE: HOTKEY J",
		"INFO",
		"OBJ_WORLD_EVENT_CONTROLLER:STEP"
	);
}

//================//
//ROOM CHANGE//
//================//
if (_rm_observed_room != room){

	_rm_previous_room =
		_rm_observed_room;

	_rm_observed_room =
		room;

	_ct_room_revision++;

	_flag_room_validation_pending =
		true;

	// Event-owned room instances are room-local. Leaving or entering any room
	// invalidates the live-instance latch; persistent event data remains intact.
	if (is_struct(_stct_active_world_event)){
		_stct_active_world_event._flag_room_initialized = false;
	}

	scr_debug_log(
		"WORLD_EVENT",
		"ROOM",
		self,
		"WORLD EVENT CONTROLLER ROOM CHANGE" +
		" | FROM: " +
		(
			_rm_previous_room == undefined
			? "UNDEFINED"
			: string_upper(
				room_get_name(
					_rm_previous_room
				)
			)
		) +
		" | TO: " +
		string_upper(
			room_get_name(
				_rm_observed_room
			)
		) +
		" | REVISION: " +
		string(
			_ct_room_revision
		),
		"INFO",
		"OBJ_WORLD_EVENT_CONTROLLER:STEP"
	);
}

//========================//
//VALIDATE ROOM ANCHORS//
//========================//
if (_flag_room_validation_pending){

	_flag_room_validation_pending =
		false;

	if (room != rm_battle){

		_stct_last_spawn_validation =
			scr_world_event_validate_spawn_points(
				room
			);

		scr_debug_log(
			"WORLD_EVENT",
			"SPAWN_POINT",
			self,
			"WORLD EVENT SPAWN VALIDATION" +
			" | ROOM: " +
			string_upper(
				room_get_name(
					room
				)
			) +
			" | ELIGIBLE: " +
			(
				scr_world_event_is_room_eligible(
					room
				)
				? "YES"
				: "NO"
			) +
			" | TOTAL: " +
			string(
				_stct_last_spawn_validation
					._ct_total
			) +
			" | VALID: " +
			string(
				_stct_last_spawn_validation
					._ct_valid
			) +
			" | INVALID: " +
			string(
				_stct_last_spawn_validation
					._ct_invalid
			) +
			" | DUPLICATES: " +
			string(
				_stct_last_spawn_validation
					._ct_duplicates
			),
			"INFO",
			"OBJ_WORLD_EVENT_CONTROLLER:STEP"
		);
	}
}

//================//
//GAMEPLAY CLOCK//
//================//
var _flag_world_event_time_active =
	scr_world_event_can_advance_time();

var _val_world_event_delta_seconds = 0;

if (_flag_world_event_time_active){

	_val_world_event_delta_seconds =
		clamp(
			delta_time /
				1000000,
			0,
			0.25
		);
}

//======================//
//FLUSH PENDING BANNER//
//======================//
if (
	_flag_status_banner_pending &&
	_flag_world_event_time_active
){

	var _str_banner_title =
		_str_pending_banner_title;

	var _str_banner_line_1 =
		_str_pending_banner_line_1;

	var _str_banner_line_2 =
		_str_pending_banner_line_2;

	_flag_status_banner_pending =
		false;

	_str_pending_banner_title = "";
	_str_pending_banner_line_1 = "";
	_str_pending_banner_line_2 = "";

	scr_world_event_show_banner(
		_str_banner_title,
		_str_banner_line_1,
		_str_banner_line_2
	);
}

//========================//
//FLUSH REWARD PICKUPS//
//========================//
if (
	_flag_world_event_time_active &&
	is_array(_arr_pending_reward_popups) &&
	array_length(_arr_pending_reward_popups) > 0
){

	var _arr_reward_popups =
		_arr_pending_reward_popups;

	// Clear the persistent queue before creating GUI objects so this batch can
	// never be replayed if another state change occurs later in the same frame.
	_arr_pending_reward_popups = [];

	for (
		var _it_reward_popup = 0;
		_it_reward_popup < array_length(_arr_reward_popups);
		_it_reward_popup++
	){

		var _stct_reward_popup =
			_arr_reward_popups[_it_reward_popup];

		if (!is_struct(_stct_reward_popup)){
			continue;
		}

		scr_gui_spawn_treasure_reward(
			_stct_reward_popup._str_reward_type,
			_stct_reward_popup._str_reward_id,
			_stct_reward_popup._ct_amount
		);
	}

	scr_debug_log(
		"WORLD_EVENT",
		"REWARD",
		self,
		"DEFERRED WORLD EVENT REWARD PICKUPS DISPLAYED" +
		" | COUNT: " +
		string(array_length(_arr_reward_popups)) +
		" | ROOM: " +
		string_upper(room_get_name(room)),
		"INFO",
		"OBJ_WORLD_EVENT_CONTROLLER:STEP"
	);
}

//==========================//
//INITIAL EVENT ANNOUNCEMENT//
//==========================//
var _flag_announcement_shown_this_step =
	false;

if (
	_stct_active_world_event
		._flag_announcement_pending &&
	_flag_world_event_time_active
){

	_stct_active_world_event
		._flag_announcement_pending =
		false;

	_flag_announcement_shown_this_step =
		true;

	scr_world_event_show_banner(
		"WORLD EVENT — " +
			_stct_active_world_event
				._str_display_name,
		_stct_active_world_event
			._str_target_room_name,
		scr_world_event_format_time(
			_stct_active_world_event
				._val_announcement_time_remaining
		) +
			" TO REACH EVENT"
	);
}

//================//
//LIFECYCLE//
//================//
switch (
	_stct_active_world_event
		._state_world_event
){

	//================//
	//NO ACTIVE EVENT//
	//================//
	case ENUM_WORLD_EVENT_STATE.NONE:
	break;

	//================//
	//TRAVEL WINDOW//
	//================//
	case ENUM_WORLD_EVENT_STATE.ANNOUNCED:

		if (!_flag_world_event_time_active){
			break;
		}

		// Target-room entry takes priority over travel-time decrement.
		if (
			room ==
			_stct_active_world_event
				._rm_target
		){

			scr_world_event_activate(
				!_flag_announcement_shown_this_step
			);

			break;
		}

		_stct_active_world_event
			._val_announcement_time_remaining =
			max(
				0,
				_stct_active_world_event
					._val_announcement_time_remaining -
				_val_world_event_delta_seconds
			);

		if (
			_stct_active_world_event
				._val_announcement_time_remaining <=
			0
		){

			scr_world_event_expire(
				"THE EVENT WAS NOT REACHED IN TIME"
			);
		}

	break;

	//================//
	//ACTIVE EVENT//
	//================//
	case ENUM_WORLD_EVENT_STATE.ACTIVE:

		if (!_flag_world_event_time_active){
			break;
		}

		_stct_active_world_event
			._val_active_time_remaining =
			max(
				0,
				_stct_active_world_event
					._val_active_time_remaining -
				_val_world_event_delta_seconds
			);

		if (
			_stct_active_world_event
				._val_active_time_remaining <=
			0
		){

			scr_world_event_expire(
				"THE EVENT HAS ENDED"
			);
		}

	break;

	//================//
	//COMPLETED HOLD//
	//================//
	case ENUM_WORLD_EVENT_STATE.COMPLETED:

		if (!_flag_world_event_time_active){
			break;
		}

		_stct_active_world_event
			._val_cleanup_time_remaining =
			max(
				0,
				_stct_active_world_event
					._val_cleanup_time_remaining -
				_val_world_event_delta_seconds
			);

		if (
			_stct_active_world_event
				._val_cleanup_time_remaining <=
			0
		){

			scr_world_event_begin_cleanup();
		}

	break;

	//================//
	//EXPIRED EVENT//
	//================//
	case ENUM_WORLD_EVENT_STATE.EXPIRED:

		scr_world_event_begin_cleanup();

	break;

	//================//
	//FINAL CLEANUP//
	//================//
	case ENUM_WORLD_EVENT_STATE.CLEANUP:

		// SCR_WORLD_EVENT_CLEAR owns UID-scoped live-instance cleanup before the
		// persistent event record is reset.
		scr_world_event_clear(
			false
		);

	break;
}

//====================//
//EVENT-SPECIFIC ROOM SYNC//
//====================//
if (
	is_struct(_stct_active_world_event) &&
	room ==
		_stct_active_world_event._rm_target &&
	_flag_world_event_time_active &&
	!_stct_active_world_event._flag_event_battle_active
){

	switch (_stct_active_world_event._str_event_id){

		case "MIGRATION":

			if (
				_stct_active_world_event._state_world_event ==
					ENUM_WORLD_EVENT_STATE.ACTIVE &&
				!scr_world_event_migration_sync_room()
			){

				scr_world_event_expire(
					"MIGRATION COULD NOT FORM"
				);
			}

		break;

		case "CHOOSE_A_CHEST":

			if (
				_stct_active_world_event._state_world_event ==
					ENUM_WORLD_EVENT_STATE.ACTIVE &&
				!scr_world_event_gilded_gambit_sync_room()
			){

				scr_world_event_expire(
					"GILDED GAMBIT COULD NOT FORM"
				);
			}

		break;

		case "RUNAWAY_TREASURE_BEAST":

			if (
				_stct_active_world_event._state_world_event ==
					ENUM_WORLD_EVENT_STATE.ACTIVE ||
				_stct_active_world_event._state_world_event ==
					ENUM_WORLD_EVENT_STATE.COMPLETED
			){

				if (!scr_world_event_runaway_treasure_sync_room()){

					if (
						_stct_active_world_event._state_world_event ==
							ENUM_WORLD_EVENT_STATE.ACTIVE
					){
						scr_world_event_expire(
							"RUNAWAY TREASURE BEAST COULD NOT FORM"
						);
					}
				}
			}

		break;

		case "WANDERING_MERCHANT":

			if (
				_stct_active_world_event._state_world_event ==
					ENUM_WORLD_EVENT_STATE.ACTIVE &&
				!scr_world_event_wandering_merchant_sync_room()
			){

				scr_world_event_expire(
					"WANDERING MERCHANT COULD NOT SET UP SHOP"
				);
			}

		break;

		case "ELITE_SIGHTING":

			if (
				_stct_active_world_event._state_world_event ==
					ENUM_WORLD_EVENT_STATE.ACTIVE &&
				!scr_world_event_elite_sighting_sync_room()
			){

				scr_world_event_expire(
					"ELITE SIGHTING COULD NOT FORM"
				);
			}

		break;
	}
}
