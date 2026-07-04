//===============================================================================//
//
// CREATE: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Initializes player battle state.
//           Stores mana, beast lists, battle card piles, and status trackers.
//           Defines helper methods for card and beast validity checks.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

// MANA
_val_cur_mana = 3;
_val_max_mana = 3;
_val_saved_max_mana = 3;

// CARD FLOW
_ct_hand_size = 5;
_ct_draw_amount = 2;

// BATTLE GLOBALS
global.ref_cast_card = undefined;
global.ref_caster_beast = undefined;
global.ref_target_beast = undefined;

global.ct_echo = 0;

// MINIONS
_flag_minions_init = false;
_list_casting_minions = undefined;

// STATUSES
global.list_statuses = ds_list_create();

_flag_statuses_init = false;
_list_statuses = undefined;

// BEASTS
_list_beasts = ds_list_create();
_list_beasts_alive = ds_list_create();
_list_beasts_graveyard = ds_list_create();

// DECK
_list_battle_deck = ds_list_create();
_list_battle_hand = ds_list_create();
_list_battle_discard = ds_list_create();
_list_battle_exhaust = ds_list_create();

// PLAYER STATE
enum ENUM_PLAYER_STATE{
	INIT_BEASTS,
	INIT_CARDS,
	TRIGGER_ENTRY_EFFECTS,
	WAIT,
	TURN_START,
	TRIGGER_MINIONS,
	SELECT_CARD,
	SELECT_CASTER,
	SELECT_TARGET,
	CARD_EXECUTE,
	TURN_END,
	DISCARD_DOWN
}

_state_player = ENUM_PLAYER_STATE.INIT_BEASTS;

// CLICK COOLDOWN
_flag_clicked = false;
_val_cooldown = 10;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//

//—------------------------------------------------------------------------------//
// hscr_check_battle_card_oom
// FUNCTION: Flags cards as uncastable when their mana cost exceeds current mana.
//—------------------------------------------------------------------------------//
function hscr_check_battle_card_oom(_list_cards){

	for (var _it_card = 0; _it_card < ds_list_size(_list_cards); _it_card++){

		var _ref_card = ds_list_find_value(_list_cards,_it_card);
		var _val_card_cost = _ref_card._ref_card._val_card_mana_cost;

		if (_val_card_cost <= _val_cur_mana){
			_ref_card._flag_card_oom_check = false;
		}
		else{
			_ref_card._flag_card_oom_check = true;
		}
	}
}

//—------------------------------------------------------------------------------//
// hscr_check_battle_beast_color
// FUNCTION: Checks whether each beast can cast the selected card by color.
//—------------------------------------------------------------------------------//
function hscr_check_battle_beast_color(_list_beast_check){

	var _arr_card_colors = global.ref_cast_card._ref_card._arr_card_colors;

	var _str_card_color_1 = _arr_card_colors[0];
	var _str_card_color_2 = _arr_card_colors[1];

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beast_check); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beast_check,_it_beast);
		var _arr_beast_colors = _ref_beast._ref_unit._arr_beast_colors;

		var _str_beast_color_1 = _arr_beast_colors[0];
		var _str_beast_color_2 = _arr_beast_colors[1];

		var _flag_match = false;

		if (_str_card_color_1 == "UNCOLORED" || _str_beast_color_1 == "UNCOLORED" || _str_beast_color_2 == "UNCOLORED"){
			_flag_match = true;
		}
		else{
			if (_str_card_color_1 != undefined && (_str_card_color_1 == _str_beast_color_1 || _str_card_color_1 == _str_beast_color_2)){
				_flag_match = true;
			}

			if (_str_card_color_2 != undefined && (_str_card_color_2 == _str_beast_color_1 || _str_card_color_2 == _str_beast_color_2)){
				_flag_match = true;
			}
		}

		_ref_beast._flag_beast_color_check = _flag_match;
	}
}

//—------------------------------------------------------------------------------//
// hscr_check_battle_beast_archetype
// FUNCTION: Checks whether each beast matches the selected card archetype requirement.
//—------------------------------------------------------------------------------//
function hscr_check_battle_beast_archetype(_list_beast_check){

	var _str_card_archetype = global.ref_cast_card._ref_card._str_card_archetype_req;

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beast_check); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beast_check,_it_beast);
		var _str_beast_archetype = _ref_beast._ref_unit._str_beast_archetype;

		if (_str_card_archetype == undefined || _str_card_archetype == _str_beast_archetype){
			_ref_beast._flag_beast_archetype_check = true;
		}
		else{
			_ref_beast._flag_beast_archetype_check = false;
		}
	}
}

