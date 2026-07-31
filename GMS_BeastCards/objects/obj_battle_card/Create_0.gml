//===============================================================================//
//
// CREATE: OBJ_BATTLE_CARD
// FUNCTION: Initializes a battle card instance.
//           Stores visual data, card reference, owning unit reference,
//           location state, preview state, and mana validity flag.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

// VISUAL / ID
_spr_card = undefined;
_uid_card = -1;

// TEAM / REFERENCES
_str_team = "PLAYER";
_ref_card = undefined;
_ref_unit = undefined;

// LOCATION
_str_location = "DECK"; // DECK, HAND, DISCARD, EXHAUST,

// PREVIEW / SCALE
_spr_preview_card = undefined;

_val_scale_x = 0.3;
_val_scale_y = 0.3;
_val_preview_scale = 1.0;

// CHECKS
_flag_card_oom_check = false;
_flag_card_disabled = false;
//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//