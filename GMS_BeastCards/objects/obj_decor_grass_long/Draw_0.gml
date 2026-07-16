//===============================================================================//
//
// DRAW: OBJ_DECOR_GRASS
// FUNCTION: Draws the grass sprite and ground shadow.
//           Plays grass rustle audio while the player moves through the grass.
//           Prevents the grass rustle sound from overlapping itself.
//
//===============================================================================//
event_inherited();
//----//
//DRAW//
//----//
draw_sprite_ext(spr_decor_shadow,image_index,x,y,_val_shadow_scalar,_val_shadow_scalar,0,c_white,1);
draw_self();

//------------//
//GRASS RUSTLE//
//------------//
if (instance_exists(obj_player) && place_meeting(x,y,obj_player))
{
if (obj_player._flag_player_moving && !audio_is_playing(snd_grass_rustle))
{
audio_play_sound(snd_grass_rustle,0,false);
}
}
