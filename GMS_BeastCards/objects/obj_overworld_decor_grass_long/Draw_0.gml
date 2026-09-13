//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_DECOR_GRASS
// FUNCTION: Draws inherited overworld decor visuals.
//           Plays grass rustle audio while the player moves through the grass.
//           Prevents the grass rustle sound from overlapping itself.
//
//===============================================================================//

//================//
//DRAW DECOR//
//================//
event_inherited();

//================//
//GRASS RUSTLE//
//================//
if (instance_exists(obj_player) && place_meeting(x,y,obj_player)){

	if (obj_player._flag_player_moving && !audio_is_playing(snd_overworld_grass_rustle)){
		audio_play_sound(snd_overworld_grass_rustle,0,false);
	}
}