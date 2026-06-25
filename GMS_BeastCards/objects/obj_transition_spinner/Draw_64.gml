//===============================================================================//
//
// DRAW GUI: OBJ_TRANSITION_SPINNER
// FUNCTION: Updates spinner rotation.
//           Draws spinner visual during transition processing.
//           Provides visual feedback while rooms are changing.
//
//===============================================================================//

//----//
//SPIN//
//----//
_val_rotation += _val_spin_speed;

//----//
//DRAW//
//----//
draw_sprite_ext(spr_transition_spinner,0,x,y,0.75,0.75,_val_rotation,c_white,1);