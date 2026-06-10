//
// STEP: OBJ_LEAF
//

// rotation
_rot += _rot_spd;

// gentle side-to-side flutter
_hsp += random_range(-_wind_strength, _wind_strength);

// fall downward
_vsp += _gravity;

// cap fall speed
_vsp = clamp(_vsp, -10, 2);

// movement
x += _hsp;
y += _vsp;

// slowly damp horizontal motion
_hsp *= 0.98;

// life
_life--;

if (_life <= 0)
{
    instance_destroy();
}