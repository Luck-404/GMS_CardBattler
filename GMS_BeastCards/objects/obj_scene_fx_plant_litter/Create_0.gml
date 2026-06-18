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
_rot = irandom(359);
_rot_spd = random_range(-3, 3);

// GUST
_hsp = random_range(-2, 2);
_vsp = random_range(-3, -1);

// FLUTTER
_gravity = 0.08;
_wind_strength = random_range(0.02, 0.08);

_life = irandom_range(30,45);

_random_index = irandom_range(0,3);

_random_size = irandom_range(4,11)/10;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//