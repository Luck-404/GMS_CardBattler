//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_PERSISTENT_LOOP
// FUNCTION: Creates a persistent looping environmental battle VFX.
//           Uses explicit room coordinates rather than requiring an anchor.
//           Supports configurable Event and Weather instance layers.
//           Continues looping until the VFX instance is explicitly destroyed.
//
// INPUTS:   _spr_vfx    - Looping environmental VFX sprite.
//           _val_x      - Optional explicit room X position.
//           _val_y      - Optional explicit room Y position.
//           _val_scale  - VFX draw scale.
//           _str_layer  - Instance layer used to create the VFX.
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

	//------------//
	//CREATE VFX//
	//------------//
	var _ref_vfx = instance_create_layer(
		_val_spawn_x,
		_val_spawn_y,
		_str_layer,
		obj_battle_vfx
	);

	//-------------//
	//SPRITE SETUP//
	//-------------//
	_ref_vfx.sprite_index = _spr_vfx;
	_ref_vfx.image_index = 0;
	_ref_vfx.image_speed = 1;

	_ref_vfx.image_xscale = _val_scale;
	_ref_vfx.image_yscale = _val_scale;

	//----------------//
	//PERSISTENT LOOP//
	//----------------//
	_ref_vfx._flag_persistent = false;
	_ref_vfx._flag_persistent_loop = true;
	_ref_vfx._flag_follow_anchor = false;

	return _ref_vfx;
}