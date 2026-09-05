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

//------//
//MANA//
//------//
_val_cur_mana = 3;
_val_max_mana = 3;
_val_saved_max_mana = 3;

//---------//
//MANA HUD//
//---------//
_arr_mana_positions = [];

_ct_mana_per_row = 5;

_val_mana_orb_size = 51;
_val_mana_orb_gap = 4;

_val_mana_start_x = 40;
_val_mana_start_y = 40;

_val_mana_orb_scale = 1;

// CARD FLOW
_ct_hand_size = 5;
_ct_draw_amount = 2;


//----------//
//TUTOR FLOW//
//----------//
_ct_utility_tutors_pending = 0;

//--------------------//
//CARD EFFECT DISCARD//
//--------------------//
_ct_effect_discards_pending = 0;

// BATTLE GLOBALS
global.ref_cast_card = undefined;
global.ref_caster_beast = undefined;
global.ref_target_beast = undefined;
global.ref_target_card = undefined;
global.flag_thorns_retaliating = false;
global.ref_target_corpse = undefined;

// TARGET PREVIEW
_arr_target_preview = [];

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

//--------//
//PRISMS//
//--------//

//-----------//
//PRISM FLOW//
//-----------//
_stct_selected_prism = undefined;

//--------------------//
//PRISM BUTTON LAYOUT//
//--------------------//
_val_prism_button_x1 =
	20;

_val_prism_button_x2 =
	160;

_val_prism_button_y2 =
	room_height - 300;

_val_prism_button_y1 =
	_val_prism_button_y2 - 40;

// TURN START ITEMS
_flag_turn_start_items_init = false;
_flag_turn_start_items_complete = false;
_list_turn_start_items = undefined;

// TURN END ITEMS
_flag_turn_end_items_init = false;
_flag_turn_end_items_complete = false;
_list_turn_end_items = undefined;

// EXTRA TURN FLOW
_flag_extra_turn_pending = false;
_flag_begin_extra_turn = false;

enum ENUM_PLAYER_STATE{
	INIT_BEASTS,
	INIT_CARDS,
	WAIT,
	TURN_START,
	TRIGGER_MINIONS,
	SELECT_CARD,
	SELECT_PRISM,
	SELECT_PRISM_TARGET,
	SELECT_CASTER,
	SELECT_TARGET,
	SELECT_ENEMY_CARD,
	SELECT_CORPSE,
	CARD_EXECUTE,
	TUTOR_SELECT,	
	TURN_END,
	DISCARD_EFFECT,
	DISCARD_DOWN
}

_state_player = ENUM_PLAYER_STATE.INIT_BEASTS;

// CLICK COOLDOWN
_flag_clicked = false;
_val_cooldown = 10;

//----//
//INIT//
//----//
//----------------//
//POSITION MANA HUD//
//----------------//
scr_reposition_mana();

//-------//
//METHODS//
//-------//

//—------------------------------------------------------------------------------//
// hscr_open_utility_tutor
// FUNCTION: Opens the battle Tutor GUI when Utility cards exist in the draw pile.
//           Displays feedback and clears pending requests when none remain.
//
// RETURNS: TRUE when Tutor GUI opens.
//          FALSE when there are no valid Utility cards.
//
//—------------------------------------------------------------------------------//
hscr_open_utility_tutor = function(){

	if (_ct_utility_tutors_pending <= 0){
		return false;
	}

	//-------------------//
	//GET UTILITY CARDS//
	//-------------------//
	var _arr_candidates =
		scr_get_tutor_candidates("UTILITY");

	//-------------------------//
	//NO UTILITY CARDS FOUND//
	//-------------------------//
	if (array_length(_arr_candidates) <= 0){

		_ct_utility_tutors_pending = 0;

		scr_spawn_popup_scrolling(
			"TEXT",
			"NO UTILITY CARDS FOUND",
			undefined,
			c_aqua,
			room_width * 0.5,
			room_height * 0.5
		);

		return false;
	}

	//---------------//
	//OPEN TUTOR GUI//
	//---------------//
	var _ref_tutor =
		instance_create_layer(
			room_width * 0.5,
			room_height * 0.5,
			"ily_fx",
			obj_gui_battle_tutor
		);

	_ref_tutor.hscr_tutor_init(_arr_candidates);

	return true;
};

//—------------------------------------------------------------------------------//
// hscr_request_utility_tutor
// FUNCTION: Adds one or more pending Utility Tutor selections.
//           Requests accumulate so Echoed Tutor cards resolve sequentially.
//—------------------------------------------------------------------------------//
hscr_request_utility_tutor = function(_ct_amount){

	if (_ct_amount <= 0){
		return;
	}

	_ct_utility_tutors_pending +=
		floor(_ct_amount);
};

