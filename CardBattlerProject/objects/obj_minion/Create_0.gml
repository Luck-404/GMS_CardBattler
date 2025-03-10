//////////////////////////////////////////////////////////////////////
//						OBJ_MINION CREATE							//
//																	//
// > CREATE A MINION FROM A SCRIPT									//
//////////////////////////////////////////////////////////////////////
show_debug_message("MINION ALIVE");
depth = -200;
_minion_hp_cur = 0;
_minion_hp_max = 0;
_minion_def = 0;
_flag_has_died = false;
_minion_color = "Uncolored";
_minion_name = "Any";
_minion_team = "Player";
_minion_cast_types = ["None","None","None"]; //Minion step, Host DMG Taken, Host DMG Dealt
_minion_sprite = spr_minion_life_spirit;
_minion_hurtsound = snd_creature_wraith_hurt;
_minion_deathsound = snd_creature_wraith_death;
_minion_defaultsound = snd_creature_wraith_default;
_minion_position = 0;
_minion_unit_attached = undefined;
_trigger_my_effect = false;
_minion_effect_script = undefined;
image_index = 1;
_host_damage_taken_trigger = "";
_keystr = "";