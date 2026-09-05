//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX
// FUNCTION: Creates a temporary battle visual effect.
//           Supports instance anchoring or explicit room coordinates.
//           Supports randomized X/Y variation for repeated effects.
//
//===============================================================================//

function scr_battle_vfx(
	_ref_anchor,
	_spr_vfx,
	_val_x=undefined,
	_val_y=undefined,
	_val_random_x=0,
	_val_random_y=0,
	_val_scale=1,
	_ct_start_delay=0,
	_snd_sfx=undefined
){

	//----------------//
	//VALIDATE SPRITE//
	//----------------//
	if (_spr_vfx == undefined){
		return undefined;
	}

	//-------------//
	//BASE POSITION//
	//-------------//
	var _val_spawn_x = room_width * 0.5;
	var _val_spawn_y = room_height * 0.5;

	if (instance_exists(_ref_anchor)){
		_val_spawn_x = _ref_anchor.x;
		_val_spawn_y = _ref_anchor.y;
	}

	//------------------//
	//POSITION OVERRIDES//
	//------------------//
	if (_val_x != undefined){
		_val_spawn_x = _val_x;
	}

	if (_val_y != undefined){
		_val_spawn_y = _val_y;
	}

	//----------------//
	//RANDOM VARIATION//
	//----------------//
	_val_spawn_x += irandom_range(-_val_random_x,_val_random_x);
	_val_spawn_y += irandom_range(-_val_random_y,_val_random_y);

	//----------//
	//CREATE VFX//
	//----------//
	var _ref_vfx = instance_create_layer(_val_spawn_x,_val_spawn_y,"ily_fx",obj_battle_vfx);

	_ref_vfx.sprite_index = _spr_vfx;
	_ref_vfx.image_index = 0;

	_ref_vfx.image_xscale = _val_scale;
	_ref_vfx.image_yscale = _val_scale;

	_ref_vfx._ref_anchor = _ref_anchor;

	_ref_vfx._ct_start_delay = max(0,_ct_start_delay);
	_ref_vfx._snd_sfx = _snd_sfx;

	if (_ct_start_delay > 0){
		_ref_vfx.visible = false;
		_ref_vfx.image_speed = 0;
	}
	else{
		_ref_vfx.visible = true;
		_ref_vfx.image_speed = 1;
	}

	return _ref_vfx;
}