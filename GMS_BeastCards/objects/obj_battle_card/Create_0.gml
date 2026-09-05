//===============================================================================//
//
// CREATE: OBJ_BATTLE_CARD
// FUNCTION: Initializes a battle card instance.
//           Stores visual data, card references, location state,
//           presentation state, and card movement animation data.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

//-----------//
//VISUAL / ID//
//-----------//
_spr_card = undefined;
_uid_card = -1;

//-----------------//
//TEAM / REFERENCES//
//-----------------//
_str_team = "PLAYER";

_ref_card = undefined;
_ref_unit = undefined;

//--------//
//LOCATION//
//--------//
_str_location = "DECK"; // DECK, HAND, DISCARD, EXHAUST

//---------------//
//PREVIEW / SCALE//
//---------------//
_spr_preview_card = undefined;

_val_scale_x = 0.3;
_val_scale_y = 0.3;
_val_preview_scale = 1.0;

//------//
//CHECKS//
//------//
_flag_card_oom_check = false;
_flag_card_disabled = false;

//-------------------//
//BATTLE VFX TRACKING//
//-------------------//
_arr_vfx_hit_context = [];

//----------------//
//CARD MOVEMENT//
//----------------//
_flag_card_moving = false;
_flag_card_move_sfx_played = false;

_str_card_move_type = "";

_ct_card_move_timer = 0;
_ct_card_move_duration = 8;
_ct_card_move_delay = 0;

_val_card_move_start_x = 0;
_val_card_move_start_y = 0;

_val_card_move_end_x = 0;
_val_card_move_end_y = 0;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//