//////////////////////////////////////////////////////////////////////
//							OBJ_CONE STEP							//
//																	//
// > DIE QUICKLY													//
//////////////////////////////////////////////////////////////////////
if (_life > 0) {
    x += hsp;            // Drift horizontally
    y += vspd;           // Fall vertically
    image_angle += spin; // Rotate slightly
    _life--;
	image_alpha = _life / (_life + 1); // Fade as life decreases
} else {
    instance_destroy();
}