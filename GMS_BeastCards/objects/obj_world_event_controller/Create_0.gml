//===============================================================================//
//
// CREATE: OBJ_WORLD_EVENT_CONTROLLER
// FUNCTION: Initializes the persistent singleton World Event controller.
//           Owns stable World Event identity, room/spawn-point observation,
//           post-battle roll configuration, lifecycle timers, pending banners,
//           and future event-battle roll suppression.
//
//===============================================================================//

//================//
//SINGLETON GUARD//
//================//
if (
	instance_number(
		obj_world_event_controller
	) > 1
){

	var _ref_existing =
		instance_find(
			obj_world_event_controller,
			0
		);

	if (
		instance_exists(
			_ref_existing
		) &&
		_ref_existing !=
		self
	){
		instance_destroy();
		exit;
	}
}

//================//
//PERSISTENCE//
//================//
persistent =
	true;

global.ref_world_event_controller =
	id;

//================//
//IDENTITY COUNTERS//
//================//
_uid_next_world_event = 0;
_uid_next_world_event_entity = 0;

//================//
//ROLL CONFIG//
//================//
// Production V1 rate: 1 successful roll per 50 completed normal battles.
_ct_world_event_roll_denominator = 50;

_ct_battle_completions_seen = 0;
_ct_last_world_event_roll = 0;

_flag_last_world_event_roll_success = false;
_str_last_battle_result = "";

// Future exact/event battles set this before their result is registered.
// The next completion registration consumes the flag even if an event is active.
_flag_suppress_next_battle_roll = false;

//================//
//TIMER CONFIG//
//================//
// Stored in seconds and advanced using delta_time only during active overworld
// gameplay. Battle, pause, and transition time do not consume these timers.
_val_travel_duration_seconds = 10 * 60;
_val_active_duration_seconds = 10 * 60;
_val_completion_grace_seconds = 2 * 60;
_val_migration_completion_display_seconds = 8;
_val_gilded_gambit_completion_display_seconds = 8;
_val_elite_sighting_completion_display_seconds = 8;

//================//
//MIGRATION CONFIG//
//================//
_ct_migration_population_min = 10;
_ct_migration_population_max = 20;

_ct_migration_pod_size_min = 3;
_ct_migration_pod_size_max = 5;

_val_migration_leader_level_bonus_min = 3;
_val_migration_leader_level_bonus_max = 5;

//=====================//
//ELITE SIGHTING CONFIG//
//=====================//
_ct_elite_sighting_risk_tier = 2;
_ct_elite_sighting_roster_size = 3;

//========================//
//RUNAWAY TREASURE CONFIG//
//========================//
_ct_runaway_treasure_sparkles_min = 8;
_ct_runaway_treasure_sparkles_max = 8;

_val_runaway_treasure_flee_speed = 2.25;
_val_runaway_treasure_detect_radius = 128;

//================//
//ACTIVE EVENT//
//================//
_stct_active_world_event =
	scr_world_event_create_empty();

//================//
//BATTLE CONTEXT//
//================//
_stct_battle_context =
	scr_world_event_create_empty_battle_context();

_stct_last_battle_context =
	scr_world_event_create_empty_battle_context();

//================//
//PENDING STATUS BANNER//
//================//
_flag_status_banner_pending = false;

_str_pending_banner_title = "";
_str_pending_banner_line_1 = "";
_str_pending_banner_line_2 = "";

//======================//
//PENDING REWARD POPUPS//
//======================//
// Battle-completed World Events award their rewards immediately, but overworld
// pickup notifications are deferred until the player has returned from rm_battle.
_arr_pending_reward_popups = [];

//================//
//ROOM REGISTRY//
//================//
_arr_eligible_rooms =
	scr_world_event_get_eligible_rooms();

_rm_previous_room =
	undefined;

_rm_observed_room =
	room;

_ct_room_revision =
	0;

_flag_room_validation_pending =
	true;

_stct_last_spawn_validation = {
	_rm_room : room,
	_ct_total : 0,
	_ct_valid : 0,
	_ct_invalid : 0,
	_ct_duplicates : 0
};

//================//
//HUD PRESENTATION//
//================//
// J toggles all dedicated World Event HUD elements without changing event state.
_flag_world_event_gui_visible = true;

//================//
//DEBUG INIT//
//================//
scr_debug_log(
	"WORLD_EVENT",
	"INIT",
	self,
	"WORLD EVENT CONTROLLER INITIALIZED" +
	" | ELIGIBLE ROOMS: " +
	string(
		array_length(
			_arr_eligible_rooms
		)
	) +
	" | ROLL: 1/" +
	string(
		_ct_world_event_roll_denominator
	) +
	" | TRAVEL: " +
	string(
		_val_travel_duration_seconds
	) +
	" SEC" +
	" | ACTIVE: " +
	string(
		_val_active_duration_seconds
	) +
	" SEC" +
	" | COMPLETE GRACE: " +
	string(
		_val_completion_grace_seconds
	) +
	" SEC" +
	" | MIGRATION CLEAR DISPLAY: " +
	string(
		_val_migration_completion_display_seconds
	) +
	" SEC" +
	" | GILDED GAMBIT CLEAR DISPLAY: " +
	string(
		_val_gilded_gambit_completion_display_seconds
	) +
	" SEC" +
	" | ELITE SIGHTING CLEAR DISPLAY: " +
	string(
		_val_elite_sighting_completion_display_seconds
	) +
	" SEC" +
	" | ELITE SIGHTING TIER: " +
	string(_ct_elite_sighting_risk_tier) +
	" | ELITE SIGHTING ROSTER: " +
	string(_ct_elite_sighting_roster_size) +
	" | RUNAWAY TREASURE SPARKLES: " +
	string(_ct_runaway_treasure_sparkles_min) +
	"-" +
	string(_ct_runaway_treasure_sparkles_max) +
	" | CURRENT ROOM: " +
	string_upper(
		room_get_name(
			room
		)
	),
	"INIT",
	"OBJ_WORLD_EVENT_CONTROLLER:CREATE"
);
