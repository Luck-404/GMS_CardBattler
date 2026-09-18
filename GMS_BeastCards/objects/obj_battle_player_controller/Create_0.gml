//===============================================================================//
//
// CREATE: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Initializes player battle state.
//           Stores Mana, Beast lists, battle Card piles, targeting state,
//           temporary turn queues, Prism state, and player battle helpers.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

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

//-----------//
//CARD FLOW//
//-----------//
_ct_opening_draw_amount = 4;
_ct_draw_amount = 2;
_ct_hand_size = 4;

_flag_skip_initial_turn_draw = true;

//----------//
//TUTOR FLOW//
//----------//
_ct_utility_tutors_pending = 0;

_str_tutor_card_type = "UTILITY";
_str_tutor_title = "ANCIENT CHARTS";

//================//
//REKINDLE FLOW//
//================//
_ct_rekindle_pending = 0;
_ref_rekindle_source_card = undefined;

//--------------------//
//CARD EFFECT DISCARD//
//--------------------//
_ct_effect_discards_pending = 0;

//----------------//
//BATTLE GLOBALS//
//----------------//
global.ref_cast_card = undefined;
global.ref_caster_beast = undefined;
global.ref_target_beast = undefined;
global.ref_target_card = undefined;
global.ref_target_corpse = undefined;
global.ref_icebreaker_target = undefined;

global.flag_thorns_retaliating = false;
global.flag_card_effect_resolving = false;
global.flag_frozen_curse_triggering = false;

//----------------//
//TARGET PREVIEW//
//----------------//
_arr_target_preview = [];

//---------//
//MINIONS//
//---------//
_flag_minions_init = false;
_list_casting_minions = undefined;

//----------//
//STATUSES//
//----------//
global.list_statuses = ds_list_create();

_flag_statuses_init = false;
_list_statuses = undefined;

//--------//
//BEASTS//
//--------//
_list_beasts = ds_list_create();
_list_beasts_alive = ds_list_create();
_list_beasts_graveyard = ds_list_create();

//-------------//
//CARD PILES//
//-------------//
_list_battle_deck = ds_list_create();
_list_battle_hand = ds_list_create();
_list_battle_discard = ds_list_create();
_list_battle_exhaust = ds_list_create();

//-------------//
//PRISM FLOW//
//-------------//
_stct_selected_prism = undefined;

//--------------------//
//PRISM BUTTON LAYOUT//
//--------------------//
_val_prism_button_x1 = 0;
_val_prism_button_x2 = 100;

_val_prism_button_y2 = 744;
_val_prism_button_y1 = 793;

//------------------//
//TURN START ITEMS//
//------------------//
_flag_turn_start_items_init = false;
_flag_turn_start_items_complete = false;

_list_turn_start_items = undefined;

//----------------//
//TURN END ITEMS//
//----------------//
_flag_turn_end_items_init = false;
_flag_turn_end_items_complete = false;

_list_turn_end_items = undefined;

//-----------------//
//EXTRA TURN FLOW//
//-----------------//
_flag_extra_turn_pending = false;
_flag_begin_extra_turn = false;

//----------------//
//CLICK COOLDOWN//
//----------------//
_flag_clicked = false;
_val_cooldown = 10;

#endregion

//----//
//INIT//
//----//
#region INIT

//--------------//
//PLAYER STATE//
//--------------//
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

//-----------------//
//POSITION MANA HUD//
//-----------------//
scr_battle_reposition_mana();

//================//
//CARD FLOW RULES//
//================//
var _stct_card_flow_rules = scr_battle_get_player_card_flow_rules();

_ct_opening_draw_amount = _stct_card_flow_rules._ct_opening_draw;
_ct_draw_amount = _stct_card_flow_rules._ct_turn_draw;
_ct_hand_size = _stct_card_flow_rules._ct_hand_size;

scr_debug_log(
	"BATTLE",
	"PLAYER",
	self,
	"PLAYER BATTLE CONTROLLER INITIALIZED" +
	" | MANA: " + string(_val_cur_mana) + "/" + string(_val_max_mana) +
	" | OPENING DRAW: " + string(_ct_opening_draw_amount) +
	" | TURN DRAW: " + string(_ct_draw_amount) +
	" | MAX HAND: " + string(_ct_hand_size),
	"INIT",
	"OBJ_BATTLE_PLAYER_CONTROLLER:CREATE"
);

