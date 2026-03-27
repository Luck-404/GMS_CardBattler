//////////////////////////////////////////////////////////////////////
//							OBJ_CARD CREATE							//
//																	//
// > HANDLE MAKING THE CARD REF INTO AN OBJ CARD- CARRY OVER THESE  //
//   DEFINITIONS													//
//////////////////////////////////////////////////////////////////////
//BASIC DEFINITIONS
_card_name = undefined; //name on card
_card_desc = undefined; //desc
_card_cost = undefined; //how much mana
_card_script = undefined; //attached logic in combat
_card_sprite = undefined; //sprite for the card
_card_color = undefined; //color of card
_card_type = undefined; //Utility, Powerup, Debuff, Attack, Defense
_card_spec_req = undefined; //Martial, Technical, or Magical locked? or locked behind a certain subspec?
_card_class_req = undefined; //ALL CLASSES
_card_range = undefined; //range of the card
_card_ref = undefined; //REFERENCE TO THE ACTUAL CARD DEFINITION
_card_target_count = 0;

//FLAGS
_flag_targetless = false; //IF THE CARD IS TARGETLESS OR NOT
_reward = false; //USED BY OBJ_ENC_REWARDS TO DISPLAY THE CARDS
_active = true; //AM I ACTIVE?
_selected = false; //AM I SELECTED?
_list = undefined; //DECK, HAND, DISCARD, EXHAUST
