//===============================================================================//
//
// CREATE: OBJ_BATTLE_BEAST
// FUNCTION: Initializes a battle beast instance.
//           Stores combat stats, status/minion/card lists, and unit reference.
//           Defines helper scripts for alive/dead battlefield positioning.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

// VISUAL / ID
_spr_beast = undefined;
_uid_beast = -1;

// TEAM / POSITION
_str_team = "PLAYER";
_str_list = "ALIVE";
_val_pos = -1;
_snd_cry = undefined;
_snd_death = undefined;
_stct_held_item = undefined;

// HP / DEFENSE
_val_cur_hp = 1;
_val_max_hp = 1;
_val_overhealth = 0;
_val_armor = 0;

// STATUS / MINIONS
_list_statuses = ds_list_create();

_ct_minions_max = 1;
_list_minions = ds_list_create();

// CARDS
_list_deck = ds_list_create();
_val_hand_pos = 0;

// UNIT REF
_ref_unit = undefined;
_flag_captured = false;
// STATE FLAGS
_flag_death_handled = false;
_flag_preview_beast = false;

// CASTING CHECKS
_flag_beast_color_check = true;
_flag_beast_archetype_check = true;
_flag_beast_class_check = true;
_flag_beast_range_check = true;
_flag_beast_able_check = true;
_flag_ignore_caster_requirements = false;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//

//—------------------------------------------------------------------------------//
// hscr_get_battle_x
// FUNCTION: Returns the active battle x-position for a beast by team and position.
//—------------------------------------------------------------------------------//
function hscr_get_battle_x(_str_team_check,_val_pos_check){

	if (_str_team_check == "PLAYER"){
		return room_width * 0.5 - 80 - (100 * _val_pos_check);
	}
	else{
		return room_width * 0.5 + 80 + (100 * _val_pos_check);
	}
}

//—------------------------------------------------------------------------------//
// hscr_get_dead_x
// FUNCTION: Returns the graveyard x-position for a dead beast by team and position.
//—------------------------------------------------------------------------------//
function hscr_get_dead_x(_str_team_check,_ct_alive,_val_dead_pos){

	if (_str_team_check == "PLAYER"){
		return room_width * 0.5 - 80 - (100 * (_ct_alive + _val_dead_pos));
	}
	else{
		return room_width * 0.5 + 80 + (100 * (_ct_alive + _val_dead_pos));
	}
}