#endregion

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_battle_open_utility_tutor
// FUNCTION: Opens the Tutor GUI using the requested primary Card Type.
//           Defaults to the existing Ancient Charts behavior.
//—------------------------------------------------------------------------------//
hscr_battle_open_utility_tutor = function(){

	//----------------//
	//VALIDATE QUEUE//
	//----------------//
	if (_ct_utility_tutors_pending <= 0){
		return false;
	}

	//================//
	//GET CANDIDATES//
	//================//
	var _arr_candidates = scr_battle_get_tutor_candidates(_str_tutor_card_type);

	//----------------//
	//NO CARDS FOUND//
	//----------------//
	if (array_length(_arr_candidates) <= 0){

		_ct_utility_tutors_pending = 0;

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NO " + _str_tutor_card_type + " CARDS FOUND",
			undefined,
			c_aqua,
			room_width * 0.5,
			room_height * 0.5
		);

		_str_tutor_card_type = "UTILITY";
		_str_tutor_title = "ANCIENT CHARTS";

		return false;
	}

	//================//
	//OPEN TUTOR GUI//
	//================//
	var _ref_tutor = instance_create_layer(
		room_width * 0.5,
		room_height * 0.5,
		"ily_fx",
		obj_gui_battle_tutor
	);

	_ref_tutor.hscr_gui_init_tutor(
		_arr_candidates,
		_str_tutor_card_type,
		_str_tutor_title
	);

	return true;
};

//—------------------------------------------------------------------------------//
// hscr_battle_request_utility_tutor
// FUNCTION: Queues Tutor selections for a specified primary Card Type.
//           Defaults preserve Ancient Charts.
//—------------------------------------------------------------------------------//
hscr_battle_request_utility_tutor = function(_ct_amount,_str_primary_card_type="UTILITY",_str_title="ANCIENT CHARTS"){

	//----------------//
	//VALIDATE AMOUNT//
	//----------------//
	_ct_amount = max(0,floor(_ct_amount));

	if (_ct_amount <= 0){
		return;
	}

	//================//
	//SET TUTOR CONFIG//
	//================//
	_str_tutor_card_type = _str_primary_card_type;
	_str_tutor_title = _str_title;

	//================//
	//QUEUE SELECTIONS//
	//================//
	_ct_utility_tutors_pending += _ct_amount;
};

//—------------------------------------------------------------------------------//
// hscr_battle_request_utility_tutor
// FUNCTION: Queues Tutor selections for a specified primary Card Type.
//           Defaults preserve Ancient Charts.
//—------------------------------------------------------------------------------//
hscr_battle_request_utility_tutor = function(_ct_amount,_str_primary_card_type="UTILITY",_str_title="ANCIENT CHARTS"){

	//----------------//
	//VALIDATE AMOUNT//
	//----------------//
	_ct_amount = max(0,floor(_ct_amount));

	if (_ct_amount <= 0){
		return;
	}

	//================//
	//SET TUTOR CONFIG//
	//================//
	_str_tutor_card_type = _str_primary_card_type;
	_str_tutor_title = _str_title;

	//================//
	//QUEUE SELECTIONS//
	//================//
	_ct_utility_tutors_pending += _ct_amount;
};

//—------------------------------------------------------------------------------//
// hscr_battle_request_card_discard
// FUNCTION: Adds pending Card-effect discard requirements.
//—------------------------------------------------------------------------------//
hscr_battle_request_card_discard = function(_ct_amount){

	if (_ct_amount <= 0){
		return;
	}

	_ct_effect_discards_pending += floor(_ct_amount);
};

//—------------------------------------------------------------------------------//
// HSCR_BATTLE_FINISH_PLAYER_TURN
// FUNCTION: Finishes the active player turn.
//           Begins a pending extra player turn when available.
//           Otherwise passes turn control through the battle turn controller.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//—------------------------------------------------------------------------------//
hscr_battle_finish_player_turn = function(){

	_state_player = ENUM_PLAYER_STATE.WAIT;

	//----------------//
	//EXTRA TURN//
	//----------------//
	if (_flag_extra_turn_pending){

		_flag_extra_turn_pending = false;
		_flag_begin_extra_turn = true;

		scr_debug_log(
			"BATTLE",
			"TURN",
			self,
			"ROUND " + string(obj_battle_turn_controller._ct_round) +
			" | PLAYER TURN COMPLETE -> EXTRA PLAYER TURN QUEUED",
			"BATTLE",
			"OBJ_BATTLE_PLAYER_CONTROLLER:HSCR_BATTLE_FINISH_PLAYER_TURN"
		);

		scr_gui_spawn_popup_trigger_banner("CHRONO: EXTRA TURN");

		return;
	}

	//-----------------//
	//NORMAL TURN PASS//
	//-----------------//
	obj_battle_turn_controller.hscr_battle_pass_turn();
};

