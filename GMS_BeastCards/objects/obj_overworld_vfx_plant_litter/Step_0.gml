//===============================================================================//
//
// STEP: OBJ_OVERWORLD_VFX_PLANT_LITTER
// FUNCTION: Updates drifting plant-litter movement.
//           Applies wind flutter, gravity, rotation, damping, and lifetime.
//
//===============================================================================//

//================//
//ROTATION//
//================//
_val_rotation += _val_rotation_speed;

//================//
//FLUTTER//
//================//
_val_velocity_x += random_range(-_val_wind_strength,_val_wind_strength);

_val_velocity_y += _val_gravity;
_val_velocity_y = clamp(_val_velocity_y,-10,2);

//================//
//MOVEMENT//
//================//
x += _val_velocity_x;
y += _val_velocity_y;

_val_velocity_x *= 0.98;

//================//
//LIFETIME//
//================//
_ct_lifetime--;

if (_ct_lifetime <= 0){
	instance_destroy();
}