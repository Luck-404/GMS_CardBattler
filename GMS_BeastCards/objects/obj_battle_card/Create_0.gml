//===============================================================================//
//
// CREATE: OBJ_BATTLE_CARD
// FUNCTION: Initializes a battle Card instance.
//           Stores Card identity, ownership, location, presentation state,
//           VFX tracking, availability checks, and movement-animation data.
//
// USES:     No external inputs are required during creation. Card controllers
//           assign the Card struct, owning Beast, team, UID, and location.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

#region IDENTITY

//-----------//
//VISUAL / ID//
//-----------//
_spr_card = undefined;
_uid_card = -1;

#endregion

#region OWNERSHIP

//-----------------//
//TEAM / REFERENCES//
//-----------------//
_str_team = "PLAYER";

_ref_card = undefined;
_ref_unit = undefined;

#endregion

#region CARD STATE

//--------//
//LOCATION//
//--------//
_str_location = "DECK"; // DECK, HAND, DISCARD, EXHAUST

//------//
//CHECKS//
//------//
_flag_card_oom_check = false;
_flag_card_disabled = false;

#endregion

#region PRESENTATION

//---------------//
//PREVIEW / SCALE//
//---------------//
_spr_preview_card = undefined;

_val_scale_x = 0.3;
_val_scale_y = 0.3;
_val_preview_scale = 1.0;

//-----------------------//
//HAND HOVER / DEPTH DATA//
//-----------------------//
_val_card_hand_target_x = 528;
_val_card_hand_target_y = 956;
_val_card_rest_depth = depth;
_val_card_base_depth = depth;

//-------------------//
//BATTLE VFX TRACKING//
//-------------------//
_arr_vfx_hit_context = [];

_flag_buff_sfx_played = false;
_flag_debuff_sfx_played = false;
_flag_cc_sfx_played = false;
_flag_heal_sfx_played = false;
_flag_cleanse_sfx_played = false;
_flag_aura_sfx_played = false;

#endregion

#region CARD MOVEMENT

//----------------//
//MOVEMENT STATE//
//----------------//
_flag_card_moving = false;
_flag_card_move_sfx_played = false;

_str_card_move_type = "";

//---------------//
//MOVEMENT TIMING//
//---------------//
_ct_card_move_timer = 0;
_ct_card_move_duration = 8;
_ct_card_move_delay = 0;

//------------------//
//MOVEMENT POSITIONS//
//------------------//
_val_card_move_start_x = 0;
_val_card_move_start_y = 0;

_val_card_move_end_x = 0;
_val_card_move_end_y = 0;

//--------------------------//
//MOVEMENT SCALE / FLIP DATA//
//--------------------------//
_val_card_move_progress = 0;
_val_card_move_scale_start = 0.08;
_val_card_move_scale_end = 0.30;
_flag_card_move_flip = false;
_arr_card_move_queue = [];

#endregion

//----//
//INIT//
//----//
// The obj_battle_card asset already uses spr_battle_card_hitbox as its sprite.
// Do not replace sprite_index, assign mask_index, or rescale image_xscale/y.
// The associated Card artwork remains in _spr_card and is drawn separately.

//-------//
//METHODS//
//-------//