//—------------------------------------------------------------------------------//
// hscr_battle_is_mouse_in_box
// FUNCTION: Returns whether a GUI-space mouse position is inside a rectangle.
//—------------------------------------------------------------------------------//
hscr_battle_is_mouse_in_box = function(_val_mouse_x,_val_mouse_y,_val_x1,_val_y1,_val_x2,_val_y2){
	return (
		_val_mouse_x >= _val_x1 &&
		_val_mouse_x <= _val_x2 &&
		_val_mouse_y >= _val_y1 &&
		_val_mouse_y <= _val_y2
	);
};

//—------------------------------------------------------------------------------//
// hscr_battle_get_prism_stacks
// FUNCTION: Returns available Prism item stacks from player inventory.
//—------------------------------------------------------------------------------//
hscr_battle_get_prism_stacks = function(){

	var _arr_prisms = [];

	var _ct_items = ds_list_size(global.list_player_inventory);

	for (var _it_item = 0; _it_item < _ct_items; _it_item++){

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
};

//—------------------------------------------------------------------------------//
// hscr_battle_check_prism_targets
// FUNCTION: Marks living enemy Beasts as valid Prism targets and player Beasts
//           as invalid Prism targets.
//—------------------------------------------------------------------------------//
hscr_battle_check_prism_targets = function(){

	//-----------------------//
	//DISABLE PLAYER TARGETS//
	//-----------------------//
	for (var _it_player = 0; _it_player < ds_list_size(_list_beasts_alive); _it_player++){

		var _ref_player_beast = ds_list_find_value(_list_beasts_alive,_it_player);

		if (instance_exists(_ref_player_beast)){
			_ref_player_beast._flag_beast_range_check = false;
		}
	}

	//----------------------//
	//ENABLE ENEMY TARGETS//
	//----------------------//
	var _list_enemies = obj_battle_enemy_controller._list_beasts_alive;

	for (var _it_enemy = 0; _it_enemy < ds_list_size(_list_enemies); _it_enemy++){

		var _ref_enemy_beast = ds_list_find_value(_list_enemies,_it_enemy);

		if (instance_exists(_ref_enemy_beast)){
			_ref_enemy_beast._flag_beast_range_check = true;
		}
	}
};

//—------------------------------------------------------------------------------//
// hscr_battle_draw_prism_button
// FUNCTION: Draws the battle Prism selection button.
//—------------------------------------------------------------------------------//
hscr_battle_draw_prism_button = function(){

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _flag_hover = hscr_battle_is_mouse_in_box(
		_val_mouse_x,
		_val_mouse_y,
		_val_prism_button_x1,
		_val_prism_button_y1,
		_val_prism_button_x2,
		_val_prism_button_y2
	);

	var _flag_active = (
		_state_player == ENUM_PLAYER_STATE.SELECT_PRISM ||
		_state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET
	);

	draw_set_font(fnt_gui_medium);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_set_colour((_flag_hover || _flag_active) ? c_white : global.c_dk_gray);

	draw_rectangle(
		_val_prism_button_x1,
		_val_prism_button_y1,
		_val_prism_button_x2,
		_val_prism_button_y2,
		false
	);

	draw_set_colour(c_black);

	draw_rectangle(
		_val_prism_button_x1,
		_val_prism_button_y1,
		_val_prism_button_x2,
		_val_prism_button_y2,
		true
	);

	draw_text(
		(_val_prism_button_x1 + _val_prism_button_x2) * 0.5,
		(_val_prism_button_y1 + _val_prism_button_y2) * 0.5,
		"PRISMS"
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
};

//—------------------------------------------------------------------------------//
// hscr_battle_draw_prism_menu
// FUNCTION: Draws available Prism stacks while the Prism menu is open.
//—------------------------------------------------------------------------------//
hscr_battle_draw_prism_menu = function(){

	if (_state_player != ENUM_PLAYER_STATE.SELECT_PRISM){
		return;
	}

	var _arr_prisms = hscr_battle_get_prism_stacks();

	draw_set_font(fnt_gui_small);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	//------------------//
	//NO PRISMS FOUND//
	//------------------//
	if (array_length(_arr_prisms) <= 0){

		draw_set_colour(c_black);
		draw_text(room_width * 0.5,560,"NO PRISMS");

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		return;
	}

	//-----------------//
	//LAYOUT SETTINGS//
	//-----------------//
	var _val_slot_w = 150;
	var _val_slot_h = 85;
	var _val_slot_gap = 10;

	var _ct_prisms = array_length(_arr_prisms);

	var _val_total_w =
		(_ct_prisms * _val_slot_w) +
		((_ct_prisms - 1) * _val_slot_gap);

	var _val_start_x = room_width * 0.5 - (_val_total_w * 0.5);
	var _val_start_y = 520;

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	//------------------//
	//DRAW PRISM STACKS//
	//------------------//
	for (var _it_prism = 0; _it_prism < _ct_prisms; _it_prism++){

		var _stct_item = _arr_prisms[_it_prism];

		var _val_x1 = _val_start_x + (_it_prism * (_val_slot_w + _val_slot_gap));
		var _val_y1 = _val_start_y;

		var _val_x2 = _val_x1 + _val_slot_w;
		var _val_y2 = _val_y1 + _val_slot_h;

		var _flag_hover = hscr_battle_is_mouse_in_box(
			_val_mouse_x,
			_val_mouse_y,
			_val_x1,
			_val_y1,
			_val_x2,
			_val_y2
		);

		draw_set_colour(_flag_hover ? c_white : global.c_dk_gray);
		draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,false);

		draw_set_colour(c_black);
		draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,true);

		draw_sprite_ext(
			_stct_item._spr_item,
			0,
			_val_x1 + 25,
			_val_y1 + 35,
			1.5,
			1.5,
			0,
			c_white,
			1
		);

		draw_set_colour(c_black);

		draw_text(
			_val_x1 + (_val_slot_w * 0.5),
			_val_y1 + 12,
			string(_stct_item._str_item_name)
		);

		draw_text(
			_val_x1 + (_val_slot_w * 0.5),
			_val_y1 + 34,
			"x" + string(_stct_item._ct_item_amount)
		);

		var _stct_prism_info = scr_inventory_get_prism_info(_stct_item._str_item_id);

		if (_stct_prism_info != undefined){

			draw_text(
				_val_x1 + (_val_slot_w * 0.5),
				_val_y1 + 54,
				"+" +
					string(_stct_prism_info._val_tame_bonus) +
					"% | " +
					string(_stct_prism_info._val_mana_cost) +
					" MANA"
			);
		}
	}

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
};

