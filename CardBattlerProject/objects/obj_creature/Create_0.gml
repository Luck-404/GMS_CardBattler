///////////////
// VARIABLES //
///////////////
_creature_name = "Wraith";
_creature_champion = false;
_creature_color1 = "Uncolored";
_creature_color2 = "None";
_creature_subtype = "None";
_creature_team = "Player";
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
_turn_available = true;
_creature_position = 0;
_active = false;
_selected_channel = false;
_selected_target = false;
_card_to_play = undefined;
_left_unit = undefined;
_right_unit = undefined;

_stunned = false;
_poison_count = 0;

_deck = ds_list_create();
_discard = ds_list_create();
_card_selected = undefined;