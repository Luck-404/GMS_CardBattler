//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_PERSISTENT
// FUNCTION: Creates a persistent VFX attached to a host.
//           The effect follows the host and remains until explicitly destroyed.
//
//===============================================================================//

function scr_battle_vfx_persistent(
	_ref_anchor,
	_spr_vfx,
	_val_offset_x=0,
	_val_offset_y=0,
	_val_scale=1,
	_snd_sfx=undefined
){

	//----------------//
	//VALIDATE INPUT//
	//----------------//
	if (!instance_exists(_ref_anchor)){
		return undefined;
	}

	if (_spr_vfx == undefined){
		return undefined;
	}

	//----------//
	//CREATE VFX//
	//----------//
	var _ref_vfx = scr_battle_vfx(
		_ref_anchor,
		_spr_vfx,
		undefined,
		undefined,
		0,
		0,
		_val_scale,
		0,
		_snd_sfx
	);

	if (!instance_exists(_ref_vfx)){
		return undefined;
	}

	//----------------//
	//PERSISTENT SETUP//
	//----------------//
	_ref_vfx._flag_persistent = true;
	_ref_vfx._flag_follow_anchor = true;

	_ref_vfx._val_offset_x = _val_offset_x;
	_ref_vfx._val_offset_y = _val_offset_y;

	return _ref_vfx;
}