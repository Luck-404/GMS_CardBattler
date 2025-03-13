//////////////////////////////////////////////////////////////////////
//						OBJ_CREATURE CREATE							//
//																	//
// > CREATE A CREATURE BASED ON A REFERENCE. THIS CREATURE ONLY		//
//   EXISTS IN THE ENCOUNTER										//
//////////////////////////////////////////////////////////////////////

//DEFINITIONS
_party_position = 0;
_creature_name = "Wraith";
_creature_champion = false;
_creature_color1 = "Uncolored";
_creature_color2 = "None";
_creature_subtype = "None";
_creature_team = "Player";
_creature_breed = "Default";
_creature_hp_max = 50;
_creature_hp_current = 50;
_creature_spec = "Any";
_creature_class = "Any";
_creature_minion_count = 0;
_creature_minion_limit = 3;
_creature_minion_references = ds_list_create();
_creature_gear = ds_list_create(); //can start with these if wanted
_creature_markings = ds_list_create(); //can start with these if wanted
_creature_sprite = spr_creature_uncolored_wraith;
_creature_hurtsound = snd_creature_wraith_hurt;
_creature_deathsound = snd_creature_wraith_death;
_creature_defaultsound = snd_creature_wraith_default;
_creature_def = 0;
_creature_position = 0;
_left_unit = undefined;
_right_unit = undefined;

//STATS
_creature_attack_scalar = 1;
_creature_attack_linear = 0;
_creature_vulnerability_scalar = 1;
_creature_vulnerability_linear = 0;

//FLAGS
_active = false;
_selected_channel = false;
_selected_target = false;
_flag_has_died = false;
_card_to_play = undefined; //ENEMIES ONLY

//ENEMY DECK INFO
_deck = ds_list_create();
_discard = ds_list_create();
_card_selected = undefined;

////////////////////
// STATUS EFFECTS //
////////////////////
_creature_statuses = ds_list_create();

//general statuses
_status_antiheal = false; //scr_status_antiheal_tick - lifetime 2 //unstack able
_status_armorbreak = false; //scr_status_armorbreak_tick - lifetime 2 //unstackable
//_status_banished = false; //scr_status_banished_tick - lifetime 3 //unstackable
//_status_blackblooded = false; //scr_status_blackblooded_tick - lifetime 3 //stackable
_status_bleeding = false; //scr_status_bleeding_tick - lifetime 3 //stackable
//_status_blinded = false; //scr_status_blinded_tick - lifetime 2 //unstackable
//_status_burned = false; //scr_status_burned_tick - lifetime 3 //stackable
//_status_charred = false; //scr_status_charred_tick - lifetime 3 //stackable
//_status_charmed = false; //scr_status_charmed_tick - lifetime 5 //unstackable
//_status_confused = false; //scr_status_confused_tick - lifetime 5  //unstackable
//_status_disabled = false; //scr_status_disabled_tick - lifetime 5 //unstackable
//_status_divine_protect = false; //scr_status_divine_protect_tick - lifetime 999 //unstackable, (1 charge max) //scr_status_divine_protect_checker
//_status_frozen = false; //scr_status_frozen_tick - lifetime 3 //stackable
//_status_frostbitten = false; //scr_status_frostbitten _tick - lifetime 3 //stackable
//_status_holy_fire = false; //scr_status_holy_fire_tick - lifetime 3 //stackable
//_status_leyshocked = false; //scr_status_leyshocked_tick - lifetime 3 //stackable
//_status_muddled = false; //scr_status_muddled_tick - lifetime 2 //unstackable
//_status_necrosis = false; //scr_status_necrosis_tick - lifetime 3 //stackable
_status_poisoned = false; //scr_status_poisoned_tick - lifetime 3 //stackable
//_status_polymorphed = false; //scr_status_polymorphed_tick - lifetime 5 //unstackable
//_status_radiant = false; //scr_status_radiant_tick - lifetime 3 //stackable
//_status_shaking = false; //scr_status_shaking_tick - lifetime 2 //unstackable
//_status_silenced = false; //scr_status_silenced_tick - lifetime 3 //unstackable
_status_sleeping = false; //scr_status_sleeping_tick - lifetime 2 //unstackable
//_status_smokescreen = false; //scr_status_smokescreen_tick - lifetime 5 //unstackable
//_status_spell_shield = false; //scr_status_antiheal_tick - lifetime 999 //unstackable, (1 charge max) //scr_status_spell_shield_checker
_status_stunned = false; //scr_status_stun_tick - lifetime 1 //unstackable
_status_taunting = false; //scr_status_taunt_tick - lifetime 3 //unstackable
_status_thorns = false; //scr_status_thorns_tick - lifetime 999 //stackable, (999 charge max) //scr_status_thorns_checker
_status_venom = false; //scr_status_venom_tick - lifetime 3 //stackable
//_status_voidtouched = false; //scr_status_voidtouched_tick - lifetime 3 //stackable
//_status_wildcharged = false; //scr_status_wildcharged_tick - lifetime 3 //stackable


