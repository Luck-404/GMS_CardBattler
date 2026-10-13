//===============================================================================//
//
// CREATE: OBJ_WORLD_EVENT_CONTROLLER
// FUNCTION: Initializes the persistent singleton World Event controller.
//           Phase I owns event identity/state scaffolding, eligible-room metadata,
//           room-change observation, stable UID allocation, and spawn validation.
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
//ACTIVE EVENT//
//================//
_stct_active_world_event =
	scr_world_event_create_empty();

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
	" | CURRENT ROOM: " +
	string_upper(
		room_get_name(
			room
		)
	),
	"INIT",
	"OBJ_WORLD_EVENT_CONTROLLER:CREATE"
);
