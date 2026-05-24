//
//
// DRAW: OBJ_FADER
//
//
draw_sprite_ext(spr_fader,0,x,y,1,1,0,c_white,_alpha);

if (_flag_fade_out == false){
	_alpha+= _fade_speed;
	if (_alpha >= 1.0){
		_flag_fade_out = true;	
		_ref_transition._flag_continue_transition = true;
	}
}

if (_flag_fade_in == true){
	_alpha-= _fade_speed;
	if (_alpha <= 0){
		instance_destroy(_ref_spinner);
		instance_destroy();
	}
}

