//
//
// DRAW: OBJ_FADER
//
//
draw_sprite_ext(spr_fader,0,x,y,1,1,0,c_white,_alpha);

if (_flag_fade_out == false){
	show_debug_message("FADING OUT");
	_alpha+= _fade_speed;
	if (_alpha >= 1.0){
		show_debug_message("\n\n\nFADE OUT DONE");
		_flag_fade_out = true;	
		_ref_transition._flag_continue_transition = true;
	}
}

if (_flag_fade_in == true){
		show_debug_message("FADING IN");
	_alpha-= _fade_speed;
	if (_alpha <= 0){
			show_debug_message("\n\n\nFADING IN DONE");
		instance_destroy(_ref_spinner);
		instance_destroy();
	}
}

