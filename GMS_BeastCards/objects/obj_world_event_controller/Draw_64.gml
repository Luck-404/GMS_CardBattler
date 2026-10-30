//===============================================================================//
//
// DRAW GUI: OBJ_WORLD_EVENT_CONTROLLER
// FUNCTION: Draws a compact overworld World Event tracker.
//           This is functional V1 presentation and can be visually restyled
//           without changing event lifecycle logic.
//
//===============================================================================//

//================//
//VALIDATE DISPLAY//
//================//
if (
	!_flag_world_event_gui_visible ||
	room == rm_battle ||
	instance_exists(
		obj_transition
	) ||
	instance_exists(
		obj_transition_fader
	) ||
	!is_struct(
		_stct_active_world_event
	)
){
	exit;
}

var _state_world_event =
	_stct_active_world_event
		._state_world_event;

if (
	_state_world_event ==
		ENUM_WORLD_EVENT_STATE.NONE ||
	_state_world_event ==
		ENUM_WORLD_EVENT_STATE.EXPIRED ||
	_state_world_event ==
		ENUM_WORLD_EVENT_STATE.CLEANUP
){
	exit;
}

//================//
//TRACKER TEXT//
//================//
var _str_title = "";
var _str_detail = "";
var _val_timer_seconds = 0;

