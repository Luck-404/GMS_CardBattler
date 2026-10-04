//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_PERSISTENT_LOOP
// FUNCTION: Creates a persistent looping environmental battle VFX.
//           Reuses the authoritative battle VFX constructor so environmental
//           effects receive the same initialization, visibility, position,
//           scale, and draw behavior as normal battle VFX.
//           The legacy layer argument is retained for caller compatibility but
//           is not currently used.
//
// INPUTS:   _spr_vfx    - Looping environmental VFX sprite.
//           _val_x      - Optional explicit room X position.
//           _val_y      - Optional explicit room Y position.
//           _val_scale  - VFX draw scale.
//           _str_layer  - Legacy environmental layer argument.
//
// RETURNS: The persistent VFX instance, or undefined on failure.
//
//===============================================================================//

function scr_battle_vfx_persistent_loop(_spr_vfx,_val_x=undefined,_val_y=undefined,_val_scale=1,_str_layer="ily_event_fx"){

	//----------------//
	//VALIDATE SPRITE//
	//----------------//
	if (_spr_vfx == undefined){
		return undefined;
	}

	//---------------//
	//BASE POSITION//
	//---------------//
	var _val_spawn_x = room_width * 0.5;
	var _val_spawn_y = room_height * 0.5;

	//------------------//
	//POSITION OVERRIDES//
	//------------------//
	if (_val_x != undefined){
		_val_spawn_x = _val_x;
	}

	if (_val_y != undefined){
		_val_spawn_y = _val_y;
	}

	//================//
	//CREATE BASE VFX//
	//================//
	// Use the same authoritative constructor as every working temporary
	// battle VFX. This guarantees the instance receives the normal visible
	// startup state and is created on the known-working ily_fx layer.
	var _ref_vfx = scr_battle_vfx(
		undefined,
		_spr_vfx,
		_val_spawn_x,
		_val_spawn_y,
		0,
		0,
		_val_scale,
		0,
		undefined
	);

	if (!instance_exists(_ref_vfx)){
		return undefined;
	}

	//================//
	//PERSISTENT LOOP//
	//================//
	_ref_vfx._flag_persistent = false;
	_ref_vfx._flag_persistent_loop = true;
	_ref_vfx._flag_follow_anchor = false;

	//====================//
	//FORCE DRAWABLE STATE//
	//====================//
	_ref_vfx.visible = true;
	_ref_vfx.image_alpha = 1;
	_ref_vfx.image_index = 0;
	_ref_vfx.image_speed = 1;

	//================//
	//DEBUG CREATION//
	//================//
	scr_debug_log(
		"BATTLE",
		"VFX",
		_ref_vfx,
		"PERSISTENT LOOP VFX CREATED" +
		" | SPRITE: " + sprite_get_name(_spr_vfx) +
		" | POSITION: (" +
		string(round(_ref_vfx.x)) + "," +
		string(round(_ref_vfx.y)) + ")" +
		" | VISIBLE: " + string(_ref_vfx.visible) +
		" | FRAMES: " + string(_ref_vfx.image_number),
		"INFO",
		"SCR_BATTLE_VFX_PERSISTENT_LOOP"
	);

	return _ref_vfx;
}