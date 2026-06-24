//===============================================================================//
//
// CREATE: OBJ_DECOR_SIGN
// FUNCTION:	Initializes sign interaction variables
//				Configures trigger and cooldown states
//				Applies the assigned sign sprite instance
//
//===============================================================================//

event_inherited();
//---------//
//VARIABLES//
//—--------//
_flag_triggered = false;
_ct_cooldown = 60;

sprite_index = _spr_sign;


//----//
//INIT//
//----//


//-------//
//METHODS//
//-------//