switch (_state_world_event){

	case ENUM_WORLD_EVENT_STATE.ANNOUNCED:

		_str_title =
			"WORLD EVENT — " +
			_stct_active_world_event
				._str_display_name;

		_val_timer_seconds =
			_stct_active_world_event
				._val_announcement_time_remaining;

		_str_detail =
			_stct_active_world_event
				._str_target_room_name +
			" | " +
			scr_world_event_format_time(
				_val_timer_seconds
			) +
			" TO ARRIVE";

	break;

	case ENUM_WORLD_EVENT_STATE.ACTIVE:

		_str_title =
			"WORLD EVENT — " +
			_stct_active_world_event
				._str_display_name;

		_val_timer_seconds =
			_stct_active_world_event
				._val_active_time_remaining;

		if (
			_stct_active_world_event._str_event_id == "MIGRATION" &&
			is_struct(_stct_active_world_event._stct_payload) &&
			variable_struct_exists(
				_stct_active_world_event._stct_payload,
				"_flag_migration_generated"
			) &&
			_stct_active_world_event._stct_payload._flag_migration_generated
		){

			var _ct_pods_remaining =
				max(
					0,
					_stct_active_world_event
						._stct_payload
						._ct_migration_pods_remaining
				);

			_str_detail =
				_stct_active_world_event
					._stct_payload
					._str_migration_species +
				" — " +
				string(_ct_pods_remaining) +
				(
					_ct_pods_remaining == 1
					? " POD REMAINS"
					: " PODS REMAIN"
				) +
				" | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else if (
			_stct_active_world_event._str_event_id ==
				"CHOOSE_A_CHEST"
		){

			_str_detail =
				"CHOOSE ONE CHEST | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else if (
			_stct_active_world_event._str_event_id ==
				"RUNAWAY_TREASURE_BEAST"
		){

			_str_detail =
				"CATCH THE TREASURE BEAST | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else if (
			_stct_active_world_event._str_event_id ==
				"WANDERING_MERCHANT"
		){

			_str_detail =
				"MERRICK IS TRADING | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else if (
			_stct_active_world_event._str_event_id ==
				"ELITE_SIGHTING"
		){

			_str_detail =
				"DEFEAT THE TIER 2 ELITE | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else{

			_str_detail =
				_stct_active_world_event
					._str_target_room_name +
				" | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}

	break;

	case ENUM_WORLD_EVENT_STATE.COMPLETED:

		_val_timer_seconds =
			_stct_active_world_event
				._val_cleanup_time_remaining;

		if (
			_stct_active_world_event
				._str_event_id ==
			"MIGRATION"
		){

			_str_title =
				"WORLD EVENT — MIGRATION CLEARED";

			var _flag_reward_claimed =
				_stct_active_world_event
					._flag_reward_claimed;

			_str_detail =
				(
					_flag_reward_claimed
					? "PREMIUM REWARDS AWARDED | "
					: ""
				) +
				"CLEARING | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else if (
			_stct_active_world_event._str_event_id ==
				"CHOOSE_A_CHEST"
		){

			_str_title =
				"WORLD EVENT — GILDED GAMBIT CLEARED";

			_str_detail =
				(
					_stct_active_world_event._flag_reward_claimed
					? "PREMIUM REWARD CLAIMED | "
					: ""
				) +
				"CLEARING | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else if (
			_stct_active_world_event._str_event_id ==
				"RUNAWAY_TREASURE_BEAST"
		){

			_str_title =
				"WORLD EVENT — TREASURE BEAST CAUGHT";

			var _ct_sparkles_remaining = 0;

			if (
				is_struct(_stct_active_world_event._stct_payload) &&
				variable_struct_exists(
					_stct_active_world_event._stct_payload,
					"_ct_runaway_treasure_sparkles_remaining"
				)
			){
				_ct_sparkles_remaining =
					max(
						0,
						_stct_active_world_event
							._stct_payload
							._ct_runaway_treasure_sparkles_remaining
					);
			}

			_str_detail =
				string(_ct_sparkles_remaining) +
				(
					_ct_sparkles_remaining == 1
					? " TREASURE SPARKLE REMAINS | "
					: " TREASURE SPARKLES REMAIN | "
				) +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else if (
			_stct_active_world_event._str_event_id ==
				"ELITE_SIGHTING"
		){

			_str_title =
				"WORLD EVENT — ELITE SIGHTING CLEARED";

			_str_detail =
				(
					_stct_active_world_event._flag_reward_claimed
					? "PREMIUM REWARDS AWARDED | "
					: ""
				) +
				"CLEARING | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}
		else{

			_str_title =
				"WORLD EVENT COMPLETE — " +
				_stct_active_world_event
					._str_display_name;

			_str_detail =
				(
					_stct_active_world_event
						._flag_reward_claimed
					? "PREMIUM REWARDS AWARDED | "
					: ""
				) +
				"REWARD GRACE | " +
				scr_world_event_format_time(
					_val_timer_seconds
				);
		}

	break;
}

//================//
//LAYOUT//
//================//
var _val_gui_w =
	display_get_gui_width();

var _val_tracker_w = 520;
var _val_tracker_h = 62;

var _val_x1 =
	(_val_gui_w * 0.5) -
	(_val_tracker_w * 0.5);

var _val_y1 = 12;

var _val_x2 =
	_val_x1 +
	_val_tracker_w;

var _val_y2 =
	_val_y1 +
	_val_tracker_h;

//================//
//BACKGROUND//
//================//
draw_set_alpha(
	0.90
);

draw_set_colour(
	global.c_dk_gray
);

draw_rectangle(
	_val_x1,
	_val_y1,
	_val_x2,
	_val_y2,
	false
);

//================//
//BORDER//
//================//
draw_set_alpha(
	1
);

draw_set_colour(
	c_yellow
);

draw_rectangle(
	_val_x1,
	_val_y1,
	_val_x2,
	_val_y2,
	true
);

//================//
//TEXT//
//================//
draw_set_halign(
	fa_center
);

draw_set_valign(
	fa_top
);

draw_set_font(
	fnt_gui_small
);

draw_set_colour(
	c_white
);

draw_text(
	_val_gui_w * 0.5,
	_val_y1 + 7,
	_str_title
);

draw_set_font(
	fnt_gui_party_small
);

draw_set_colour(
	c_yellow
);

draw_text(
	_val_gui_w * 0.5,
	_val_y1 + 30,
	_str_detail
);

//================//
//HUD HOTKEY HINT//
//================//
draw_set_font(fnt_gui_party_small);
draw_set_colour(c_gray);
draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_text(
	_val_x2 - 8,
	_val_y2 - 16,
	"[J] HIDE"
);

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
