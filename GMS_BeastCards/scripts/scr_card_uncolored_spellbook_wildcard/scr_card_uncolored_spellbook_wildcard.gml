//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_SPELLBOOK_WILDCARD
// FUNCTION: Resolves the Spellbook Wildcard card effect.
//           Applies five randomly selected Bleed or Burn damage-over-time effects.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_uncolored_spellbook_wildcard(_stct_card,_ref_caster,_ref_target){

//---------------//
//DISH OUT 5 DOTS//
//---------------//
repeat (5){
	var _dot = choose("BLEED","BURN","POISON","VENOM","FROSTBURN","STORMSTRUCK","FROSTBITE");
	scr_apply_dot_status(_dot);
}

//----------------//
//PLAY ANIMATION//
//----------------//

//-----------//
//PLAY SOUND//
//-----------//
audio_play_sound(snd_debuff,0,false);

}