//—------------------------------------------------------------------------------//
// hscr_request_card_discard
// FUNCTION: Adds a pending card-effect discard requirement.
//           Allows repeated or Echoed effects to accumulate discard requests.
//—------------------------------------------------------------------------------//
hscr_request_card_discard = function(_ct_amount){

	if (_ct_amount <= 0){
		return;
	}

	_ct_effect_discards_pending +=
		floor(_ct_amount);
};

//—------------------------------------------------------------------------------//
// hscr_finish_player_turn
// FUNCTION: Finishes the active player turn.
//           Starts a pending extra player turn when available.
//           Otherwise passes turn control to the enemy.
//—------------------------------------------------------------------------------//
hscr_finish_player_turn = function(){

	_state_player = ENUM_PLAYER_STATE.WAIT;

	//-----------------//
	// EXTRA TURN
	//-----------------//
	if (_flag_extra_turn_pending){

		_flag_extra_turn_pending = false;
		_flag_begin_extra_turn = true;

		scr_spawn_popup_trigger_banner(
			"CHRONO: EXTRA TURN"
		);

		return;
	}

	//-----------------//
	// NORMAL TURN PASS
	//-----------------//
	obj_battle_turn_controller.hscr_pass_turn();
};

//—------------------------------------------------------------------------------//
// hscr_is_mouse_in_box
// FUNCTION: Returns whether a gui mouse point is inside a rectangle.
//—------------------------------------------------------------------------------//
function hscr_is_mouse_in_box(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2){
	return (_val_mouse_x >= _val_x1 && _val_mouse_x <= _val_x2 && _val_mouse_y >= _val_y1 && _val_mouse_y <= _val_y2);
}

//—------------------------------------------------------------------------------//
// hscr_get_prism_stacks
// FUNCTION: Returns an array of prism item stacks from player inventory.
//—------------------------------------------------------------------------------//
function hscr_get_prism_stacks(){

	var _arr_prisms = [];

	for (var _it_item = 0; _it_item < ds_list_size(global.list_player_inventory); _it_item++){

		var _stct_item = ds_list_find_value(global.list_player_inventory,_it_item);

		if (_stct_item == undefined){
			continue;
		}

		if (_stct_item._str_item_type != "PRISM"){
			continue;
		}

		if (_stct_item._ct_item_amount <= 0){
			continue;
		}

		array_push(_arr_prisms,_stct_item);
	}

	return _arr_prisms;
}

//—------------------------------------------------------------------------------//
// hscr_check_prism_targets
// FUNCTION: Marks enemy beasts as valid prism targets.
//           Clears player beasts as invalid targets.
//—------------------------------------------------------------------------------//
function hscr_check_prism_targets(){

	for (var _it_player = 0; _it_player < ds_list_size(_list_beasts_alive); _it_player++){

		var _ref_player_beast = ds_list_find_value(_list_beasts_alive,_it_player);

		if (instance_exists(_ref_player_beast)){
			_ref_player_beast._flag_beast_range_check = false;
		}
	}

	for (var _it_enemy = 0; _it_enemy < ds_list_size(obj_battle_enemy_controller._list_beasts_alive); _it_enemy++){

		var _ref_enemy_beast = ds_list_find_value(obj_battle_enemy_controller._list_beasts_alive,_it_enemy);

		if (instance_exists(_ref_enemy_beast)){
			_ref_enemy_beast._flag_beast_range_check = true;
		}
	}
}

