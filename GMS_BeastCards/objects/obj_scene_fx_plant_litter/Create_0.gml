//===============================================================================//
//
// CREATE: OBJ_SCENE_FX_PLANT_LITTER
// FUNCTION: Initializes a drifting piece of plant litter.
//           Applies random rotation, velocity, size,
//           and wind parameters for natural motion.
//
//===============================================================================//

//---------//
//VARIABLES//
//—--------//
_val_rot = irandom(359);
_val_rot_spd = random_range(-3, 3);

// GUST
_val_hsp = random_range(-2, 2);
_val_vsp = random_range(-3, -1);

// FLUTTER
_val_gravity = 0.08;
_val_wind_strength = random_range(0.02, 0.08);

_ct_life = irandom_range(30,45);

_val_sprite_index = irandom_range(0,3);

_val_size = irandom_range(4,11)/10;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//