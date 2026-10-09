//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_HONEYED_SCENT
// FUNCTION: Resolves Honeyed Scent.
//           Applies its Team Aura using the caster as the source Beast.
//           GLOBAL targeting selects no Beast, so the GLOBAL target string is
//           deliberately not forwarded into Aura application.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the GLOBAL cast target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_honeyed_scent(_stct_card,_ref_caster,_ref_target){

	scr_status_apply_aura(
		"HONEYED_SCENT",
		_ref_caster,
		_stct_card._val_card_magnitude
	);
}
