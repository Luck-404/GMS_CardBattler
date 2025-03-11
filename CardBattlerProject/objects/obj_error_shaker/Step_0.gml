if (_shaking && _target != noone) {
    _shake_timer += 1;
    
    // Apply sine wave movement to the target's x position
    _target.x = _origin_x + sin(_shake_timer * _shake_speed) * _shake_amount;
    
    // Stop shaking after a duration and reset the target's position
    if (_shake_timer >= 15) {
        _shaking = false;
        _target.x = _origin_x; // Ensure it returns to its original position
        instance_destroy(); // Remove this shaker object when done
    }
}