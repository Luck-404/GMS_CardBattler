//////////////////////////////////////////////////////////////////////
//						SCR_CREATE_COMBAT_EFFECT					//
//																	//
// > CREATES A COMBAT EFFECT AT THE DESIRED LOCATION				//	
//////////////////////////////////////////////////////////////////////
function scr_create_combat_effect(_tar_obj,_sprite,_tar_x,_tar_y,_life,_color,_xscale,_yscale,_x1,_y1,_x2,_y2,_proj_speed,_motion_type,_secondary_script,_layer){
	var _ref_effect = instance_create_layer(0,0,_layer,obj_card_effect);
	_ref_effect._sprite = _sprite;
	_ref_effect.sprite_index = _sprite;
	////////////
	// TARGET //
	////////////	
	if (_tar_obj != undefined){
		_ref_effect.x = _tar_obj.x;
		_ref_effect.y = _tar_obj.y;
	}
	
	////////////////
	// X/Y COORDS //
	////////////////	
	else {
		_ref_effect.x = _tar_x;
		_ref_effect.y = _tar_y;
	}
	
	
	_ref_effect._life = _life;
	_ref_effect._color = _color;
	_ref_effect._xscale = _xscale;
	_ref_effect._yscale = _yscale;
	_ref_effect._x1 = _x1;
	_ref_effect._y1 = _y1;
	_ref_effect._x2 = _x2;
	_ref_effect._y2 = _y2;
	_ref_effect._motion_type = _motion_type;
	_ref_effect._proj_speed = _proj_speed;
	_ref_effect._secondary_script = _secondary_script;
	_ref_effect._move = true;
}
