// Check if player is touching the grass and it's not already triggered
if (place_meeting(x, y, obj_player) && !_touched) {
    _touched = true;      // Mark grass as touched
    image_speed = 10;     // Start the shaking animation
}

// If grass has been touched, run the counter
if (_touched) {
	
	//var randnum = irandom(4);
	//for (i = 0; i < randnum; i++){
	//	var randx = irandom_range(-5,5);
	//	var randy = irandom_range(-5,5);
	//	var leaf = instance_create_layer(x+randx,y+randy,"Terrain",obj_leaf);
	//	leaf.hsp = randx;
	//	leaf.vspd = randy;
	//}
	
    if (_counter > 0) {
        _counter--;       // Countdown the timer
    } else {
        image_speed = 0;  // Stop the shaking animation
        _touched = false; // Reset touch state
        _counter = 60;    // Reset the counter for future use
    }
}