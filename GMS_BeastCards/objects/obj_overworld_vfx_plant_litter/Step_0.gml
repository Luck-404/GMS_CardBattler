//===============================================================================//
//
// STEP: OBJ_SCENE_FX_PLANT_LITTER
// FUNCTION: Updates drifting litter movement.
//           Applies wind flutter, gravity, rotation,
//           velocity damping, and lifetime handling.
//
//===============================================================================//

//—------------------------------------------------------------------------------//
// ROTATION
//—------------------------------------------------------------------------------//
_val_rot += _val_rot_spd;

//—------------------------------------------------------------------------------//
// FLUTTER
//—------------------------------------------------------------------------------//
_val_hsp += random_range(-_val_wind_strength, _val_wind_strength);


_val_vsp += _val_gravity; // fall downward

 
_val_vsp = clamp(_val_vsp, -10, 2); // cap fall speed

// movement
x += _val_hsp;
y += _val_vsp;


_val_hsp *= 0.98; // slowly damp horizontal motion

//—------------------------------------------------------------------------------//
// LIFE
//—------------------------------------------------------------------------------//
_ct_life--;

if (_ct_life <= 0)
{
    instance_destroy();
}