//===============================================================================//
//
// SCRIPT: SCR_BEAST_ANIMATION_CONTROL
// FUNCTION: Central compatibility layer for staged multi-frame Beast sprites.
//           Resolves a Beast name/sprite, initializes per-instance animation
//           state, plays named frame ranges, advances animation timing, and
//           supplies the subimage used by Battle/Overworld/Ranch drawing.
//
//           CURRENT TEST GATE:
//           Any Beast explicitly enabled by SCR_BEAST_ANIMATION_IS_VALID may use
//           the staged animation system in Battle, Overworld, and Ranch contexts.
//           The species whitelist remains the rollout gate while sprites are
//           converted one at a time. All non-enabled species resolve to frame 0.
//
//           FRAME LAYOUT:
//           IDLE     0-3 (18 steps/frame)
//           ATTACK   4-6
//           HIT      7 (15-step hold)
//           DEATH    7-9, then holds on frame 9 while dead
//           WALK     10-15 (9 steps/frame)
//           INTERACT 16-30
//
//           Every requested range is clamped against the sprite's actual
//           subimage count. Missing ranges fall back safely to IDLE/frame 0.
//
//===============================================================================//

function scr_beast_animation_get_name(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return "";
	}

	if (
		variable_instance_exists(
			_ref_beast,
			"_ref_unit"
		) &&
		is_struct(
			_ref_beast._ref_unit
		) &&
		variable_struct_exists(
			_ref_beast._ref_unit,
			"_str_beast_name"
		)
	){
		return string_upper(
			string(
				_ref_beast
					._ref_unit
					._str_beast_name
			)
		);
	}

	if (
		variable_instance_exists(
			_ref_beast,
			"_stct_unit"
		) &&
		is_struct(
			_ref_beast._stct_unit
		) &&
		variable_struct_exists(
			_ref_beast._stct_unit,
			"_str_beast_name"
		)
	){
		return string_upper(
			string(
				_ref_beast
					._stct_unit
					._str_beast_name
			)
		);
	}

	if (
		variable_instance_exists(
			_ref_beast,
			"_str_beast_name"
		)
	){
		return string_upper(
			string(
				_ref_beast._str_beast_name
			)
		);
	}

	return "";
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_ANIMATION_GET_SPRITE
//-------------------------------------------------------------------------------//
function scr_beast_animation_get_sprite(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return undefined;
	}

	if (
		variable_instance_exists(
			_ref_beast,
			"_spr_beast"
		) &&
		_ref_beast._spr_beast != undefined &&
		sprite_exists(
			_ref_beast._spr_beast
		)
	){
		return _ref_beast._spr_beast;
	}

	if (
		_ref_beast.sprite_index != -1 &&
		sprite_exists(
			_ref_beast.sprite_index
		)
	){
		return _ref_beast.sprite_index;
	}

	return undefined;
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_ANIMATION_CONTEXT_ENABLED
// FUNCTION: Returns whether this instance context may use staged Beast animation.
//           Species validity remains the temporary rollout authority.
//-------------------------------------------------------------------------------//
function scr_beast_animation_context_enabled(_ref_beast){

	return instance_exists(_ref_beast);
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_ANIMATION_INIT
//-------------------------------------------------------------------------------//
function scr_beast_animation_init(_ref_beast,_str_beast_name=undefined){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_str_beast_name == undefined){
		_str_beast_name =
			scr_beast_animation_get_name(
				_ref_beast
			);
	}

	_str_beast_name =
		string_upper(
			string(
				_str_beast_name
			)
		);

	var _spr_beast =
		scr_beast_animation_get_sprite(
			_ref_beast
		);

	var _flag_valid =
		_str_beast_name != "" &&
		scr_beast_animation_context_enabled(
			_ref_beast
		) &&
		scr_beast_animation_is_valid(
			_str_beast_name
		) &&
		_spr_beast != undefined;

	_ref_beast._flag_beast_animation_initialized = true;
	_ref_beast._flag_beast_animation_valid = _flag_valid;
	_ref_beast._str_beast_animation_owner_name = _str_beast_name;

	_ref_beast._str_beast_animation_state = "IDLE";
	_ref_beast._val_beast_animation_frame = 0;

	_ref_beast._it_beast_animation_start = 0;
	_ref_beast._it_beast_animation_end = 0;

	_ref_beast._ct_beast_animation_tick = 0;
	_ref_beast._ct_beast_animation_step = 24;

	_ref_beast._flag_beast_animation_loop = true;
	_ref_beast._flag_beast_animation_auto_idle = false;
	_ref_beast._flag_beast_animation_finished = false;

	if (_flag_valid){
		scr_beast_animation_play(
			_ref_beast,
			"IDLE",
			true
		);
	}

	return _flag_valid;
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_ANIMATION_ENSURE
// FUNCTION: Lazily initializes/reinitializes animation state. Name re-checking
//           keeps Cheat Beast replacement and staged roster edits safe.
//-------------------------------------------------------------------------------//
function scr_beast_animation_ensure(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	var _str_beast_name =
		scr_beast_animation_get_name(
			_ref_beast
		);

	var _flag_needs_init =
		!variable_instance_exists(
			_ref_beast,
			"_flag_beast_animation_initialized"
		) ||
		!_ref_beast._flag_beast_animation_initialized;

	if (!_flag_needs_init){
		_flag_needs_init =
			!variable_instance_exists(
				_ref_beast,
				"_str_beast_animation_owner_name"
			) ||
			_ref_beast._str_beast_animation_owner_name !=
				_str_beast_name;
	}

	if (_flag_needs_init){
		return scr_beast_animation_init(
			_ref_beast,
			_str_beast_name
		);
	}

	if (
		!scr_beast_animation_context_enabled(
			_ref_beast
		) ||
		!scr_beast_animation_is_valid(
			_str_beast_name
		)
	){
		_ref_beast._flag_beast_animation_valid = false;
		_ref_beast._val_beast_animation_frame = 0;
		return false;
	}

	var _spr_beast =
		scr_beast_animation_get_sprite(
			_ref_beast
		);

	if (_spr_beast == undefined){
		_ref_beast._flag_beast_animation_valid = false;
		_ref_beast._val_beast_animation_frame = 0;
		return false;
	}

	_ref_beast._flag_beast_animation_valid = true;
	return true;
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_ANIMATION_PLAY
//-------------------------------------------------------------------------------//
function scr_beast_animation_play(_ref_beast,_str_state,_flag_restart=true){

	if (!scr_beast_animation_ensure(_ref_beast)){
		if (instance_exists(_ref_beast)){
			_ref_beast._val_beast_animation_frame = 0;
		}
		return false;
	}

	_str_state =
		string_upper(
			string(
				_str_state
			)
		);

	if (
		!_flag_restart &&
		_ref_beast._str_beast_animation_state ==
			_str_state &&
		!_ref_beast._flag_beast_animation_finished
	){
		return true;
	}

	var _spr_beast =
		scr_beast_animation_get_sprite(
			_ref_beast
		);

	if (_spr_beast == undefined){
		_ref_beast._val_beast_animation_frame = 0;
		return false;
	}

	var _ct_subimages =
		max(
			1,
			sprite_get_number(
				_spr_beast
			)
		);

	var _it_last_subimage =
		_ct_subimages - 1;

	var _it_start = 0;
	var _it_end = 0;
	var _ct_step = 8;
	var _flag_loop = false;
	var _flag_auto_idle = false;

	switch (_str_state){

		case "IDLE":
			_it_start = 0;
			_it_end = min(3,_it_last_subimage);
			_ct_step = 18;
			_flag_loop = true;
		break;

		case "ATTACK":
			_it_start = 4;
			_it_end = min(6,_it_last_subimage);
			_ct_step = 5;
			_flag_auto_idle = true;
		break;

		case "HIT":
			_it_start = 7;
			_it_end = 7;
			_ct_step = 15;
			_flag_auto_idle = true;
		break;

		case "DEATH":
			_it_start = 7;
			_it_end = min(9,_it_last_subimage);
			_ct_step = 6;
		break;

		case "WALK":
			_it_start = 10;
			_it_end = min(15,_it_last_subimage);
			_ct_step = 12;
			_flag_loop = true;
		break;

		case "INTERACT":
			_it_start = 16;
			_it_end = min(30,_it_last_subimage);
			_ct_step = 5;
		break;

		default:
			_str_state = "IDLE";
			_it_start = 0;
			_it_end = min(3,_it_last_subimage);
			_ct_step = 24;
			_flag_loop = true;
		break;
	}

	// Requested animation is not present yet on this sprite. Keep the staged
	// rollout safe by falling back to the available idle range/frame 0.
	if (_it_start > _it_last_subimage){
		_str_state = "IDLE";
		_it_start = 0;
		_it_end = min(3,_it_last_subimage);
		_ct_step = 24;
		_flag_loop = true;
		_flag_auto_idle = false;
	}

	_ref_beast._str_beast_animation_state = _str_state;
	_ref_beast._it_beast_animation_start = _it_start;
	_ref_beast._it_beast_animation_end = max(_it_start,_it_end);
	_ref_beast._ct_beast_animation_step = max(1,_ct_step);
	_ref_beast._ct_beast_animation_tick = 0;
	_ref_beast._flag_beast_animation_loop = _flag_loop;
	_ref_beast._flag_beast_animation_auto_idle = _flag_auto_idle;
	_ref_beast._flag_beast_animation_finished = false;
	_ref_beast._val_beast_animation_frame = _it_start;

	return true;
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_ANIMATION_UPDATE
//-------------------------------------------------------------------------------//
function scr_beast_animation_update(_ref_beast){

	if (!scr_beast_animation_ensure(_ref_beast)){
		if (instance_exists(_ref_beast)){
			_ref_beast._val_beast_animation_frame = 0;
		}
		return false;
	}

	if (_ref_beast._flag_beast_animation_finished){

		// Death is a permanent corpse pose for staged sprites. Keep the Beast
		// pinned to the final DEATH frame even if another caller touched its
		// presentation frame after the animation completed.
		if (_ref_beast._str_beast_animation_state == "DEATH"){
			_ref_beast._val_beast_animation_frame =
				_ref_beast._it_beast_animation_end;
		}

		return true;
	}

	_ref_beast._ct_beast_animation_tick++;

	if (
		_ref_beast._ct_beast_animation_tick <
		_ref_beast._ct_beast_animation_step
	){
		return true;
	}

	_ref_beast._ct_beast_animation_tick = 0;

	if (
		_ref_beast._val_beast_animation_frame <
		_ref_beast._it_beast_animation_end
	){
		_ref_beast._val_beast_animation_frame++;
		return true;
	}

	if (_ref_beast._flag_beast_animation_loop){
		_ref_beast._val_beast_animation_frame =
			_ref_beast._it_beast_animation_start;
		return true;
	}

	_ref_beast._flag_beast_animation_finished = true;

	if (_ref_beast._str_beast_animation_state == "DEATH"){
		_ref_beast._val_beast_animation_frame =
			_ref_beast._it_beast_animation_end;
	}

	if (_ref_beast._flag_beast_animation_auto_idle){
		scr_beast_animation_play(
			_ref_beast,
			"IDLE",
			true
		);
	}

	return true;
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_ANIMATION_SYNC_LOCOMOTION
//-------------------------------------------------------------------------------//
function scr_beast_animation_sync_locomotion(_ref_beast,_flag_moving){

	if (!scr_beast_animation_ensure(_ref_beast)){
		return false;
	}

	var _str_state =
		_ref_beast._str_beast_animation_state;

	if (
		_str_state == "DEATH" ||
		_str_state == "ATTACK" ||
		_str_state == "HIT" ||
		_str_state == "INTERACT"
	){
		return true;
	}

	return scr_beast_animation_play(
		_ref_beast,
		_flag_moving
			? "WALK"
			: "IDLE",
		false
	);
}

//-------------------------------------------------------------------------------//
// SCR_BEAST_ANIMATION_GET_FRAME
//-------------------------------------------------------------------------------//
function scr_beast_animation_get_frame(_ref_beast){

	if (!scr_beast_animation_ensure(_ref_beast)){
		return 0;
	}

	var _spr_beast =
		scr_beast_animation_get_sprite(
			_ref_beast
		);

	if (_spr_beast == undefined){
		return 0;
	}

	var _it_last_subimage =
		max(
			0,
			sprite_get_number(
				_spr_beast
			) - 1
		);

	return clamp(
		floor(
			_ref_beast._val_beast_animation_frame
		),
		0,
		_it_last_subimage
	);
}
