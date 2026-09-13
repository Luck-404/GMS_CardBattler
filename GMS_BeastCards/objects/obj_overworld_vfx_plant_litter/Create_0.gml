//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_VFX_PLANT_LITTER
// FUNCTION: Initializes a drifting piece of overworld plant litter.
//           Randomizes rotation, velocity, scale, and wind behavior.
//
//===============================================================================//

//================//
//VARIABLES//
//================//

//----------------//
//ROTATION//
//----------------//
_val_rotation = irandom(359);
_val_rotation_speed = random_range(-3,3);

//----------------//
//MOVEMENT//
//----------------//
_val_velocity_x = random_range(-2,2);
_val_velocity_y = random_range(-3,-1);

_val_gravity = 0.08;
_val_wind_strength = random_range(0.02,0.08);

//----------------//
//LIFETIME//
//----------------//
_ct_lifetime = irandom_range(30,45);

//----------------//
//VISUALS//
//----------------//
_it_sprite_frame = irandom_range(0,3);
_val_scale = irandom_range(4,11) / 10;

//================//
//INIT//
//================//

//================//
//METHODS//
//================//