//—------------------------------------------------------------------------------//
// hscr_draw_prism_button
// FUNCTION: Draws the battle prism button.
//—------------------------------------------------------------------------------//
function hscr_draw_prism_button(){

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _flag_hover = hscr_is_mouse_in_box(
		_val_mouse_x,
		_val_mouse_y,
		_val_prism_button_x1,
		_val_prism_button_y1,
		_val_prism_button_x2,
		_val_prism_button_y2
	);

	draw_set_font(fnt_medium_gui);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_set_colour(_flag_hover || _state_player == ENUM_PLAYER_STATE.SELECT_PRISM || _state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET ? c_white : global.c_dk_gray);
	draw_rectangle(_val_prism_button_x1,_val_prism_button_y1,_val_prism_button_x2,_val_prism_button_y2,false);

	draw_set_colour(c_black);
	draw_rectangle(_val_prism_button_x1,_val_prism_button_y1,_val_prism_button_x2,_val_prism_button_y2,true);

	draw_text((_val_prism_button_x1 + _val_prism_button_x2) * 0.5,(_val_prism_button_y1 + _val_prism_button_y2) * 0.5,"PRISMS");

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

//—------------------------------------------------------------------------------//
// hscr_draw_prism_menu
// FUNCTION: Draws available prism stacks while selecting a prism.
//—------------------------------------------------------------------------------//
function hscr_draw_prism_menu(){

	if (_state_player != ENUM_PLAYER_STATE.SELECT_PRISM){
		return;
	}

	var _arr_prisms = hscr_get_prism_stacks();

	draw_set_font(fnt_small_gui);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	if (array_length(_arr_prisms) <= 0){
		draw_set_colour(c_black);
		draw_text(room_width * 0.5,560,"NO PRISMS");
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		return;
	}

	var _val_slot_w = 150;
	var _val_slot_h = 85;
	var _val_gap = 10;

	var _ct_prisms = array_length(_arr_prisms);
	var _val_total_w = (_ct_prisms * _val_slot_w) + ((_ct_prisms - 1) * _val_gap);

	var _val_start_x = room_width * 0.5 - (_val_total_w * 0.5);
	var _val_y = 520;

	for (var _it_prism = 0; _it_prism < _ct_prisms; _it_prism++){

		var _stct_item = _arr_prisms[_it_prism];

		var _val_x1 = _val_start_x + (_it_prism * (_val_slot_w + _val_gap));
		var _val_y1 = _val_y;
		var _val_x2 = _val_x1 + _val_slot_w;
		var _val_y2 = _val_y1 + _val_slot_h;

		var _val_mouse_x = device_mouse_x_to_gui(0);
		var _val_mouse_y = device_mouse_y_to_gui(0);

		var _flag_hover = hscr_is_mouse_in_box(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2);

		draw_set_colour(_flag_hover ? c_white : global.c_dk_gray);
		draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,false);

		draw_set_colour(c_black);
		draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,true);

		draw_sprite_ext(_stct_item._spr_item,0,_val_x1 + 25,_val_y1 + 35,1.5,1.5,0,c_white,1);

		draw_set_colour(c_black);
		draw_text(_val_x1 + (_val_slot_w * 0.5),_val_y1 + 12,string(_stct_item._str_item_name));
		draw_text(_val_x1 + (_val_slot_w * 0.5),_val_y1 + 34,"x" + string(_stct_item._ct_item_amount));

		var _stct_prism_info = scr_get_prism_info(_stct_item._str_item_id);

		if (_stct_prism_info != undefined){
			draw_text(_val_x1 + (_val_slot_w * 0.5),_val_y1 + 54,"+" + string(_stct_prism_info._val_tame_bonus) + "% | " + string(_stct_prism_info._val_mana_cost) + " MANA");
		}
	}

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

//—------------------------------------------------------------------------------//
// hscr_handle_prism_menu_input
// FUNCTION: Handles click input for selecting a prism stack.
//—------------------------------------------------------------------------------//
function hscr_handle_prism_menu_input(){

	var _arr_prisms = hscr_get_prism_stacks();

	if (array_length(_arr_prisms) <= 0){
		return;
	}

	var _val_slot_w = 150;
	var _val_slot_h = 85;
	var _val_gap = 10;

	var _ct_prisms = array_length(_arr_prisms);
	var _val_total_w = (_ct_prisms * _val_slot_w) + ((_ct_prisms - 1) * _val_gap);

	var _val_start_x = room_width * 0.5 - (_val_total_w * 0.5);
	var _val_y = 520;

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	for (var _it_prism = 0; _it_prism < _ct_prisms; _it_prism++){

		var _val_x1 = _val_start_x + (_it_prism * (_val_slot_w + _val_gap));
		var _val_y1 = _val_y;
		var _val_x2 = _val_x1 + _val_slot_w;
		var _val_y2 = _val_y1 + _val_slot_h;

		if (hscr_is_mouse_in_box(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2)){

			_stct_selected_prism = _arr_prisms[_it_prism];

			hscr_check_prism_targets();

			_state_player = ENUM_PLAYER_STATE.SELECT_PRISM_TARGET;

			return;
		}
	}
}

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

