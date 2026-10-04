//===============================================================================//
//
// STEP: OBJ_GUI_TREASURE_REWARD
// FUNCTION: Updates treasure reward lifetime and fade.
//           Holds fully visible for 120 frames, then fades for 60 frames.
//
//===============================================================================//

#region LIFETIME

//================//
//ADVANCE AGE//
//================//
_ct_age++;

//================//
//HOLD//
//================//
if (_ct_age <= _ct_hold_life){

	_val_alpha = 1;
}

//================//
//FADE//
//================//
else{

	var _val_fade_progress =
		(_ct_age - _ct_hold_life) /
		_ct_fade_life;

	_val_alpha =
		clamp(
			1 - _val_fade_progress,
			0,
			1
		);
}

//================//
//DESTROY//
//================//
if (_ct_age >= _ct_hold_life + _ct_fade_life){
	instance_destroy();
}

#endregion