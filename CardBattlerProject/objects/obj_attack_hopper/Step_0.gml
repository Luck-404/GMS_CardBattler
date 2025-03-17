//////////////////////////////////////////////////////////////////////
//						OBJ_ERROR_SHAKER STEP						//
//																	//
// > PLAY SHAKE EFFECTS												//
//////////////////////////////////////////////////////////////////////
if (_shaking && _target != noone) {
    _shake_timer += 1;
    
    // Apply sine wave movement to the target's y position
    _target.y = _origin_y + sin(_shake_timer * _shake_speed) * _shake_amount;
    
    // Stop shaking after a duration and reset the target's position
    if (_shake_timer >= 15) {
        _shaking = false;
        _target.y = _origin_y; // Ensure it returns to its original position
        instance_destroy(); // Remove this shaker object when done
    }
}