//—------------------------------------------------------------------------------//
// hscr_check_battle_beast_class
// FUNCTION: Checks whether each beast matches the selected card class requirement.
//—------------------------------------------------------------------------------//
function hscr_check_battle_beast_class(_list_beast_check){

	var _str_card_class = global.ref_cast_card._ref_card._str_card_class_req;

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beast_check); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beast_check,_it_beast);
		var _str_beast_class = _ref_beast._ref_unit._str_beast_class;

		if (_str_card_class == undefined || _str_card_class == _str_beast_class){
			_ref_beast._flag_beast_class_check = true;
		}
		else{
			_ref_beast._flag_beast_class_check = false;
		}
	}
}

//—------------------------------------------------------------------------------//
// hscr_check_battle_beast_range
// FUNCTION: Checks valid targets based on selected card range.
//           Updates player and enemy beast range flags.
//—------------------------------------------------------------------------------//
function hscr_check_battle_beast_range(_list_beast_check,_str_range){

	// PLAYER TEAM
	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beast_check); _it_beast++){

		var _ref_beast_player = ds_list_find_value(_list_beast_check,_it_beast);

		switch(_str_range){

			case "SELF":
				_ref_beast_player._flag_beast_range_check = (_ref_beast_player == global.ref_caster_beast);
			break;

			case "MELEE":
				_ref_beast_player._flag_beast_range_check = true;
			break;

			case "TEAM":
				_ref_beast_player._flag_beast_range_check = (_ref_beast_player != global.ref_caster_beast);
			break;

			case "RANGED":
				_ref_beast_player._flag_beast_range_check = true;
			break;

			case "BACK":
				_ref_beast_player._flag_beast_range_check = true;
			break;

			default:
				_ref_beast_player._flag_beast_range_check = false;
			break;
		}
	}

	// ENEMY TEAM
	for (var _it_beast = 0; _it_beast < ds_list_size(obj_battle_enemy_controller._list_beasts_alive); _it_beast++){

		var _ref_beast_enemy = ds_list_find_value(obj_battle_enemy_controller._list_beasts_alive,_it_beast);

		switch(_str_range){

			case "SELF":
				_ref_beast_enemy._flag_beast_range_check = false;
			break;

			case "MELEE":
				_ref_beast_enemy._flag_beast_range_check = (_it_beast == 0);
			break;

			case "RANGED":
				_ref_beast_enemy._flag_beast_range_check = true;
			break;

			case "TEAM":
				_ref_beast_enemy._flag_beast_range_check = false;
			break;

			case "BACK":
				_ref_beast_enemy._flag_beast_range_check = (_it_beast == ds_list_size(obj_battle_enemy_controller._list_beasts_alive) - 1);
			break;

			default:
				_ref_beast_enemy._flag_beast_range_check = false;
			break;
		}
	}
}

//—------------------------------------------------------------------------------//
// hscr_reroll_hand
// FUNCTION: Discards current hand, draws new cards, and refreshes mana checks.
//—------------------------------------------------------------------------------//
function hscr_reroll_hand(){

	while (ds_list_size(_list_battle_hand) > 0){

		var _ref_card = ds_list_find_value(_list_battle_hand,0);
		scr_discard_card(_ref_card);
	}

	scr_draw_cards(_ct_draw_amount);
	hscr_check_battle_card_oom(_list_battle_hand);
}

//—------------------------------------------------------------------------------//
// hscr_check_battle_beast_able
// FUNCTION: Flags beasts as unable to act when stunned.
//—------------------------------------------------------------------------------//
function hscr_check_battle_beast_able(_list_beast_check){

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beast_check); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beast_check,_it_beast);

		var _ref_status = scr_check_for_status("STUN",_ref_beast);

		if (_ref_status != -1){
			_ref_beast._flag_beast_able_check = false;
		}
		else{
			_ref_beast._flag_beast_able_check = true;
		}
	}
}