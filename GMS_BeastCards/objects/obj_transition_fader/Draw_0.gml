//===============================================================================//
//
// DRAW: OBJ_TRANSITION_FADER
// FUNCTION: Draws the black transition overlay.
//           Fades out until the screen is fully covered.
//           Signals transition object, then fades in and cleans itself up.
//
//===============================================================================//

//----//
//DRAW//
//----//
draw_sprite_ext(spr_transition_fader,0,x,y,1,1,0,c_white,_val_alpha);

//--------//
//FADE OUT//
//--------//
if (!_flag_fade_out){
	_val_alpha += _val_fade_speed;

	if (_val_alpha >= 1){
		_val_alpha = 1;
		_flag_fade_out = true;

		if (_ref_transition != undefined){
			_ref_transition._flag_continue_transition = true;
		}
	}
}

//-------//
//FADE IN//
//-------//
if (_flag_fade_in){
	_val_alpha -= _val_fade_speed;

	if (_val_alpha <= 0){
		_val_alpha = 0;

		if (instance_exists(_ref_spinner)){
			instance_destroy(_ref_spinner);
		}

		instance_destroy();
	}
}