//—------------------------------------------------------------------------------//
// hscr_battle_handle_prism_menu_input
// FUNCTION: Handles Prism-stack selection from the open battle Prism menu.
//—------------------------------------------------------------------------------//
hscr_battle_handle_prism_menu_input = function(){

	var _arr_prisms = hscr_battle_get_prism_stacks();

	if (array_length(_arr_prisms) <= 0){
		return;
	}

	var _val_slot_w = 150;
	var _val_slot_h = 85;
	var _val_slot_gap = 10;

	var _ct_prisms = array_length(_arr_prisms);

	var _val_total_w =
		(_ct_prisms * _val_slot_w) +
		((_ct_prisms - 1) * _val_slot_gap);

	var _val_start_x = room_width * 0.5 - (_val_total_w * 0.5);
	var _val_start_y = 520;

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	for (var _it_prism = 0; _it_prism < _ct_prisms; _it_prism++){

		var _val_x1 = _val_start_x + (_it_prism * (_val_slot_w + _val_slot_gap));
		var _val_y1 = _val_start_y;

		var _val_x2 = _val_x1 + _val_slot_w;
		var _val_y2 = _val_y1 + _val_slot_h;

		if (
			!hscr_battle_is_mouse_in_box(
				_val_mouse_x,
				_val_mouse_y,
				_val_x1,
				_val_y1,
				_val_x2,
				_val_y2
			)
		){
			continue;
		}

		_stct_selected_prism = _arr_prisms[_it_prism];

		hscr_battle_check_prism_targets();

		_state_player = ENUM_PLAYER_STATE.SELECT_PRISM_TARGET;

		return;
	}
};

