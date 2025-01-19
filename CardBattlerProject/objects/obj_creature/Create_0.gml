///////////////
// VARIABLES //
///////////////
_creature_name = "Wraith";
_creature_champion = false;
_creature_color1 = "Uncolored";
_creature_color2 = "None";
_creature_subtype = "None";
_creature_team = "Ally";
_creature_breed = "Default";
_creature_hp_max = 50;
_creature_hp_current = 50;
_creature_spec = "All";
_creature_class = "All";
_creature_gear = ds_list_create(); //can start with these if wanted
_creature_markings = ds_list_create(); //can start with these if wanted
_creature_sprite = spr_creature_uncolored_wraith;
_creature_hurtsound = snd_creature_wraith_hurt;
_creature_deathsound = snd_creature_wraith_death;
_creature_defaultsound = snd_creature_wraith_default;
_creature_def = 0;
_creature_position = 0;
_flag_has_died = false;
_creature_attack_scalar = 1;
_creature_attack_linear = 0;