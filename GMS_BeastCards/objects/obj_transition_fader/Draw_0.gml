//
//
// DRAW: OBJ_TRANSITION_FADER | DRAWS THE FADER OBJECT (BIG BLACK BOX)MAS IT IS FADING IN/OUT
//
//

//
// DRAW SPRITE
//
draw_sprite_ext(spr_transition_fader,0,x,y,1,1,0,c_white,_alpha);

//
// FADING OUT (DARKENING) | DARKENS THE SCREEN AT THE FADE RATE PROVIDED IN THE CREATE EVENT
//
#region FADING OUT
if (_flag_fade_out == false){
	_alpha+= _fade_speed;
	if (_alpha >= 1.0){
		_flag_fade_out = true;	
		_ref_transition_obj._flag_continue_transition = true;
	}
}
#endregion

//
// FADING IN | LIGHTENS THE SCREEN AT THE FADE RATE.
//
#region FADING IN
if (_flag_fade_in == true){
	_alpha-= _fade_speed;
	if (_alpha <= 0){
		instance_destroy(_ref_spinner);
		instance_destroy();
	}
}
#endregion