function hscr_check_battle_beast_color(_list_beast_check){

	var _arr_card_colors =
		global.ref_cast_card._ref_card._arr_card_colors;

	var _str_card_color_1 = _arr_card_colors[0];
	var _str_card_color_2 = _arr_card_colors[1];

	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(_list_beast_check);
		_it_beast++
	){

		var _ref_beast = ds_list_find_value(
			_list_beast_check,
			_it_beast
		);

		//------------------------//
		// MALLEABILITY OVERRIDE
		//------------------------//
		if (_ref_beast._flag_ignore_caster_requirements){

			_ref_beast._flag_beast_color_check = true;

			continue;
		}

		var _arr_beast_colors =
			_ref_beast._ref_unit._arr_beast_colors;

		var _str_beast_color_1 = _arr_beast_colors[0];
		var _str_beast_color_2 = _arr_beast_colors[1];

		var _flag_match = false;

		if (
			_str_card_color_1 == "UNCOLORED" ||
			_str_beast_color_1 == "UNCOLORED" ||
			_str_beast_color_2 == "UNCOLORED"
		){
			_flag_match = true;
		}
		else{

			if (
				_str_card_color_1 != undefined &&
				(
					_str_card_color_1 == _str_beast_color_1 ||
					_str_card_color_1 == _str_beast_color_2
				)
			){
				_flag_match = true;
			}

			if (
				_str_card_color_2 != undefined &&
				(
					_str_card_color_2 == _str_beast_color_1 ||
					_str_card_color_2 == _str_beast_color_2
				)
			){
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
		
		//------------------------//
		// MALLEABILITY OVERRIDE
		//------------------------//
		if (_ref_beast._flag_ignore_caster_requirements){

			_ref_beast._flag_beast_color_check = true;

			continue;
		}

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
		
		//------------------------//
		// MALLEABILITY OVERRIDE
		//------------------------//
		if (_ref_beast._flag_ignore_caster_requirements){

			_ref_beast._flag_beast_color_check = true;

			continue;
		}
		
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
//           Updates player and enemy Beast range flags.
//           Applies Taunt targeting overrides to hostile Attacks.
//           Applies Blind restrictions while preserving valid Taunt behavior.
//—------------------------------------------------------------------------------//
function hscr_check_battle_beast_range(_list_beast_check,_str_range){

	//----------------//
	//PLAYER TEAM//
	//----------------//
	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beast_check); _it_beast++){

		var _ref_beast_player = ds_list_find_value(_list_beast_check,_it_beast);

		if (!instance_exists(_ref_beast_player)){
			continue;
		}

		switch(_str_range){

			case "SELF":
				_ref_beast_player._flag_beast_range_check =
					(_ref_beast_player == global.ref_caster_beast);
			break;

			case "MELEE":
				_ref_beast_player._flag_beast_range_check = true;
			break;

			case "TEAM":
				_ref_beast_player._flag_beast_range_check =
					(_ref_beast_player != global.ref_caster_beast);
			break;

			case "ENEMY":
				_ref_beast_player._flag_beast_range_check = false;
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


	//----------------//
	//ENEMY TEAM//
	//----------------//
	var _list_enemy =
		obj_battle_enemy_controller._list_beasts_alive;

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_enemy); _it_beast++){

		var _ref_beast_enemy =
			ds_list_find_value(_list_enemy,_it_beast);

		if (!instance_exists(_ref_beast_enemy)){
			continue;
		}

		switch(_str_range){

			case "SELF":
				_ref_beast_enemy._flag_beast_range_check = false;
			break;

			case "MELEE":
				_ref_beast_enemy._flag_beast_range_check =
					(_it_beast == 0);
			break;

			case "RANGED":
				_ref_beast_enemy._flag_beast_range_check = true;
			break;

			case "ENEMY":
				_ref_beast_enemy._flag_beast_range_check = true;
			break;

			case "TEAM":
				_ref_beast_enemy._flag_beast_range_check = false;
			break;

			case "BACK":
				_ref_beast_enemy._flag_beast_range_check =
					(_it_beast == ds_list_size(_list_enemy) - 1);
			break;

			default:
				_ref_beast_enemy._flag_beast_range_check = false;
			break;
		}
	}


	//----------------------//
	//GET ACTIVE CARD DATA//
	//----------------------//
	if (
		!instance_exists(global.ref_cast_card) ||
		!instance_exists(global.ref_caster_beast)
	){
		return;
	}

	var _stct_card =
		global.ref_cast_card._ref_card;

	if (!is_struct(_stct_card)){
		return;
	}


	//--------------------//
	//CHECK HOSTILE ATTACK//
	//--------------------//
	var _flag_hostile_attack =
		(
			_stct_card._str_card_type == "ATTACK" ||
			_stct_card._str_card_effect_type == "DOT"
		);

	if (!_flag_hostile_attack){
		return;
	}


	//----------------//
	//GET TAUNT TARGET//
	//----------------//
	var _ref_taunt_target =
		scr_get_taunt_target(_list_enemy);


	//----------------//
	//GET BLIND MODE//
	//----------------//
	var _str_blind_mode =
		scr_get_blind_attack_target_mode(
			global.ref_caster_beast,
			_stct_card
		);


	//=======================================================================//
	//
	// BLIND: BLOCK
	//
	// Flank / Backline Attacks cannot be used while Blinded.
	// Taunt does not override this restriction.
	//
	//=======================================================================//
	if (_str_blind_mode == "BLOCK"){

		//----------------//
		//DISABLE ALLIES//
		//----------------//
		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beast_check); _it_beast++){

			var _ref_beast =
				ds_list_find_value(
					_list_beast_check,
					_it_beast
				);

			if (instance_exists(_ref_beast)){
				_ref_beast._flag_beast_range_check = false;
			}
		}

		//----------------//
		//DISABLE ENEMIES//
		//----------------//
		for (var _it_enemy = 0; _it_enemy < ds_list_size(_list_enemy); _it_enemy++){

			var _ref_enemy =
				ds_list_find_value(
					_list_enemy,
					_it_enemy
				);

			if (instance_exists(_ref_enemy)){
				_ref_enemy._flag_beast_range_check = false;
			}
		}

		return;
	}


	//=======================================================================//
	//
	// BLIND: FRONT
	//
	// Ordinary hostile Attacks behave as though they can only target
	// the front enemy Beast.
	//
	// If the front Beast is Taunting, Taunt still works normally.
	//
	// If a different Beast is Taunting, Blind prevents the caster from
	// targeting that Beast, so the front Beast remains the valid target.
	//
	//=======================================================================//
	if (_str_blind_mode == "FRONT"){

		//----------------//
		//DISABLE ALLIES//
		//----------------//
		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beast_check); _it_beast++){

			var _ref_beast =
				ds_list_find_value(
					_list_beast_check,
					_it_beast
				);

			if (instance_exists(_ref_beast)){
				_ref_beast._flag_beast_range_check = false;
			}
		}

		//----------------//
		//GET FRONT ENEMY//
		//----------------//
		var _ref_front_enemy =
			undefined;

		if (ds_list_size(_list_enemy) > 0){

			_ref_front_enemy =
				ds_list_find_value(
					_list_enemy,
					0
				);
		}

		//----------------------//
		//SET FRONT TARGET ONLY//
		//----------------------//
		for (var _it_enemy = 0; _it_enemy < ds_list_size(_list_enemy); _it_enemy++){

			var _ref_enemy =
				ds_list_find_value(
					_list_enemy,
					_it_enemy
				);

			if (!instance_exists(_ref_enemy)){
				continue;
			}

			_ref_enemy._flag_beast_range_check =
				(_ref_enemy == _ref_front_enemy);
		}

		/*
			TAUNT + BLIND INTERACTION:

			If the Taunting Beast is the front Beast, it is already
			the only valid target, so Taunt works normally.

			If the Taunting Beast is not the front Beast, Blind prevents
			the caster from targeting it. The front Beast therefore
			remains the only valid target.
		*/

		return;
	}


	//=======================================================================//
	//
	// NORMAL TAUNT
	//
	// No Blind restriction is active.
	// Taunt retains its existing behavior and becomes the sole hostile
	// Attack target regardless of the card's normal range.
	//
	//=======================================================================//
	if (instance_exists(_ref_taunt_target)){

		for (var _it_enemy = 0; _it_enemy < ds_list_size(_list_enemy); _it_enemy++){

			var _ref_enemy =
				ds_list_find_value(
					_list_enemy,
					_it_enemy
				);

			if (!instance_exists(_ref_enemy)){
				continue;
			}

			_ref_enemy._flag_beast_range_check =
				(_ref_enemy == _ref_taunt_target);
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
// FUNCTION: Flags Beasts as unable to act while affected by action-locking CC.
//           Stun, Sleep, and Frozen prevent actions.
//           Other CC types retain their own specialized restrictions.
//—------------------------------------------------------------------------------//
function hscr_check_battle_beast_able(_list_beast_check){

	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(_list_beast_check);
		_it_beast++
	){

		var _ref_beast =
			ds_list_find_value(
				_list_beast_check,
				_it_beast
			);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		_ref_beast._flag_beast_able_check =
			!scr_is_beast_action_locked(
				_ref_beast
			);
	}
}