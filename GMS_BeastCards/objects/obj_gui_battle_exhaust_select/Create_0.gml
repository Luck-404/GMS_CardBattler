//===============================================================================//
//
// CREATE: OBJ_GUI_BATTLE_EXHAUST_SELECT
// FUNCTION: Initializes a modal selection pane for exhausted Cards.
//           Stores eligible Cards and supports multiple selection pages.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

//-------//
//DISPLAY//
//-------//
depth = -10000;

//----------------//
//CARD SELECTION//
//----------------//
_arr_candidates = [];

_str_color = "VERMILION";
_ref_excluded_card = undefined;

_ct_page = 0;
_ct_rows_per_column = 12;
_ct_page_size = 24;

//------//
//PANE//
//------//
_val_pane_w = 680;
_val_pane_h = 570;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

//------//
//LIST//
//------//
_val_slot_w = 300;
_val_slot_h = 24;

_val_slot_gap_x = 12;
_val_slot_gap_y = 8;

_val_list_x = _val_pane_left + 30;
_val_list_y = _val_pane_top + 92;

//------//
//INPUT//
//------//
_flag_clicked = false;

#endregion

//----//
//INIT//
//----//
#region INIT
#endregion

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_gui_init_exhaust_select
// FUNCTION: Assigns the eligible exhausted Cards and selection constraints.
//—------------------------------------------------------------------------------//
hscr_gui_init_exhaust_select = function(_arr_cards,_str_required_color,_ref_excluded=undefined){

	_arr_candidates = _arr_cards;

	_str_color = _str_required_color;
	_ref_excluded_card = _ref_excluded;

	_ct_page = 0;
};

//—------------------------------------------------------------------------------//
// hscr_gui_finish_exhaust_select
// FUNCTION: Restores the appropriate player state after recovery completes.
//           Preserves queued Tutor and Card-discard effects.
//—------------------------------------------------------------------------------//
hscr_gui_finish_exhaust_select = function(){

	if (!instance_exists(obj_battle_player_controller)){
		instance_destroy();
		return;
	}

	var _ref_player = obj_battle_player_controller;

	_ref_player._ct_rekindle_pending = 0;
	_ref_player._ref_rekindle_source_card = undefined;

	//================//
	//PENDING TUTOR//
	//================//
	if (_ref_player._ct_utility_tutors_pending > 0){

		if (_ref_player.hscr_battle_open_utility_tutor()){

			_ref_player._state_player = ENUM_PLAYER_STATE.TUTOR_SELECT;

			instance_destroy();

			return;
		}
	}

	//================//
	//PENDING DISCARD//
	//================//
	if (
		_ref_player._ct_effect_discards_pending > 0 &&
		ds_list_size(_ref_player._list_battle_hand) > 0
	){

		_ref_player._state_player = ENUM_PLAYER_STATE.DISCARD_EFFECT;

		scr_gui_spawn_popup_error(
			"DISCARD " + string(_ref_player._ct_effect_discards_pending) + " CARDS",
			1000000000
		);
	}

	//================//
	//NORMAL CARD FLOW//
	//================//
	else{

		_ref_player._ct_effect_discards_pending = 0;

		_ref_player._state_player = ENUM_PLAYER_STATE.SELECT_CARD;

		_ref_player.hscr_battle_check_card_oom(
			_ref_player._list_battle_hand
		);
	}

	instance_destroy();
};

#endregion