//
// STEP: OBJ_LEAF
//

_rot += _rot_spd;

// move outward
x += lengthdir_x(_spd, _dir);
y += lengthdir_y(_spd, _dir);

// optional slight slowdown
_spd *= 0.9;

_life--;

if (_life <= 0)
{
    instance_destroy();
}