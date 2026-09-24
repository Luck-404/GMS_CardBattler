//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_SANGUINE_SONG
// FUNCTION: Grants 1 Rage, sacrifices 10% of caster Maximum HP, then gains
//           1 Echo.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is unused for this Global Card.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_sanguine_song(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN 1 RAGE//
	//================//
	scr_status_gain_rage(_ref_caster,1);

	//===================//
	//SACRIFICE 10% HP//
	//===================//
	scr_battle_sacrifice(
		"HOST_HEALTH",
		_ref_caster,
		10,
		{percent_max_hp: true}
	);

	//================//
	//GAIN 1 ECHO//
	//================//
	scr_status_gain_echo(1);
}