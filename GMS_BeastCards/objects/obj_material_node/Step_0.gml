//===============================================================================//
//
// STEP: OBJ_MATERIAL_NODE
// FUNCTION: Allows the player to gather one Material when within interaction
//           range and E is pressed.
//
//           Material identity is rolled at collection time:
//           paired pools = 90% common / 10% rare.
//
//===============================================================================//

//================//
//VALIDATE STATE//
//================//
if (_flag_collected){
	exit;
}

if (!instance_exists(obj_player)){
	exit;
}

if (global.flag_pause){
	exit;
}

if (
	distance_to_object(
		obj_player
	) >=
	_val_interact_distance
){
	exit;
}

//================//
//INTERACT//
//================//
if (
	!keyboard_check_pressed(
		ord("E")
	)
){
	exit;
}

//================//
//ROLL MATERIAL//
//================//
var _str_material_id =
	scr_roll_material(
		_str_material_node_type
	);

if (_str_material_id == undefined){

	scr_debug_log(
		"OVERWORLD",
		"MATERIAL_NODE",
		self,
		"MATERIAL GATHER FAILED" +
		" | TYPE: " +
		_str_material_node_type +
		" | REASON: MATERIAL ROLL FAILED",
		"ERROR",
		"OBJ_MATERIAL_NODE:STEP"
	);

	exit;
}

//================//
//VALIDATE MATERIAL//
//================//
var _stct_material =
	scr_inventory_get_item_info(
		_str_material_id
	);

if (!is_struct(_stct_material)){

	scr_debug_log(
		"OVERWORLD",
		"MATERIAL_NODE",
		self,
		"MATERIAL GATHER FAILED" +
		" | TYPE: " +
		_str_material_node_type +
		" | MATERIAL: " +
		string(
			_str_material_id
		) +
		" | REASON: INVALID ITEM DATA",
		"ERROR",
		"OBJ_MATERIAL_NODE:STEP"
	);

	exit;
}

//================//
//LOCK COLLECTION//
//================//
_flag_collected =
	true;

//================//
//ADD MATERIAL//
//================//
scr_inventory_add_item(
	_str_material_id,
	1
);

//================//
//SHOW REWARD//
//================//
scr_gui_spawn_treasure_reward(
	"ITEM",
	_str_material_id,
	1
);

//================//
//AUDIO//
//================//
audio_play_sound(
	snd_overworld_treasure_claim,
	2,
	false
);

//================//
//DEBUG//
//================//
scr_debug_log(
	"OVERWORLD",
	"MATERIAL_NODE",
	self,
	"MATERIAL GATHERED" +
	" | TYPE: " +
	_str_material_node_type +
	" | MATERIAL: " +
	_str_material_id +
	" | NAME: " +
	string_upper(
		_stct_material._str_item_name
	) +
	" | ROOM: " +
	room_get_name(room) +
	" | POSITION: (" +
	string(
		round(x)
	) +
	"," +
	string(
		round(y)
	) +
	")",
	"REWARD",
	"OBJ_MATERIAL_NODE:STEP"
);

//================//
//CLEAR SPAWNER REF//
//================//
if (
	instance_exists(
		_ref_material_spawner
	)
){

	_ref_material_spawner
		._ref_spawned_node =
			noone;
}

//================//
//DESTROY NODE//
//================//
instance_destroy();