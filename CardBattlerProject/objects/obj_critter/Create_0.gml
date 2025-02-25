//////////////////////////////////////////////////////////////////////
//						OBJ_CRITTER CREATE							//
//																	//
// > ESTABLSH VARIABLE DEFINITIONS									//
//////////////////////////////////////////////////////////////////////
image_index = choose(0,1,2,3); //RANDOMLY CHOOSE AN ANIMAL
image_speed = 0;
_life = 60; //1s lifespan
_triggered = false;
_runx_direction = choose(-1,1);
_runy_direction = choose(-1,1);
_spd = 1;