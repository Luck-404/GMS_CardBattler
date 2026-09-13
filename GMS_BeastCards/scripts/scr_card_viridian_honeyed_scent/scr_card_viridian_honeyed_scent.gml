//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_HONEYED_SCENT
// FUNCTION: Resolves Honeyed Scent.
//           Applies an encounter-long Team Aura to the caster.
//           Allied Attack casts summon Wasp Drones while the Aura remains active.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_honeyed_scent(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY AURA//
	//================//
	scr_status_apply_aura("HONEYED_SCENT",_stct_card._val_card_magnitude);
}