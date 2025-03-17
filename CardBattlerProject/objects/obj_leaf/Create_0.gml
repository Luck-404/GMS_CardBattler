//////////////////////////////////////////////////////////////////////
//							OBJ_LEAF CREATE							//
//																	//
// > SPAWN A LEAD WHEN A PLAYER TOUCHES BUSH/GRASS					//
//////////////////////////////////////////////////////////////////////
vspd = random_range(1, 2); // Random vertical speed for falling
hsp = random_range(-1, 1); // Small horizontal drift
_life = 20 + irandom(30);  // Randomized lifespan for more variation
image_angle = irandom(360); // Randomize rotation
spin = random_range(-2, 2); // Small spinning effect