//—------------------------------------------------------------------------------//
// hscr_battle_check_card_oom
// FUNCTION: Flags Cards as uncastable when Mana cost exceeds current Mana.
//—------------------------------------------------------------------------------//
hscr_battle_check_card_oom = function(_list_cards){

	var _ct_cards = ds_list_size(_list_cards);

	for (var _it_card = 0; _it_card < _ct_cards; _it_card++){

		var _ref_card = ds_list_find_value(_list_cards,_it_card);

		if (!instance_exists(_ref_card)){
			continue;
		}

		if (!is_struct(_ref_card._ref_card)){
			continue;
		}

		var _val_card_cost = _ref_card._ref_card._val_card_mana_cost;

		_ref_card._flag_card_oom_check =
			(_val_card_cost > _val_cur_mana);
	}
};

//—------------------------------------------------------------------------------//
// hscr_battle_check_beast_color
// FUNCTION: Checks whether each Beast satisfies the selected Card's Color
//           requirement.
//—------------------------------------------------------------------------------//
hscr_battle_check_beast_color = function(_list_beasts_check){

	var _arr_card_colors = global.ref_cast_card._ref_card._arr_card_colors;

	var _str_card_color_1 = _arr_card_colors[0];
	var _str_card_color_2 = _arr_card_colors[1];

	var _ct_beasts = ds_list_size(_list_beasts_check);

	for (var _it_beast = 0; _it_beast < _ct_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts_check,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		//----------------------//
		//MALLEABILITY OVERRIDE//
		//----------------------//
		if (_ref_beast._flag_ignore_caster_requirements){

			_ref_beast._flag_beast_color_check = true;

			continue;
		}

		var _arr_beast_colors = _ref_beast._ref_unit._arr_beast_colors;

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
};

//—------------------------------------------------------------------------------//
// hscr_battle_check_beast_archetype
// FUNCTION: Checks whether each Beast satisfies the selected Card's Archetype
//           requirement.
//—------------------------------------------------------------------------------//
hscr_battle_check_beast_archetype = function(_list_beasts_check){

	var _str_card_archetype =
		global.ref_cast_card._ref_card._str_card_archetype_req;

	var _ct_beasts = ds_list_size(_list_beasts_check);

	for (var _it_beast = 0; _it_beast < _ct_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts_check,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		//----------------------//
		//MALLEABILITY OVERRIDE//
		//----------------------//
		if (_ref_beast._flag_ignore_caster_requirements){

			_ref_beast._flag_beast_archetype_check = true;

			continue;
		}

		var _str_beast_archetype = _ref_beast._ref_unit._str_beast_archetype;

		_ref_beast._flag_beast_archetype_check = (
			_str_card_archetype == undefined ||
			_str_card_archetype == _str_beast_archetype
		);
	}
};

//—------------------------------------------------------------------------------//
// hscr_battle_check_beast_class
// FUNCTION: Checks whether each Beast satisfies the selected Card's Class
//           requirement.
//—------------------------------------------------------------------------------//
hscr_battle_check_beast_class = function(_list_beasts_check){

	var _str_card_class =
		global.ref_cast_card._ref_card._str_card_class_req;

	var _ct_beasts = ds_list_size(_list_beasts_check);

	for (var _it_beast = 0; _it_beast < _ct_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts_check,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		//----------------------//
		//MALLEABILITY OVERRIDE//
		//----------------------//
		if (_ref_beast._flag_ignore_caster_requirements){

			_ref_beast._flag_beast_class_check = true;

			continue;
		}

		var _str_beast_class = _ref_beast._ref_unit._str_beast_class;

		_ref_beast._flag_beast_class_check = (
			_str_card_class == undefined ||
			_str_card_class == _str_beast_class
		);
	}
};

//—------------------------------------------------------------------------------//
// hscr_battle_check_beast_range
// FUNCTION: Determines valid Beast targets for the selected player Card.
//
// FRIENDLY TARGETING:
// - SELF: Caster only.
// - Every other standard Beast range: Any living teammate, including caster.
// - Friendly targeting ignores range, Taunt, and Blind.
//
// ENEMY TARGETING:
// - MELEE: Front living enemy.
// - BACK/FLANK: Rear living enemy.
// - RANGED/ENEMY: Any living enemy.
// - SELF/TEAM: No enemy targets.
//
// HOSTILE TARGET PRIORITY:
// 1. Taunt overrides enemy range and Blind.
// 2. Blind restricts enemy targeting when no Taunt exists.
// 3. Normal range applies otherwise.
//
// Teamwide and Global effects are not redirected by Taunt.
//—------------------------------------------------------------------------------//
hscr_battle_check_beast_range = function(_list_beasts_check,_str_range){

	#region VALIDATION

	//----------------//
	//VALIDATE LISTS//
	//----------------//
	if (!ds_exists(_list_beasts_check,ds_type_list)){
		return;
	}

	if (!instance_exists(obj_battle_enemy_controller)){
		return;
	}

	var _list_enemies = obj_battle_enemy_controller._list_beasts_alive;

	if (!ds_exists(_list_enemies,ds_type_list)){
		return;
	}

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(global.ref_caster_beast)){
		return;
	}

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!instance_exists(global.ref_cast_card)){
		return;
	}

	var _stct_card = global.ref_cast_card._ref_card;

	if (!is_struct(_stct_card)){
		return;
	}

	#endregion

	#region FORMATION

	//==========================//
	//GET LIVING ENEMY FORMATION//
	//==========================//
	var _ct_enemies = ds_list_size(_list_enemies);

	var _ref_front_enemy = undefined;
	var _ref_back_enemy = undefined;

	for (var _it_enemy = 0;_it_enemy < _ct_enemies;_it_enemy++){

		var _ref_enemy = ds_list_find_value(_list_enemies,_it_enemy);

		if (!instance_exists(_ref_enemy)){
			continue;
		}

		if (
			_ref_enemy._str_list != "ALIVE" ||
			_ref_enemy._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//FRONT ENEMY//
		//----------------//
		if (!instance_exists(_ref_front_enemy)){
			_ref_front_enemy = _ref_enemy;
		}

		//--------------//
		//REAR ENEMY//
		//--------------//
		_ref_back_enemy = _ref_enemy;
	}

	#endregion

	#region FRIENDLY TARGETING

	//=========================//
	//INITIAL PLAYER TEAM FLAGS//
	//=========================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_beasts_check);_it_beast++){

		var _ref_player_beast = ds_list_find_value(_list_beasts_check,_it_beast);

		if (!instance_exists(_ref_player_beast)){
			continue;
		}

		//----------------//
		//VALIDATE LIVING//
		//----------------//
		if (
			_ref_player_beast._str_list != "ALIVE" ||
			_ref_player_beast._val_cur_hp <= 0
		){

			_ref_player_beast._flag_beast_range_check = false;

			continue;
		}

		//================//
		//CHECK CARD RANGE//
		//================//
		switch(_str_range){

			//================//
			//SELF EXCEPTION//
			//================//
			case "SELF":

				_ref_player_beast._flag_beast_range_check =
					(_ref_player_beast == global.ref_caster_beast);

			break;

			//========================//
			//UNRESTRICTED FRIENDLIES//
			//========================//
			case "MELEE":
			case "RANGED":
			case "BACK":
			case "FLANK":
			case "TEAM":
			case "ENEMY":

				_ref_player_beast._flag_beast_range_check = true;

			break;

			//===================//
			//SPECIAL CARD RANGES//
			//===================//
			default:

				_ref_player_beast._flag_beast_range_check = false;

			break;
		}
	}

	#endregion

	#region ENEMY TARGETING

	//========================//
	//INITIAL ENEMY TEAM FLAGS//
	//========================//
	for (var _it_enemy = 0;_it_enemy < _ct_enemies;_it_enemy++){

		var _ref_enemy_beast = ds_list_find_value(_list_enemies,_it_enemy);

		if (!instance_exists(_ref_enemy_beast)){
			continue;
		}

		//----------------//
		//VALIDATE LIVING//
		//----------------//
		if (
			_ref_enemy_beast._str_list != "ALIVE" ||
			_ref_enemy_beast._val_cur_hp <= 0
		){

			_ref_enemy_beast._flag_beast_range_check = false;

			continue;
		}

		//================//
		//CHECK CARD RANGE//
		//================//
		switch(_str_range){

			//================//
			//FRIENDLY RANGES//
			//================//
			case "SELF":
			case "TEAM":

				_ref_enemy_beast._flag_beast_range_check = false;

			break;

			//=======//
			//MELEE//
			//=======//
			case "MELEE":

				_ref_enemy_beast._flag_beast_range_check =
					(_ref_enemy_beast == _ref_front_enemy);

			break;

			//========//
			//RANGED//
			//========//
			case "RANGED":
			case "ENEMY":

				_ref_enemy_beast._flag_beast_range_check = true;

			break;

			//===========//
			//BACK/FLANK//
			//===========//
			case "BACK":
			case "FLANK":

				_ref_enemy_beast._flag_beast_range_check =
					(_ref_enemy_beast == _ref_back_enemy);

			break;

			//===============//
			//INVALID RANGE//
			//===============//
			default:

				_ref_enemy_beast._flag_beast_range_check = false;

			break;
		}
	}

	#endregion

	#region HOSTILE OVERRIDES

	//=======================//
	//CHECK HOSTILE TARGETING//
	//=======================//
	if (!scr_battle_is_hostile_card_target(_stct_card)){
		return;
	}

	//================//
	//TAUNT OVERRIDE//
	//================//
	var _ref_taunt_target = scr_status_get_taunt_target(_list_enemies);

	if (instance_exists(_ref_taunt_target)){

		//--------------------------//
		//RESTRICT ENEMY TEAM ONLY//
		//--------------------------//
		for (var _it_enemy = 0;_it_enemy < _ct_enemies;_it_enemy++){

			var _ref_enemy = ds_list_find_value(_list_enemies,_it_enemy);

			if (!instance_exists(_ref_enemy)){
				continue;
			}

			_ref_enemy._flag_beast_range_check =
				(_ref_enemy == _ref_taunt_target);
		}

		return;
	}

	//================//
	//BLIND OVERRIDE//
	//================//
	var _str_blind_mode = scr_cc_get_blind_attack_target_mode(
		global.ref_caster_beast,
		_stct_card
	);

	//=============//
	//BLIND BLOCK//
	//=============//
	if (_str_blind_mode == "BLOCK"){

		//--------------------------//
		//RESTRICT ENEMY TEAM ONLY//
		//--------------------------//
		for (var _it_enemy = 0;_it_enemy < _ct_enemies;_it_enemy++){

			var _ref_enemy = ds_list_find_value(_list_enemies,_it_enemy);

			if (instance_exists(_ref_enemy)){
				_ref_enemy._flag_beast_range_check = false;
			}
		}

		return;
	}

	//=============//
	//BLIND FRONT//
	//=============//
	if (_str_blind_mode == "FRONT"){

		//--------------------------//
		//RESTRICT ENEMY TEAM ONLY//
		//--------------------------//
		for (var _it_enemy = 0;_it_enemy < _ct_enemies;_it_enemy++){

			var _ref_enemy = ds_list_find_value(_list_enemies,_it_enemy);

			if (!instance_exists(_ref_enemy)){
				continue;
			}

			_ref_enemy._flag_beast_range_check =
				(_ref_enemy == _ref_front_enemy);
		}

		return;
	}

	#endregion

	//================//
	//NORMAL TARGETING//
	//================//
	// No Taunt or Blind override.
	// Retain both teams' previously assigned range flags.
};

//—------------------------------------------------------------------------------//
// hscr_battle_reroll_hand
// FUNCTION: Discards the current player hand, draws replacement Cards,
//           and refreshes Mana availability checks.
//—------------------------------------------------------------------------------//
hscr_battle_reroll_hand = function(){

	while (ds_list_size(_list_battle_hand) > 0){

		var _ref_card = ds_list_find_value(_list_battle_hand,0);

		scr_battle_discard_card(_ref_card);
	}

	scr_battle_draw_cards(_ct_draw_amount);

	hscr_battle_check_card_oom(_list_battle_hand);
};

//—------------------------------------------------------------------------------//
// hscr_battle_check_beast_able
// FUNCTION: Updates whether each Beast can currently perform actions.
//           Action-locking CC such as Stun, Sleep, and Frozen prevents acting.
//—------------------------------------------------------------------------------//
hscr_battle_check_beast_able = function(_list_beasts_check){

	var _ct_beasts = ds_list_size(_list_beasts_check);

	for (var _it_beast = 0; _it_beast < _ct_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts_check,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		_ref_beast._flag_beast_able_check =
			!scr_cc_is_action_locked(_ref_beast);
	}
};

#endregion